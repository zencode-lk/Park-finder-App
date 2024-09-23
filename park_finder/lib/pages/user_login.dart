import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:park_finder/pages/terms_and_conditions.dart';

import 'premium_user_dashboard.dart';
import 'terms_and_conditions.dart';  // Assuming you have a separate TermsAndConditionsPage

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _termsAccepted = false;
  final storage = FlutterSecureStorage();

  Future<bool> _loginUser() async {
    final url = Uri.parse('http://localhost:3000/api/users/login');

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
        print('Login successful, token: $token');

        // Store the token securely
        await storage.write(key: 'auth_token', value: token);

        // Navigate to the next screen or perform other actions
        return true;
      } else {
        print('Failed to log in: ${response.body}');

        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      backgroundColor: Color.fromARGB(255, 20, 20, 83),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Image.asset(
                'images/logio.png',
                height: 350,
                width: 350,
              ),
              SizedBox(height: 0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
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
                              // Navigate to the Terms and Conditions page
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TermsAndConditionsPage(navigateToLandOwnerPage: false,),
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
                      SizedBox(height: 80),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(146, 255, 255, 255),
                          foregroundColor: Color.fromARGB(148, 144, 195, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 140, vertical: 20),
                        ),
                        onPressed: () async {
                        
                            bool success = await _loginUser();
                            if (success) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    userId: _usernameController.text), // Pass email as userId
                              ));
                            } else {
                              print('Login failed');
                            }
                          }, 
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 20, 20, 83),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
