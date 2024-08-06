import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:park_finder/pages/user_login.dart';
import 'package:park_finder/pages/user_register.dart';
//import 'login.dart' as logIn;
//import 'user_rigistration.dart' as userRegistration;

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
                //userRegistration.main();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=> UserRegister(), //loginRoute
                ));

              },
              child: Text('Get Started'),
            ),
            TextButton(
              onPressed: () {
                //logIn.main();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=> SignInScreen(),
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