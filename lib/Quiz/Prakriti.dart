import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class Prakriti extends StatefulWidget {
  const Prakriti({super.key});

  @override
  State<Prakriti> createState() => _PrakritiState();
}

class _PrakritiState extends State<Prakriti> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    // Determine the result based on scores
    if (globals.vata_score > globals.kapha_score) {
      if (globals.pitta_score > globals.vata_score) {
        result = "PITTA";
      } else {
        result = "VATA";
      }
    } else {
      if (globals.kapha_score > globals.pitta_score) {
        result = "KAPHA";
      } else {
        result = "PITTA";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PhenoTypeTech - Know Your Prakriti',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 47, 79, 134), // Updated color
      ),
      backgroundColor: const Color.fromARGB(255, 214, 204, 198),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "Your Prakriti is  $result",
                    style: const TextStyle(
                      fontFamily: 'Pacifio',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 47, 79, 134),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Dietary Recommendations Card
                  GestureDetector(
                    onTap: () {
                      if (result == "KAPHA") {
                        Navigator.pushNamed(context, "dietkapha");
                      } else if (result == "PITTA") {
                        Navigator.pushNamed(context, "dietpitta");
                      } else if (result == "VATA") {
                        Navigator.pushNamed(context, "dietvata");
                      }
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: const Color.fromARGB(255, 240, 158, 84),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.local_dining, size: 40, color: Colors.black),
                            SizedBox(height: 10),
                            Text(
                              "Dietary Recommendations",
                              style: TextStyle(
                                fontFamily: 'Pacifio',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Yoga Recommendations Card
                  GestureDetector(
                    onTap: () {
                      if (result == "KAPHA") {
                        Navigator.pushNamed(context, "yogakapha");
                      } else if (result == "PITTA") {
                        Navigator.pushNamed(context, "yogapitta");
                      } else if (result == "VATA") {
                        Navigator.pushNamed(context, "yogavata");
                      }
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: const Color.fromARGB(255, 240, 158, 84),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.fitness_center, size: 40, color: Colors.black),
                            SizedBox(height: 10),
                            Text(
                              "Yoga Recommendations",
                              style: TextStyle(
                                fontFamily: 'Pacifio',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Anything here",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: GestureDetector(
                          child: const Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
