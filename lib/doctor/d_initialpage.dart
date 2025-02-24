import 'package:flutter/material.dart';
import 'package:prakriti_finder/doctor/customers.dart';
import 'package:prakriti_finder/doctor/d_appointments.dart';
import 'package:prakriti_finder/doctor/d_homepage.dart';
import 'package:prakriti_finder/doctor/d_profile.dart';

class DoctorInitialPage extends StatefulWidget {
  const DoctorInitialPage({super.key});

  @override
  State<DoctorInitialPage> createState() => _DoctorInitialPageState();
}

class _DoctorInitialPageState extends State<DoctorInitialPage> {
  int _currentIndex = 0;

  List<Widget> tabs = <Widget>[
    DoctorHomePage(),
    CustomerList(),
    ManageAppointments(), 
    const DoctorProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: Color.fromARGB(255, 37, 100, 38), // Deep green for Ayurvedic theme
          selectedItemColor: Color.fromARGB(255, 240, 230, 50), // Calming orange for selected item
          unselectedItemColor: Colors.white, // White for unselected items
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.black),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: 'Patients',
              backgroundColor: Colors.black),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist_rtl),
              label: 'Appointment',
              backgroundColor: Colors.black),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
              backgroundColor: Colors.black),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
