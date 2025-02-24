import 'package:flutter/material.dart';

class RemediesPage extends StatefulWidget {
  final String userType;

  const RemediesPage({super.key, required this.userType});
  @override
  _RemediesPageState createState() => _RemediesPageState();
}

class _RemediesPageState extends State<RemediesPage> {
  List<Map<String, String>> remedies = [
    {
      "name": "Turmeric Milk",
      "ingredients": "Turmeric, Milk, Honey",
      "instructions": "Mix ingredients and drink warm."
    },
    {
      "name": "Ginger Tea",
      "ingredients": "Ginger, Water, Honey",
      "instructions": "Boil ginger in water and add honey."
    },
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  void _addRemedy() {
    if (_nameController.text.isNotEmpty &&
        _ingredientsController.text.isNotEmpty &&
        _instructionsController.text.isNotEmpty) {
      setState(() {
        remedies.add({
          "name": _nameController.text,
          "ingredients": _ingredientsController.text,
          "instructions": _instructionsController.text,
        });
        _nameController.clear();
        _ingredientsController.clear();
        _instructionsController.clear();
      });
      Navigator.pop(context); // Move this line here
    } else {
      // Show a message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  void _showAddRemedyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Remedy'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: _ingredientsController,
                decoration: InputDecoration(hintText: 'Ingredients'),
              ),
              TextField(
                controller: _instructionsController,
                decoration: InputDecoration(hintText: 'Instructions'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: _addRemedy,
              child: Text('Add'),
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Remedies'),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: remedies.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    remedies[index]['name']!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ingredients: ${remedies[index]['ingredients']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Instructions: ${remedies[index]['instructions']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      
      floatingActionButton: widget.userType == 'Doctor'
    ? FloatingActionButton(
        backgroundColor: Colors.green[700],
        onPressed: () {
          _showAddRemedyDialog();
        },
        child: Icon(Icons.add),
      )
    : null, 
    );
  }
}
