
// // corrected one

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ChatbotPage extends StatefulWidget {
//   @override
//   _ChatbotPageState createState() => _ChatbotPageState();
// }

// class _ChatbotPageState extends State<ChatbotPage> {
//   String currentStep = "topics"; // Tracks the current step: "topics", "questions", or "answer"
//   List<String> topics = [];
//   List<String> questions = [];
//   String selectedTopic = "";
//   String selectedQuestion = "";
//   String answer = "";

//   @override
//   void initState() {
//     super.initState();
//     fetchTopics(); // Fetch topics when the page loads
//   }

//   Future<void> fetchTopics() async {
//     try {
//       final response = await http.get(Uri.parse('http://192.168.238.74:5000/topics'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           topics = List<String>.from(data['topics']);
//         });
//       } else {
//         print('Error: ${response.statusCode} - ${response.body}');
//         throw Exception('Failed to load topics');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> fetchQuestions(String topic) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.238.74:5000/questions'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'topic': topic}),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           questions = List<String>.from(data['questions']);
//           currentStep = "questions";
//           selectedTopic = topic;
//         });
//       } else {
//         print('Error: ${response.statusCode} - ${response.body}');
//         throw Exception('Failed to load questions');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> fetchAnswer(String question) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.238.74:5000/answer'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'question': question}),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           answer = data['response']; // Fixed key from 'answer' to 'response'
//           currentStep = "answer";
//           selectedQuestion = question;
//         });
//       } else {
//         print('Error: ${response.statusCode} - ${response.body}');
//         throw Exception('Failed to load answer');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chatbot')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: currentStep == "topics"
//             ? buildTopics()
//             : currentStep == "questions"
//                 ? buildQuestions()
//                 : buildAnswer(),
//       ),
//     );
//   }

//   Widget buildTopics() {
//     return ListView.builder(
//       itemCount: topics.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(topics[index]),
//           onTap: () {
//             fetchQuestions(topics[index]); // Fetch questions for the selected topic
//           },
//         );
//       },
//     );
//   }

//   Widget buildQuestions() {
//     return ListView.builder(
//       itemCount: questions.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(questions[index]),
//           onTap: () {
//             fetchAnswer(questions[index]); // Fetch answer for the selected question
//           },
//         );
//       },
//     );
//   }

//   Widget buildAnswer() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Topic: $selectedTopic', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         SizedBox(height: 10),
//         Text('Question: $selectedQuestion', style: TextStyle(fontSize: 16)),
//         SizedBox(height: 20),
//         Text('Answer: $answer', style: TextStyle(fontSize: 16)),
//         SizedBox(height: 30),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               currentStep = "topics"; // Reset to topics step
//               questions = [];
//               answer = "";
//             });
//           },
//           child: Text('Back to Topics'),
//         ),
//       ],
//     );
//   }
// }



















import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  Future<void> sendMessage(String message) async {
    setState(() {
      messages.add({"sender": "user", "message": message});
    });

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.238.74:5000/chat'), // Replace with your Flask API URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"message": message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          messages.add({"sender": "bot", "message": data["response"]});
        });
      } else {
        setState(() {
          messages.add({
            "sender": "bot",
            "message": "Error: Unable to connect to chatbot."
          });
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"sender": "bot", "message": "Error: $e"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
        backgroundColor: Colors.green[800],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message["sender"] == "user"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message["sender"] == "user"
                          ? Colors.green[100]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message["message"] ?? ""),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
