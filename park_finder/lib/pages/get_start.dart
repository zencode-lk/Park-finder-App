import 'package:flutter/material.dart';
import 'user_login.dart';
import 'user_register.dart';

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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserRegister(), //regRoute
                ));
              },
              child: Text('Get Started'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=> SignInScreen(), //loginRoute
                ));
              },
              child: Text('I already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}