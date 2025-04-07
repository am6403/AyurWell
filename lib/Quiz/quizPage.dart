import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prakriti_finder/Quiz/quizbrain.dart';
import 'package:prakriti_finder/quiz/optionbrain.dart'; // Import OptionBrain
import 'package:prakriti_finder/pages/exercise_page.dart'; // Import ExercisePage
import 'package:prakriti_finder/pages/diet_page.dart'; // Import DietPage
import 'package:prakriti_finder/customer/doctors.dart'; // Import Doctors page

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int i = 1;
  bool quizStarted = false;
  QuizBrain quizbrain = QuizBrain();
  OptionBrain optionbrain = OptionBrain(); // Create OptionBrain instance
  String userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
  List<int> answers = [];

  @override
  void initState() {
    super.initState();
    checkExistingDosha();
  }

  void checkExistingDosha() async {
    if (userId != 'guest') {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists && userDoc.data() != null && userDoc['dosha'] != null) {
        String doshaName = userDoc['dosha'];
        showResultDialog(doshaName);
      }
    }
  }

  String displayquesNo(int questionNumber) {
    return "Question $questionNumber: ";
  }

  Future<void> submitQuiz() async {
    print("Answers being sent: $answers"); // Debug print
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/predict'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'features': answers,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final dosha = result['dosha'];
        String doshaName = ""; // Declare doshaName here
        if (dosha == 0) {
          doshaName = "Kapha";
        } else if (dosha == 1) {
          doshaName = "Pitta";
        } else if (dosha == 2) {
          doshaName = "Vata";
        } else {
          doshaName = "Unknown"; // Handle unexpected values
        }
        saveDoshaResult(doshaName); // Save dosha result to Firestore
        showResultDialog(doshaName); // Pass doshaName to showResultDialog
      } else {
        print("API Error: Status code ${response.statusCode}");
        print("API Error: Response body ${response.body}");
        showErrorDialog(
            "Failed to get prediction. Status code: ${response.statusCode}"); // Show error to user
      }
    } catch (e) {
      print("Exception during API call: $e");
      showErrorDialog(
          "An error occurred while submitting the quiz. Error: $e"); // Show error to user
    }
  }

  void saveDoshaResult(String doshaName) async {
    if (userId != 'guest') {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'dosha': doshaName,
      }, SetOptions(merge: true));
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void showResultDialog(String doshaName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Your Dosha'),
        content: Text('Your dosha is: $doshaName'),
        actions: <Widget>[
          TextButton(
            child: Text('Show Exercise'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              navigateToExercise(doshaName); // Navigate to exercise page
            },
          ),
          TextButton(
            child: Text('Show Diet'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              navigateToDiet(doshaName); // Navigate to diet page
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              navigateToDoctors(); // Navigate to doctors page
            },
          ),
        ],
      ),
    );
  }

  void navigateToExercise(String doshaName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExercisePage(doshaName: doshaName),
      ),
    ).then((_) {
      showResultDialog(doshaName); // Show the dialog again when returning
    });
  }

  void navigateToDiet(String doshaName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DietPage(doshaName: doshaName),
      ),
    ).then((_) {
      showResultDialog(doshaName); // Show the dialog again when returning
    });
  }

  void navigateToDoctors() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Doctorlist(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prakriti Assessment"),
        backgroundColor: const Color.fromARGB(255, 240, 158, 84),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Center(
                child: quizStarted
                    ? Text(
                        "${displayquesNo(i)}${quizbrain.getQuestionText(i - 1)}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      )
                    : const Text(
                        "Welcome to the Prakriti Assessment! \nTap below to start.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            if (!quizStarted)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    quizStarted = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Start Quiz'),
              ),
            if (quizStarted)
              Column(
                children: [
                  // Dynamically generate option buttons
                  ...(List<int>.generate(3, (index) => index))
                      .map((optionNumber) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            answers.add(optionNumber + 1); // Store the *option number*
                            if (i < quizbrain.getQuestionCount()) {
                              i++;
                            } else {
                              submitQuiz();
                            }
                          });
                        },
                        child: Text(optionbrain.getOptionText(i - 1, optionNumber)), // Get option text
                      ),
                    );
                  }).toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}