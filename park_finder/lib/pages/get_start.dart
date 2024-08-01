import 'package:flutter/material.dart';
import 'login.dart' as logIn;

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              child: Text('Get Started'),
            ),
            TextButton(
              onPressed: () {
                logIn.main();
              },
              child: Text('I already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}