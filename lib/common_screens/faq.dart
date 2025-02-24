import 'package:flutter/material.dart';

class FaqForDoctors extends StatelessWidget {
  const FaqForDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor FAQs'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          FaqItem(
            question: 'How do I update my clinic details?',
            answer: 'Go to your profile and click on "Edit Clinic Information".',
          ),
          FaqItem(
            question: 'How do I manage my appointments?',
            answer: 'You can manage appointments from the "Manage Appointments" section.',
          ),
          FaqItem(
            question: 'Can I register multiple clinics?',
            answer: 'Currently, only one clinic can be registered per account.',
          ),
        ],
      ),
    );
  }
}

class FaqForCustomers extends StatelessWidget {
  const FaqForCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer FAQs'),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          FaqItem(
            question: 'How do I book an appointment?',
            answer: 'Go to the "Doctors" section and click on "Book Appointment".',
          ),
          FaqItem(
            question: 'Can I reschedule an appointment?',
            answer: 'Yes, you can reschedule appointments from your "Appointments" tab.',
          ),
          FaqItem(
            question: 'How do I find Ayurvedic clinics near me?',
            answer: 'Use the "Nearby Clinics" feature to locate clinics close to you.',
          ),
        ],
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              answer,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
