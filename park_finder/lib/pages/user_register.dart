import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_finder/pages/vehical_registration.dart';
import 'dart:convert';

import 'user_login.dart';

class UserRegister extends StatefulWidget {
  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<bool> _registerUser() async {
    final url = Uri.parse('http://localhost:3000/api/users');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _firstNameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 201) {
        // User registered successfully
        print('User registered: ${response.body}');
        return true;
      } else {
        // Handle error
        print('Failed to register user: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false; // Indicate failure
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 20, 83, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Color(0xFF9E9EEC)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50), // Add space at the top
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0C0C5D), // Button color
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 60.0, vertical: 15.0),
                    ),
                    // onPressed: () async {
                    //   if (_formKey.currentState?.validate() ?? false) {
                    //     bool success = await _registerUser();
                    //     if (success) {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => VehicleRegistrationForm()
                    //       ));
                    //     }
                    //   }
                    // },
                    onPressed: () {
                          // Navigate to UserPage
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VehicleRegistrationForm(),
                          ));
                        },
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
