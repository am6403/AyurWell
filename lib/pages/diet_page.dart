import 'package:flutter/material.dart';

class DietPage extends StatelessWidget {
  final String doshaName;

  DietPage({required this.doshaName});

  @override
  Widget build(BuildContext context) {
    String dietContent;
    List<String> dietImages;

    switch (doshaName) {
      case 'Kapha':
        dietContent = 'Kapha Diet: Eat light, warm, and spicy foods. Avoid heavy, oily, and cold foods.';
        dietImages = [
          'assets/Meat.jpg',
          'assets/Mint.jpg',
          'assets/Saffloweroil.png'
        ]; 
        break;
      case 'Pitta':
        dietContent = 'Pitta Diet: Eat cool, refreshing, and mild foods. Avoid hot, spicy, and oily foods.';
        dietImages = [
          'assets/Legumes.jpg',
          'assets/Brocolli.jpg',
          'assets/Blackpepper.jpg'
        ]; 
        break;
      case 'Vata':
        dietContent = 'Vata Diet: Eat warm, moist, and grounding foods. Avoid cold, dry, and raw foods.';
        dietImages = [
          'assets/Cauliflower.jpg',
          'assets/Coconut.jpg',
          'assets/Gingertea.jpg'
        ]; 
        break;
      default:
        dietContent = 'Unknown Dosha';
        dietImages = ['assets/default_diet.png']; 
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Diet for $doshaName'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              dietContent,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            ...dietImages
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