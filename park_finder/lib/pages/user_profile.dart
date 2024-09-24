import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final List<String> vehicles;

  UserProfilePage({
    required this.name,
    required this.email,
    required this.vehicles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100], // Background color similar to the image
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300], // Similar back arrow design
        elevation: 0, // No shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView( // Allows scrolling on smaller screens
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: [
              SizedBox(height: 20),
              // Circle Avatar for profile picture
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey[300], // Placeholder icon color
                ),
              ),
              SizedBox(height: 20),
              // Basic Information Section
              Text(
                'Basic info.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30),
              // Registered Vehicles Section
              Text(
                'Registered vehicles',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              // Display the list of vehicles
              Column(
                children: vehicles.map(
                  (vehicle) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      vehicle,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
