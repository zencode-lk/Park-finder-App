import 'package:flutter/material.dart';
import 'package:park_finder/pages/payment_history.dart';
import 'package:park_finder/pages/review.dart';
import 'package:park_finder/pages/schedule.dart';
import 'package:park_finder/pages/search_Map.dart'; // Assuming this is your Parking Location screen
import 'package:park_finder/pages/user_profile.dart';
import 'vehical_registration.dart'; // Assuming this is the correct import for your vehicle registration page

class HomeScreen extends StatelessWidget {
  final String userId;

  final String userName = "Manindu Lakmith";
  final String userEmail = "manindulakmith@gmail.com";
  final List<String> userVehicles = ['Lamborghini Aventador', 'Mitsubishi Evolution 6'];

  HomeScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 20, 20, 83),
          actions: [
            IconButton(
              iconSize: 50,
              icon: const Icon(Icons.person),
              color: const Color.fromARGB(255, 255, 255, 255),
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Color(0xFF9E9EEC)],
            ),
          ),
          child: SingleChildScrollView( 
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
                          builder: (context) => ParkingLocationScreen(isLoggedIn: true,),
                        ));
                      },
                      350.0,
                      250.0,
                      
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    buildMainButton(
                      context,
                      'Add a vehicle',
                      'images/car.jpg',
                      () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VehicleRegistrationForm(
                            userId: userId,
                          ),
                        ));
                      },
                      350.0,
                      90.0,
                    ),
                    const SizedBox(height: 16),
                    buildMainButton(
                      context,
                      'Wallet',
                      'images/car.jpg',
                      () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentHistoryPage(
                          ),
                        ));
                      },
                      350.0,
                      90.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 20, 20, 83),
          child: IconButton(
            iconSize: 50,
            icon: const Icon(Icons.support_agent),
            color: const Color.fromARGB(255, 255, 255, 255),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 20, 20, 83),
                    title: const Center(
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
                        const Text(
                          'Hello! We are here to assist you with any questions or issues you may have.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'You can reach us at:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Phone: 0772932907',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),  
                          ),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          child: const Text(
                            'Email: hello@zencode.com',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          onTap: () {

                          },
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Our support team is available from 9 AM to 5 PM, Monday to Friday.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
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
                          child: const Text(
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

  Widget buildMainButton(BuildContext context, String label, String imagePath, VoidCallback onPressed, double width, double height) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
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
                    style: const TextStyle(
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
      ),
    );
  }
}
