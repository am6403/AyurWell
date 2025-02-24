import 'package:flutter/material.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back, Doctor!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Today’s Appointments:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            // This is where you can add a list of upcoming appointments
            const SizedBox(height: 10),
            Text(
              'You have 3 upcoming appointments today.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tasks:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            // Display a list of tasks or quick actions
            Text(
              '• Review patient Prakriti assessments',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• Respond to new patient requests',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
