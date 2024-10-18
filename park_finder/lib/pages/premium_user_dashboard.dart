import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_finder/pages/payment_history.dart';
import 'package:park_finder/pages/review.dart';
import 'package:park_finder/pages/schedule.dart';
import 'package:park_finder/pages/search_Map.dart';
import 'package:park_finder/pages/user_profile.dart';
import 'vehical_registration.dart';

class HomeScreen extends StatefulWidget {
  final String userId;

  HomeScreen({required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "Manindu Lakmith";
  String userEmail = "manindulakmith@gmail.com";
  List<String> userVehicles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserVehicles();
  }

// Function to fetch vehicles from API
Future<void> fetchUserVehicles() async {
  try {
    final response = await http.get(
      Uri.parse('http://192.168.215.201:3000/api/vehicles/user/${widget.userId}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        // Extract plate numbers from each vehicle object
        userVehicles = List<String>.from(data.map((vehicle) => vehicle['plateNumber']));
        isLoading = false; // Set loading to false once data is fetched
      });
    } else {
      print("Failed to fetch vehicles. Status code: ${response.statusCode}");
      setState(() {
        isLoading = false; // Stop loading in case of failure
      });
    }
  } catch (e) {
    print("Error fetching vehicles: $e");
    setState(() {
      isLoading = false; // Stop loading in case of error
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 20, 20, 83),
          actions: [
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.person),
              color: Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserProfilePage(
                    name: userName,
                    email: userEmail,
                    vehicles: userVehicles,
                  ),
                ));
              },
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loader while fetching data
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.white, Color(0xFF9E9EEC)],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildMainButton(
                          context,
                          'Find Parking',
                          'images/map.jpg',
                          () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ParkingLocationScreen(),
                            ));
                          },
                          350.0,
                          250.0,
                        ),
                        SizedBox(height: 16),
                        buildMainButton(
                          context,
                          'Schedule',
                          'images/schedule.jpg',
                          () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PaymentScheduleScreen(),
                            ));
                          },
                          350.0,
                          90.0,
                        ),
                        SizedBox(height: 16),
                        buildMainButton(
                          context,
                          'Reviews',
                          'images/reviews.jpg',
                          () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReviewPage(),
                            ));
                          },
                          350.0,
                          90.0,
                        ),
                        SizedBox(height: 16),
                        buildMainButton(
                          context,
                          'Add a vehicle',
                          'images/car.jpg',
                          () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VehicleRegistrationForm(
                                userId: widget.userId,
                              ),
                            ));
                          },
                          350.0,
                          90.0,
                        ),
                        SizedBox(height: 16),
                        buildMainButton(
                          context,
                          'Payment History',
                          'images/car.jpg',
                          userVehicles.isNotEmpty
                              ? () {
                                  String vehiclePlate = userVehicles[0];
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PaymentHistoryPage(
                                      userId: widget.userId,
                                      userPlateNumber: vehiclePlate, // Pass first vehicle
                                    ),
                                  ));
                                }
                              : null, // Disable button if vehicle list is empty
                          350.0,
                          90.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 20, 20, 83),
          child: IconButton(
            iconSize: 50,
            icon: Icon(Icons.support_agent),
            color: Color.fromARGB(255, 255, 255, 255),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Color.fromARGB(255, 20, 20, 83),
                    title: Center(
                      child: Text(
                        'Customer Support',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Hello! We are here to assist you with any questions or issues you may have.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'You can reach us at:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Phone: 0772932907',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          child: Text(
                            'Email: hello@zencode.com',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          onTap: () {
                            // Add email functionality here if needed
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Our support team is available from 9 AM to 5 PM, Monday to Friday.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'We are committed to providing you with the best experience. Don’t hesitate to reach out!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Close',
                            style: TextStyle(
                              color: Color.fromRGBO(20, 20, 83, 1),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildMainButton(BuildContext context, String label, String imagePath, VoidCallback? onPressed, double width, double height) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
