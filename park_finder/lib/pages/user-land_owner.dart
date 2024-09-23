import 'package:flutter/material.dart';
import 'package:park_finder/pages/land_registration.dart';
import 'package:park_finder/pages/search_Map.dart';
import 'package:park_finder/pages/user_register.dart';

class UserLandOwner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      backgroundColor: Color(0xFF141453), // Background color
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
                'images/logio.png',
                height: 350,
                width: 350,
            ),// Top section (car image or any placeholder)
            
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )
                ),
              
            
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    // Greeting text
                    Text(
                      'hello!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 20, 83),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 30),

                    // Button 1: Become a user
                    Padding(
                      
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to UserPage
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ParkingLocationScreen(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          
                          backgroundColor: Color.fromARGB(255, 20, 20, 83),
                          foregroundColor: Color.fromARGB(148,144,195,255), // Button background color
                          padding: EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Join user',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Button 2: Become a land owner
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to LandOwnerPage
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LandRegistrationPage(), // Pass the userId
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 20, 20, 83),
                          foregroundColor: Color.fromARGB(148,144,195,255), // Button background color
                          padding: EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Join land owner',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
