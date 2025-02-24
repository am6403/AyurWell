import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  final String doshaName;

  ExercisePage({required this.doshaName});

  @override
  Widget build(BuildContext context) {
    String exerciseContent;
    List<String> exerciseImages;

    switch (doshaName) {
      case 'Kapha':
        exerciseContent =
            'Kapha Exercise: Engage in vigorous activities like running, cycling, and strength training.';
        exerciseImages = [
          'assets/Cobrapose.jpg',
          'assets/Utakat.jpeg',
          'assets/Gomukhasana.jpg'
        ]; 
        break;
      case 'Pitta':
        exerciseContent =
            'Pitta Exercise: Focus on moderate activities like swimming, hiking, and yoga.';
        exerciseImages = [
          'assets/Sukhasana.jpg',
          'assets/Garudasana.jpg',
          'assets/Matsyendrasana.jpg'
        ]; 
        break;
      case 'Vata':
        exerciseContent =
            'Vata Exercise: Prefer gentle activities like walking, tai chi, and restorative yoga.';
        exerciseImages = [
          'assets/Uttanasana.jpg',
          'assets/Virabhadrasana.jpg',
          'assets/Vrishasana.jpg'
        ]; 
        break;
      default:
        exerciseContent = 'Unknown Dosha';
        exerciseImages = [
          'assets/default_exercise.png'
        ]; 
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise for $doshaName'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              exerciseContent,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            ...exerciseImages
                .map((image) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(image),
                    ))
                .toList(), 
          ],
        ),
      ),
    );
  }
}