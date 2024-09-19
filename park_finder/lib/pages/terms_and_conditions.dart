import 'package:flutter/material.dart';

// Entry point of the application
void main() {
  runApp(MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TermsAndConditionsPage(), // Set TermsAndConditionsPage as the home
    );
  }
}

// Terms and Conditions Page
class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '1. Introduction\n\n'
              'Welcome to Park Finder. By accessing and using our app, you agree to abide by the following terms and conditions...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '2. User Responsibilities\n\n'
              'As a user, you are responsible for ensuring that your use of the app complies with local laws and regulations...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '3. Privacy Policy\n\n'
              'We value your privacy. Please refer to our privacy policy to learn more about how we handle your data...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
