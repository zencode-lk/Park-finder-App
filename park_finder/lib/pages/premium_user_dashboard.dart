import 'package:flutter/material.dart';
import 'package:park_finder/pages/review.dart';
import 'package:park_finder/pages/schedule.dart';
import 'package:park_finder/pages/search_Map.dart';
import 'package:park_finder/pages/user_profile.dart';
import 'vehical_registration.dart'; // Assuming this is the correct import for your vehicle registration page

class HomeScreen extends StatelessWidget {
  final String userId;

  // Example user details (replace with actual data from your app logic)
  final String userName = "Manindu Lakmith";
  final String userEmail = "manindulakmith@gmail.com";
  final List<String> userVehicles = ['Lamborghini Aventador', 'Mitsubishi Evolution 6'];

  HomeScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF746DAA), 
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
                        // Find Parking button 
                        buildMainButton(
                          context,
                          'Find Parking',
                          'images/map.jpg',
                          () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ParkingLocationScreen(),
                            ));
                          },
                          320.0,
                          150.0, 
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
                          320.0, 
                          120.0, 
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
                          320.0, 
                          120.0, 
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
                          320.0, 
                          120.0, 
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // User Icon 
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: Icon(Icons.person, size: 28, color: Colors.white),
                  onPressed: () {
                    // Navigate to user profile page
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserProfilePage(
                        name: userName,
                        email: userEmail,
                        vehicles: userVehicles,
                      ),
                    )); 
                  },
                ),
              ),

              // Customer Service Icon 
              Positioned(
                bottom: 16,
                right: 16,
                child: IconButton(
                  icon: Icon(Icons.support_agent, size: 28, color: Colors.white),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Customer Support'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Hello! We are here to assist you with any questions or issues you may have.',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'You can reach us at:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Phone: 0772932907',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                child: Text(
                                  'Email: hello@zencode.com',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                onTap: () {
                                  // Added the  email functionality
                                  // For example: launchUrl(Uri(scheme: 'mailto', path: 'support@zencode.com'));
                                },
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Our support team is available from 9 AM to 5 PM, Monday to Friday.',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'We are committed to providing you with the best experience. Don’t hesitate to reach out!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); 
                              },
                              child: Text('Close'),
                            ),
                          ],
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
