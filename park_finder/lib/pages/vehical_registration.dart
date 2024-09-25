import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // For Future and delay

import 'user_login.dart'; // Import the user login page

class VehicleRegistrationForm extends StatefulWidget {
  final String userId;

  VehicleRegistrationForm({required this.userId});

  @override
  _VehicleRegistrationFormState createState() =>
      _VehicleRegistrationFormState();
}

class _VehicleRegistrationFormState extends State<VehicleRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
 
  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carNumberController = TextEditingController();

  bool _isSubmitting = false;
  double _progressValue = 0.0;

  Future<void> _registerVehicle() async {

     print(widget.userId);
    final url = Uri.parse('http://localhost:3000/api/vehicles/register');
    final response = await http.post(
      url,
      body: jsonEncode({
        'make': _carMakeController.text,
        'model': _carModelController.text,
        'plateNumber': _carNumberController.text,
        'userId': widget.userId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print('Vehicle registered successfully!');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } else {
      print('Failed to register vehicle: ${response.body}');
    }
  }

  Future<void> _simulateLoading() async {
    setState(() {
      _isSubmitting = true;
    });

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 30)); // Delay for smooth progress
      setState(() {
        _progressValue = i / 100; // Update progress value continuously
      });
    }

    // Once progress completes, register the vehicle
    await _registerVehicle();

    setState(() {
      _isSubmitting = false; // Reset the loading state after registration
      _progressValue = 0.0; // Reset progress bar after submission
    });
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
          borderSide: BorderSide.none, // Remove the border
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Padding inside
      ),
      validator: (value) => value!.isEmpty ? 'Enter $label' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Registration'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[200]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Register Your Vehicle',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildTextFormField(
                          controller: _carMakeController,
                          label: 'Your car make',
                        ),
                        SizedBox(height: 16),
                        _buildTextFormField(
                          controller: _carModelController,
                          label: 'Your car model',
                        ),
                        SizedBox(height: 16),
                        _buildTextFormField(
                          controller: _carNumberController,
                          label: 'Your car number',
                        ),
                        SizedBox(height: 24),
                        // Show progress bar while submitting
                        if (_isSubmitting)
                          Column(
                            children: [
                              LinearProgressIndicator(
                                value: _progressValue,
                                backgroundColor: Colors.grey[200],
                                color: Colors.deepPurple,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        // Register button
                        ElevatedButton(
                          onPressed: _isSubmitting
                              ? null // Disable button while submitting
                              : () async {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    await _simulateLoading();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0), // Rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 20.0, 
                              horizontal: 100.0, // Adjust the width
                            ),
                            backgroundColor: Colors.deepPurple,
                            elevation: 6,
                          ),
                          child: Text(
                            _isSubmitting ? 'Registering...' : 'Register!',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
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
