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
    final url = Uri.parse('http://172.20.10.2:3000/api/users/login');

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
        final userType = data['userType']; 
        final userId = data['id'];
        print('Login successful, token: $token, userType: $userType, id: $userId');

        // Store the token securely
        await storage.write(key: 'auth_token', value: token);

        // Navigate based on the userType
        if (userType == 'landowner') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LandOwnerScreen(userId: userId), 
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(userId: userId), 
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
        _isLoading = false; 
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      backgroundColor: const Color.fromARGB(255, 20, 20, 83),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/logio.png',
              height: 350,
              width: 350, 
            ),
            const SizedBox(height: 0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 435, // Fixed height
              decoration: const BoxDecoration(
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
                    const SizedBox(height: 20),
                    const Text(
                      'hello!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 20, 83),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _usernameController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 20, 20, 83),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 20, 20, 83),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(26, 255, 255, 255),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
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
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 20, 20, 83),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 20, 20, 83),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(26, 255, 255, 255),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'I agree to the',
                          style: TextStyle(
                            color: Color.fromARGB(255, 20, 20, 83),
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
                    const SizedBox(height: 50,), 
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 20, 20, 83), 
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      ),

                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          bool success = await _loginUser();
                          if (!success) {
                            print('Login failed');
                          }
                        }
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
