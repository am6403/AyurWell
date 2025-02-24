import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About the App'),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 20),
            
            SizedBox(height: 10),
            Text(
              'This app helps customers connect with doctors directly. It allows you to view doctor details, '
              'initiate chats, and manage appointments efficiently. Whether you are a doctor looking to '
              'provide virtual consultations or a customer seeking professional health advice, this app '
              'offers a seamless experience for both users. Stay connected and stay healthy!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
