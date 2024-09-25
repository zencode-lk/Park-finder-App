
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:park_finder/pages/terms_and_conditions.dart';
import 'package:park_finder/pages/user-land_owner.dart';
import 'package:park_finder/pages/user_login.dart';
import 'package:park_finder/pages/user_register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetStartedScreen(),
    );
  }
}

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background colour
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0D133E), // Dark blue at the top
                    Color(0xFF746DAA), // Light purple towards the bottom
                  ],
                  stops: [0.6, 1.0],
                ),
              ),
            ),
          ),
          
          // Top-right logo
          Positioned(
            top: 20,
            right: 20,
            child: Image.asset(
              'images/logio.png',
              height: 80, // this is the image size
            ),
          ),

          // Transparent  logo 
          Positioned(
            left: -100,
            top: MediaQuery.of(context).size.height * 0.21,
            child: Opacity(
              opacity: 0.3, // Transparent logo for the background
              child: Image.asset(
                'images/logio.png',
                height: 300, 
                fit: BoxFit.cover,
              ),
            ),
          ),

          // here Main text ("PARK FINDER") 
          Positioned(
            top: MediaQuery.of(context).size.height * 0.30, 
            left: 0,
            right: 0,
            child: Column(
              children: [
            
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100), 
                    child: Text(
                      'PARK',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'Race Sport', 
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
               
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right:90), 
                    child: Text(
                      'FINDER',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'Race Sport', 
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // "Get Started" button 
          Positioned(
            bottom: 150, 
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {                    //   here when the button is clicked it navigates to term terms and conditions 
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TermsAndConditionsPage(navigateToLandOwnerPage: true,),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),

          
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ));
                },
                child: Text(
                  'I already have an account',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
          ),

          // Wave design at the bottom of the screen
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Colors.white.withOpacity(0.3),
                height: 0, // Fixed height for wave design
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ClipPath for wave design at the bottom
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 30);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height - 60, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

