import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prakriti_finder/doctor/customerdetail.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController searchbarcontroller = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    searchbarcontroller.addListener(() {
      setState(() {
        searchQuery = searchbarcontroller.text;
      });
    });
  }

  @override
  void dispose() {
    searchbarcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Light background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Customer List',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF23374D), // Dark blue color
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: searchbarcontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 135, 156, 145)),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 234, 234, 234),
                    ),
                  ),
                  fillColor: Color.fromARGB(255, 245, 255, 254),
                  filled: true,
                  hintText: 'Search for Customers',
                  hintStyle: const TextStyle(color: Color(0xFF848EA1), fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Customers') // Fetch from the Customers collection
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CupertinoActivityIndicator();
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Text('No data found');
                    }

                    var filteredDocs = snapshot.data!.docs.where((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      var name = data['name'].toString().toLowerCase();
                      var email = data['email'].toString().toLowerCase();
                      var searchLower = searchQuery.toLowerCase();
                      return name.contains(searchLower) || email.contains(searchLower);
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) {
                        var customerData = filteredDocs[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Card(
                            color: Color.fromARGB(255, 227, 242, 226), // Light green background
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 2,
                            shadowColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2), // Subtle shadow
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Color.fromARGB(255, 8, 77, 20), // Dark profile icon color
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  customerData['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF23374D), // Dark text color
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Text(
                                          'Email: ',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          customerData['email'],
                                          style: const TextStyle(color: Color(0xFF23374D)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Text(
                                          'Age: ',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          customerData['age'].toString(),
                                          style: const TextStyle(color: Color(0xFF23374D)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Text(
                                          'Gender: ',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          customerData['gender'],
                                          style: const TextStyle(color: Color(0xFF23374D)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustomerDetailPage(
                                        customerDetails: customerData,
                                      ),
                                    ),
                                  );
                                  },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
