import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'premium_user_dashboard.dart'; // Assuming HomeScreen exists
import 'land_owner_dashboard.dart'; // Assuming you have a LandOwnerDashboardPage
import 'terms_and_conditions.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  // Loading state
  bool _isLoading = false;

  Future<bool> _loginUser() async {
    final url = Uri.parse('http://192.168.215.201:3000/api/users/login');

    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final userType = data['userType']; // Get userType from the response
        final userId = data['id'];
        print('Login successful, token: $token, userType: $userType, id: $userId');

        // Store the token securely
        await storage.write(key: 'auth_token', value: token);

        // Navigate based on the userType
        if (userType == 'landowner') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LandOwnerDashboardScreen(userId: userId), // Navigate to landowner dashboard
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(userId: userId), // Navigate to normal user dashboard
          ));
        }
        return true;
      } else {
        print('Failed to log in: ${response.body}');
        _showErrorDialog('Login failed. Please check your credentials and try again.');
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      _showErrorDialog('An error occurred. Please try again.');
      return false;
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    // Clear text fields
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      backgroundColor: Color.fromARGB(255, 20, 20, 83),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/logio.png',
              height: 350, // Fixed height
              width: 350,  // Fixed width
            ),
            SizedBox(height: 0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 435, // Fixed height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'hello!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 20, 83),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _usernameController,
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 20, 83),
                      ),
                      decoration: InputDecoration(
                        labelText: 'User Name',
                        hintText: 'User Name',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 20, 20, 83),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(26, 255, 255, 255),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 20, 83),
                            width: 1.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 20, 83),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 20, 20, 83),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(26, 255, 255, 255),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 20, 83),
                            width: 1.0,
                          ),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'I agree to the',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 20, 20, 83),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TermsAndConditionsPage(
                                navigateToLandOwnerPage: false,
                              ),
                            ));
                          },
                          child: const Text(
                            'terms and conditions',
                            style: TextStyle(
                              color: Color.fromARGB(255, 20, 20, 83),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50,), // Pushes the button to the bottom
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 20, 20, 83), // Correct background color usage
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      ),

                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          bool success = await _loginUser();
                          if (!success) {
                            // Showing the error is handled in _loginUser with _showErrorDialog
                            print('Login failed');
                          }
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
