import 'package:flutter/material.dart';
import 'package:park_finder/pages/land_registration.dart';
import 'package:park_finder/pages/search_Map.dart';
import 'package:park_finder/pages/user_register.dart';

class UserLandOwner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      backgroundColor: const Color(0xFF141453), 
      body: SafeArea(
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/logio.png',
                height: 350, 
                width: 350, 
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.02), 
                    Text(
                      'hello!',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 20, 20, 83),
                        fontSize: screenWidth * 0.09, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05), 

                    //user button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ParkingLocationScreen(isLoggedIn: false,),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(screenWidth * 0.9, screenHeight * 0.1), 
                          backgroundColor: const Color.fromARGB(255, 20, 20, 83),
                          foregroundColor: const Color.fromARGB(148, 144, 195, 255),
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Join user',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05, 
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.05),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LandRegistrationPage(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(screenWidth * 0.9, screenHeight * 0.1),
                          backgroundColor: const Color.fromARGB(255, 20, 20, 83),
                          foregroundColor: const Color.fromARGB(148, 144, 195, 255),
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Join land owner',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05, 
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.15), 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}