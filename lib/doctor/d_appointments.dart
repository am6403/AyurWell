import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManageAppointments extends StatelessWidget {
  const ManageAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    User? doctor = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Manage Appointments',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF23374D),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Appointments')
                .where('doctor_id', isEqualTo: doctor?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No appointments found.'));
              }

              // Separate appointments by status
              var pendingAppointments = snapshot.data!.docs.where((doc) => doc['status'] == 'pending').toList();
              var acceptedAppointments = snapshot.data!.docs.where((doc) => doc['status'] == 'accept').toList();
              var rejectedAppointments = snapshot.data!.docs.where((doc) => doc['status'] == 'reject').toList();

              return ListView(
                children: [
                  if (pendingAppointments.isNotEmpty) _buildSection(context, 'Pending', pendingAppointments),
                  if (acceptedAppointments.isNotEmpty) _buildSection(context, 'Accepted', acceptedAppointments),
                  if (rejectedAppointments.isNotEmpty) _buildSection(context, 'Rejected', rejectedAppointments),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String sectionTitle, List<DocumentSnapshot> appointments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: appointments.map((doc) {
            Map<String, dynamic> appointmentData = doc.data() as Map<String, dynamic>;
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('Customers').doc(appointmentData['customer_id']).get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                String customerName = snapshot.data!['name'] ?? 'Unknown';
                String email = snapshot.data!['email'] ?? 'No email available';
                String appointmentNotes = appointmentData['appointment_notes'] ?? 'No note provided';
                
                return _appointmentCard(context, appointmentData, doc.id, customerName, email, appointmentNotes);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _appointmentCard(BuildContext context, Map<String, dynamic> appointmentData, String docId, String customerName, String email, String appointmentNotes) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.person,
          size: 40,
          color: Color(0xFF23374D),
        ),
        title: Text(
          'Customer: $customerName',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: $email'),
            Text('Note: $appointmentNotes'),
            Text('Date: ${appointmentData['date']} | Time: ${appointmentData['time']}'),
          ],
        ),
        trailing: appointmentData['status'] == 'pending'
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _actionButton(context, 'accept', docId, Colors.green),
                  const SizedBox(width: 10),
                  _actionButton(context, 'reject', docId, Colors.red),
                ],
              )
            : null,
      ),
    );
  }

  Widget _actionButton(BuildContext context, String label, String docId, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onPressed: () => _updateStatus(docId, label.toLowerCase()),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
        ),
      ),
    );
  }

  Future<void> _updateStatus(String docId, String status) async {
    await FirebaseFirestore.instance.collection('Appointments').doc(docId).update({
      'status': status,
      'last_updated': FieldValue.serverTimestamp(),
    });
  }
}
