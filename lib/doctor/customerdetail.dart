import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prakriti_finder/chat_app/chat_service.dart';
import 'package:prakriti_finder/chat_app/chatscreen.dart';

class CustomerDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> customerDetails;

  const CustomerDetailPage({super.key, required this.customerDetails});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = customerDetails.data() as Map<String, dynamic>;
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        title: Text(data['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.textsms_outlined),
            onPressed: () async {
              if (user != null) {
                String chatId = await ChatService().initializeChat(user.uid, customerDetails.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(chatId: chatId, name: data['name']),
                  ),
                );
              } else {
                // Handle the case when the user is not logged in
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Handle call action
            },
          ),
        ],// Updated color for the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Customer details card
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
                        'Gender: ${data['gender']}',
                        style: const TextStyle(
                          color: Color(0xFF4A545E),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Age: ${data['age']}',
                        style: const TextStyle(
                          color: Color(0xFF4A545E),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Email: ${data['email']}',
                        style: const TextStyle(
                          color: Color(0xFF4A545E),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Address: ${data['address']}',
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
            ],
          ),
        ),
      ),
    );
  }
}
