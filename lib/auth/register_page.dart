import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prakriti_finder/auth/login_page.dart';
import 'package:prakriti_finder/components/my_button.dart';
import 'package:prakriti_finder/components/my_textfield.dart';
import 'package:prakriti_finder/customer/c_initialpage.dart';
import 'package:prakriti_finder/doctor/d_initialpage.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  final clinicAddressController = TextEditingController();
  final clinicNameController = TextEditingController();
  final certificateUrlController = TextEditingController();
  bool isDoctor = false;

  Future<void> registerUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      String uid = userCredential.user!.uid;
      String userType = isDoctor ? 'Doctors' : 'Customers';

      // Save user info in Firestore
      if (isDoctor) {
        await FirebaseFirestore.instance.collection(userType).doc(uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'age': ageController.text,
          'gender': genderController.text,
          'clinic_address': clinicAddressController.text,
          'clinic_name': clinicNameController.text,
          'certificate_url': certificateUrlController.text,
        });
      } else {
        await FirebaseFirestore.instance.collection(userType).doc(uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'age': ageController.text,
          'gender': genderController.text,
          'address': addressController.text,
        });
      }

      // Redirect based on user type
      if (isDoctor) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DoctorInitialPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Quizzler()),
        );
      }
    } on FirebaseAuthException catch (e) {
      showErrorDialog(e.message ?? 'Registration error');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text(message)),
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
                Text(isDoctor ? 'Register as Doctor' : 'Register as Customer', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[900])),
                const SizedBox(height: 30),
                MyTextField(controller: nameController, hintText: 'Name', obscureText: false),
                const SizedBox(height: 10),
                MyTextField(controller: emailController, hintText: 'Email', obscureText: false),
                const SizedBox(height: 10),
                MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
                const SizedBox(height: 10),
                MyTextField(controller: ageController, hintText: 'Age', obscureText: false),
                const SizedBox(height: 10),
                MyTextField(controller: genderController, hintText: 'Gender', obscureText: false),
                const SizedBox(height: 10),
                if (isDoctor) ...[
                  MyTextField(controller: clinicAddressController, hintText: 'Clinic Address', obscureText: false),
                  const SizedBox(height: 10),
                  MyTextField(controller: clinicNameController, hintText: 'Clinic Name', obscureText: false),
                  const SizedBox(height: 10),
                  MyTextField(controller: certificateUrlController, hintText: 'Certificate URL', obscureText: false),
                ] else ...[
                  MyTextField(controller: addressController, hintText: 'Address', obscureText: false),
                ],
                const SizedBox(height: 25),
                MyButton(onTap: registerUser, buttontext: 'Register'),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Register as: ', style: const TextStyle(fontSize: 16)),
                    Switch(
                      value: isDoctor,
                      onChanged: (value) {
                        setState(() {
                          isDoctor = value;
                        });
                      },
                    ),
                    Text(isDoctor ? 'Doctor' : 'Customer', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(showRegisterPage: (){})));},
                  child: Text('Already have an account? Login', style: TextStyle(color: Colors.green[900], fontSize: 18, fontWeight: FontWeight.bold)),
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
