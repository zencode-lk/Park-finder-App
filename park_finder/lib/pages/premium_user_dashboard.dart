import 'package:flutter/material.dart';
import 'package:park_finder/pages/schedule.dart';
import 'package:park_finder/pages/search_Map.dart';
import 'vehical_registration.dart'; // Assuming this is the correct import for your vehicle registration page

class HomeScreen extends StatelessWidget {
  final String userId;
  HomeScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF746DAA), // Updated background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),

                  // Main buttons
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Find Parking button with custom size
                        buildMainButton(
                          context,
                          'Find Parking',
                          'images/map.jpg',
                          () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ParkingLocationScreen(),
                            ));
                          },
                          320.0, // Fixed width for Find Parking button
                          150.0, // Increased height for Find Parking button
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
                          320.0, // Fixed width for other buttons
                          120.0, // Standard height for other buttons
                        ),
                        SizedBox(height: 16),
                        buildMainButton(
                          context,
                          'Reviews',
                          'images/reviews.jpg',
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Reviews button pressed'),
                            ));
                          },
                          320.0, // Fixed width for other buttons
                          120.0, // Standard height for other buttons
                        ),
                        SizedBox(height: 16),
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
                          320.0, // Fixed width for other buttons
                          120.0, // Standard height for other buttons
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // User Icon in the top-right corner
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: Icon(Icons.person, size: 28, color: Colors.white),
                  onPressed: () {
                    // Add user profile functionality here
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('User icon pressed'),
                    ));
                  },
                ),
              ),

              // Customer Service Icon in the bottom right corner
              Positioned(
                bottom: 16,
                right: 16,
                child: IconButton(
                  icon: Icon(Icons.support_agent, size: 28, color: Colors.white),
                  onPressed: () {
                    // Add customer service functionality here
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Customer Service button pressed'),
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build Main Button function with custom button height, fixed width, and styling
  Widget buildMainButton(BuildContext context, String title, String imagePath,
      VoidCallback onTap, double width, double height) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width, // Fixed width for all buttons
        height: height, // Custom height for buttons
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
              shadows: [
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
