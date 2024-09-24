import 'package:flutter/material.dart';
import 'package:park_finder/pages/schedule.dart';
import 'package:park_finder/pages/search_Map.dart';
import 'vehical_registration.dart'; // Assuming this is the correct import for your vehicle registration page

class HomeScreen extends StatelessWidget {
  final String userNic;
  HomeScreen({required this.userNic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0D4F1), // Light purple background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // Main buttons
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: buildMainButton(
                          context, 'Find Parking', 'images/map.jpg', () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ParkingLocationScreen(
                            ),
                          ));
                      }),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: buildMainButton(
                          context, 'Schedule', 'images/schedule.jpg', () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PaymentScheduleScreen(),
                          ));
                      }),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: buildMainButton(
                          context, 'Reviews', 'images/reviews.jpg', () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Reviews button pressed'),
                          ));
                      }),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: buildMainButton(
                          context, 'Add a vehicle', 'images/reviews.jpg', () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VehicleRegistrationForm(
                            nic: userNic,
                          ),
                        ));
                      }),
                    ),
                  ],
                ),
              ),

              // Bottom section
              Column(
                children: [
                  SizedBox(height: 16),
                  IconButton(
                    icon: Icon(Icons.refresh, size: 28),
                    onPressed: () {
                      // Add refresh functionality here
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMainButton(BuildContext context, String title, String imagePath,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
