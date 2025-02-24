import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prakriti_finder/chat_app/chat_service.dart';
import 'package:prakriti_finder/chat_app/chatscreen.dart';

class DoctorDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> doctorDetails;

  const DoctorDetailPage({super.key, required this.doctorDetails});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = doctorDetails.data() as Map<String, dynamic>;
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        title: Text(data['name'],style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.textsms_outlined,color: Colors.white,),
            onPressed: () async {
              if (user != null) {
                String chatId = await ChatService().initializeChat(user.uid, doctorDetails.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(chatId: chatId, name: data['name']),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.call,color: Colors.white,),
            onPressed: () {
              // Handle call action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${data['name']}',
                        style: const TextStyle(
                          color: Color(0xFF4A545E),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Email Id: ${data['email']}',
                        style: const TextStyle(
                          color: Color(0xFF4A545E),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Clinic Name: ${data['clinic_name']}',
                        style: const TextStyle(
                          color: Color(0xFF4A545E),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Clinic Address: ${data['clinic_address']}',
                        style: const TextStyle(
                          color: Color(0xFF4A545E),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 200),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showBookingDialog(context, data['name']);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 25, 139, 30),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: const Text(
                      'Book Appointment',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBookingDialog(BuildContext context, String doctorName) {
    final dateController = TextEditingController();
    final timeController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Book Appointment with Dr. $doctorName'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Select Date'),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
                    }

                  },
                  readOnly: true,
                ),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(labelText: 'Select Time'),
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      timeController.text = selectedTime.format(context);
                    }
                  },
                  readOnly: true,
                ),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'Appointment Notes (optional)'),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _bookAppointment(
                  context,
                  dateController.text,
                  timeController.text,
                  notesController.text,
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _bookAppointment(
    BuildContext context,
    String date,
    String time,
    String notes,
  ) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final appointmentRef = FirebaseFirestore.instance.collection('Appointments').doc();

      await appointmentRef.set({
        'appointment_id': appointmentRef.id,
        'doctor_id': doctorDetails.id,
        'customer_id': user.uid,
        'date': date,
        'time': time,
        'status': 'pending',
        'appointment_notes': notes,
        'last_updated': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context); // Close the dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment request sent successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in. Please log in to continue.')),
      );
    }
  }
}
