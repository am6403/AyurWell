import 'dart:io'; // Ensure this import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prakriti_finder/auth/login_page.dart';
import 'package:prakriti_finder/common_screens/aboutme.dart';
import 'package:prakriti_finder/common_screens/faq.dart';
import 'package:prakriti_finder/components/getuserdetail.dart';
import 'package:prakriti_finder/components/profile_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  String? profileImageURL;
  late String doctorName = '';
  File? imagefile;

  @override
  void initState() {
    super.initState();
    getDoctorName().then((value) {
      setState(() {
        doctorName = value;
      });
    });
    loadProfileImageURL();
  }

  Future<void> loadProfileImageURL() async {
    profileImageURL = await ImageHandler.loadProfileImageURL(context, 'Doctors');
    setState(() {});
  }

  Future<void> resetQuizResult(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'dosha': FieldValue.delete(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Quiz result has been reset.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in. Please log in to continue.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F6E7), // Light green background
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  ImageHandler.showPhotoOptions(context, 'Doctors');
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 37, 100, 38),
                  backgroundImage: (imagefile != null)
                      ? FileImage(imagefile!)
                      : (profileImageURL != null
                          ? NetworkImage(profileImageURL!)
                          : null) as ImageProvider?,
                  child: (imagefile == null && profileImageURL == null)
                      ? const Icon(
                          Icons.person,
                          size: 50,
                          color:Color.fromARGB(255, 201, 220, 197),// Dark green for icon
                        )
                      : null,
                ),
              ),
              Text(
                doctorName,
                style: const TextStyle(
                  color:Color.fromARGB(255, 25, 45, 20), // Dark green for text
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 50),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color:Color.fromARGB(255, 25, 45, 20),), // Dark green border
                    ),
                  ),
                ),
                onPressed: () {
                  // Add appointment booking logic here
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.chat_bubble,
                      color: Color.fromARGB(255, 25, 45, 20),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Talk with our Chatbot",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(
                            255, 25, 45, 20), // Dark green for text
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 50),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color:Color.fromARGB(255, 25, 45, 20),),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.info,
                      color:Color.fromARGB(255, 25, 45, 20),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "About Us",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:Color.fromARGB(255, 25, 45, 20),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 50),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Color.fromARGB(255, 25, 45, 20),)
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FaqForDoctors()));
                
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.input,
                      color:Color.fromARGB(255, 25, 45, 20),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "FAQs",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 25, 45, 20),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 50),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Color.fromARGB(255, 211, 15, 15)), // Red border for logout
                    ),
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginPage(showRegisterPage: () {}),
                  ));
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Color.fromARGB(255, 216, 11, 11), // Red for logout
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 212, 19, 19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 50),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.red), // Red border for reset
                    ),
                  ),
                ),
                onPressed: () => resetQuizResult(context),
                child: Row(
                  children: const [
                    Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Reset Quiz Result",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}