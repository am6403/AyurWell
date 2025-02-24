import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prakriti_finder/auth/register_page.dart';
import 'package:prakriti_finder/components/my_button.dart';
import 'package:prakriti_finder/components/my_textfield.dart';
import 'package:prakriti_finder/customer/c_initialpage.dart';
import 'package:prakriti_finder/doctor/d_initialpage.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUserIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      String uid = userCredential.user!.uid;

      // Check if user is doctor
      bool isDoctor = await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(uid)
          .get()
          .then((doc) => doc.exists);

      Navigator.pop(context); // Close loading dialog

      // Redirect based on user type
      if (isDoctor) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DoctorInitialPage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Quizzler()),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        showErrorDialog('User not found. Please register.');
      } else if (e.code == 'wrong-password') {
        showErrorDialog('Incorrect password. Please try again.');
      }
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 187, 221, 188),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.spa, size: 100, color: Colors.green),
                const SizedBox(height: 20),
                Text('PrakritiPath',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900])),
                const SizedBox(height: 30),
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(height: 10),
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(height: 25),
                MyButton(onTap: signUserIn, buttontext: 'Sign In'),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              RegisterPage(showLoginPage: () {})),
                    );
                  },
                  child: Text('Not a member? Register now',
                      style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



