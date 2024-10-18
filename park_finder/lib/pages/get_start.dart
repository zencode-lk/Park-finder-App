import 'package:flutter/material.dart';
import 'package:park_finder/pages/terms_and_conditions.dart';
import 'package:park_finder/pages/user_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(20, 20, 83, 1),
            ),
          ),
          
          Positioned(
            top: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(right: 20, bottom: 20),
                child: Opacity(
                  opacity: 0.3, 
                  child: Align(
                    alignment: Alignment.centerRight,
                    widthFactor: 0.5, // Display only half of the image width
                    child: Image.asset(
                      'images/logio.png',
                      height: 500, 
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 179, 161, 230), 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
            ),
          ),
          
          Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(right: 20, top: 20),
                  child: Image.asset( 
                    'images/logio.png',
                    height: 100,
                  ),
                )
              ),
            
              const SizedBox(height: 150,),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 50),
                  child: const Text(
                    'PARK',
                    style: TextStyle(
                      fontSize: 60,
                      fontFamily: 'Race Sport',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 50),
                  child: const Text(
                    'FINDER',
                    style: TextStyle(
                      fontSize: 60,
                      fontFamily: 'Race Sport',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ),
              
              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TermsAndConditionsPage(navigateToLandOwnerPage: true,),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                  ));
                },
                child: const Text(
                  'I already have an account',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 100), 
            ],
          ),
        ],
      ),
    );
  }
}
