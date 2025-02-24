import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

String motherUserName = '';
String doctorUserName = '';
Future<String> getCustomerName() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(user.uid)
          .get();
      motherUserName = userSnapshot['name'].toString();
    } else {
      if (kDebugMode) {
        print('No current user');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching data: $e');
    }
  }
  return motherUserName;
}

Future<String> getDoctorName() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(user.uid)
          .get();
      doctorUserName = userSnapshot['name'].toString();
    } else {
      if (kDebugMode) {
        print('No current user');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching data: $e');
    }
  }
  return doctorUserName;
}