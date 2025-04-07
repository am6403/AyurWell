import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chatbot_chat_screen.dart';

class ChatbotQuestionsScreen extends StatefulWidget {
  final String topic;

  ChatbotQuestionsScreen({required this.topic});

  @override
  _ChatbotQuestionsScreenState createState() =>
      _ChatbotQuestionsScreenState();
}

class _ChatbotQuestionsScreenState extends State<ChatbotQuestionsScreen> {
  List<String> questions = [];

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response = await http.post(
      Uri.parse('http://<your-ip>:5000/questions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'topic': widget.topic}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        questions = List<String>.from(data['questions']);
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.topic)),
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(questions[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatbotChatScreen(question: questions[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}