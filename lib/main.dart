import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prakriti_finder/auth/register_page.dart';
import 'package:prakriti_finder/chatbot_topics_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AyurWell',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      routes: {
        '/register': (context) => RegisterPage(showLoginPage: () {}),
        '/chatbot': (context) => ChatbotTopicsScreen(), // Add route for chatbot
      },
      home: RegisterPage(
        showLoginPage: () {},
      ),
    );
  }
}
