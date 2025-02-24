import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prakriti_finder/Quiz/quizbrain.dart';
import 'package:prakriti_finder/quiz/optionbrain.dart'; 
import 'package:prakriti_finder/pages/exercise_page.dart'; 
import 'package:prakriti_finder/pages/diet_page.dart'; 
import 'package:prakriti_finder/customer/doctors.dart'; 

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int i = 1;
  bool quizStarted = false;
  QuizBrain quizbrain = QuizBrain();
  OptionBrain optionbrain = OptionBrain(); 
  String userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
  List<int> answers = [];

  String displayquesNo(int questionNumber) {
    return "Question $questionNumber: ";
  }

  Future<void> submitQuiz() async {
    print("Answers being sent: $answers"); 
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
        String doshaName = ""; 
        if (dosha == 0) {
          doshaName = "Kapha";
        } else if (dosha == 1) {
          doshaName = "Pitta";
        } else if (dosha == 2) {
          doshaName = "Vata";
        } else {
          doshaName = "Unknown"; 
        }
        showResultDialog(doshaName); 
      } else {
        print("API Error: Status code ${response.statusCode}");
        print("API Error: Response body ${response.body}");
        showErrorDialog(
            "Failed to get prediction. Status code: ${response.statusCode}"); 
      }
    } catch (e) {
      print("Exception during API call: $e");
      showErrorDialog(
          "An error occurred while submitting the quiz. Error: $e"); 
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
              Navigator.of(context).pop(); 
              navigateToExercise(doshaName); 
            },
          ),
          TextButton(
            child: Text('Show Diet'),
            onPressed: () {
              Navigator.of(context).pop(); 
              navigateToDiet(doshaName); 
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); 
              navigateToDoctors(); 
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
      showResultDialog(doshaName); 
    });
  }

  void navigateToDiet(String doshaName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DietPage(doshaName: doshaName),
      ),
    ).then((_) {
      showResultDialog(doshaName); 
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
                  
                  ...(List<int>.generate(3, (index) => index))
                      .map((optionNumber) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            answers.add(
                                optionNumber + 1); 
                            if (i < quizbrain.getQuestionCount()) {
                              i++;
                            } else {
                              submitQuiz();
                            }
                          });
                        },
                        child: Text(optionbrain.getOptionText(
                            i - 1, optionNumber)), 
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
