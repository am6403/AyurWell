import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotChatScreen extends StatefulWidget {
  final String question;

  ChatbotChatScreen({required this.question});

  @override
  _ChatbotChatScreenState createState() => _ChatbotChatScreenState();
}

class _ChatbotChatScreenState extends State<ChatbotChatScreen> {
  String response = '';

  @override
  void initState() {
    super.initState();
    fetchResponse();
  }

  Future<void> fetchResponse() async {
    final response = await http.post(
      Uri.parse('http://<your-ip>:5000/answer'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'question': widget.question}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        this.response = data['answer'];
      });
    } else {
      throw Exception('Failed to load response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chatbot Response')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You: ${widget.question}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Bot: $response', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}