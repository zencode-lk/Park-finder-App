import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'search_Map.dart';

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
    final url = Uri.parse('http://localhost:3000/api/login');

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
        // Show error message or handle the error
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
                    )
                  ),
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
                            return 'Please enter your username';
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
                          Checkbox(
                            value: _termsAccepted,
                            onChanged: (bool? value) {
                              setState(() {
                                _termsAccepted = value!;
                              });
                            },
                            activeColor: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          Text(
                            'I agree to the',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 20, 20, 83),
                              ),
                          ),
                          const Text(
                            ' terms and conditions',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 20, 20, 83), 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 80),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(146, 255, 255, 255),
                          foregroundColor: Color.fromARGB(148,144,195,255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 140, vertical: 20),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (_termsAccepted) {
                              bool success = await _loginUser();
                              if (success) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ParkingLocationScreen(),
                                ));
                              } else {
                                print('Login failed');
                              }
                            } else {
                              print('Please accept the terms and conditions');
                            }
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
