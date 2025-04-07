import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chatbot_questions_screen.dart';

class ChatbotTopicsScreen extends StatefulWidget {
  @override
  _ChatbotTopicsScreenState createState() => _ChatbotTopicsScreenState();
}

class _ChatbotTopicsScreenState extends State<ChatbotTopicsScreen> {
  List<String> topics = [];

  @override
  void initState() {
    super.initState();
    fetchTopics();
  }

  Future<void> fetchTopics() async {
    final response = await http.get(Uri.parse('http://<your-ip>:5000/topics'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        topics = List<String>.from(data['topics']);
      });
    } else {
      throw Exception('Failed to load topics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chatbot Topics')),
      body: topics.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(topics[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatbotQuestionsScreen(topic: topics[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}