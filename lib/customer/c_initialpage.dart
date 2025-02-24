import 'package:flutter/material.dart';
import 'package:prakriti_finder/Diet/DietKapha.dart';
import 'package:prakriti_finder/Diet/DietPitta.dart';
import 'package:prakriti_finder/Diet/DietVata.dart';
import 'package:prakriti_finder/Quiz/Prakriti.dart';
import 'package:prakriti_finder/Yoga/YogaKapha.dart';
import 'package:prakriti_finder/Yoga/YogaPitta.dart';
import 'package:prakriti_finder/Yoga/YogaVata.dart';
import 'package:prakriti_finder/Quiz/optionbrain.dart';
import 'package:prakriti_finder/Quiz/quizPage.dart';
import 'package:prakriti_finder/Quiz/quizbrain.dart';
import 'package:prakriti_finder/customer/c_profile.dart';
import 'package:prakriti_finder/customer/doctors.dart';
import 'package:prakriti_finder/doctor/remedies_page.dart';
import 'package:prakriti_finder/pages/exercise_page.dart'; 
import 'package:prakriti_finder/pages/diet_page.dart'; 

QuizBrain quizBrain = QuizBrain();
OptionBrain optionBrain = OptionBrain();
Quizzler quizzler = Quizzler();

class Quizzler extends StatefulWidget {
  const Quizzler({super.key});

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    QuizPage(),
    Doctorlist(),
    RemediesPage(userType: 'Customer',),
    CustomerProfile()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "prakriti": (context) => const Prakriti(),
        "dietkapha": (context) => DietKapha(),
        "dietvata": (context) => DietVata(),
        "dietpitta": (context) => DietPitta(),
        "yogakapha": (context) => YogaKapha(),
        "yogavata": (context) => YogaVata(),
        "yogapitta": (context) => YogaPitta(),
        "exercise": (context) => ExercisePage(doshaName: ''), 
        "diet": (context) => DietPage(doshaName: ''), 
      },
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 214, 204, 198),
        body: SafeArea(
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 37, 100, 38), 
          selectedItemColor: Color.fromARGB(255, 240, 230, 50), 
          unselectedItemColor: Colors.white, 
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: 'Questionnaire',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: 'Doctors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.healing),
              label: 'Remedies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.verified_user),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}