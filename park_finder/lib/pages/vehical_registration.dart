import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_finder/pages/premium_user_dashboard.dart';
import 'dart:convert';

import 'package:park_finder/pages/user_login.dart';

class VehicleRegistrationForm extends StatefulWidget {
  final String userId;

  VehicleRegistrationForm({required this.userId});

  @override
  _VehicleRegistrationFormState createState() => _VehicleRegistrationFormState();
}

class _VehicleRegistrationFormState extends State<VehicleRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carNumberController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _registerVehicle() async {
    final url = Uri.parse('http://172.20.10.2:3000/api/vehicles/register');
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
        MaterialPageRoute(builder: (context) => HomeScreen(userId : widget.userId,)), 
      );
    } else {
      print('Failed to register vehicle: ${response.body}');
    }
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: false, 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), 
          borderSide: const BorderSide(color: Colors.grey), 
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), 
      ),
      validator: (value) => value!.isEmpty ? 'Enter $label' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Registration'),
        backgroundColor: const Color.fromARGB(255, 20, 20, 83),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Color(0xFF9E9EEC)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildTextFormField(
                          controller: _carMakeController,
                          label: 'Your car make',
                        ),
                        SizedBox(height: 20),
                        _buildTextFormField(
                          controller: _carModelController,
                          label: 'Your car model',
                        ),
                        SizedBox(height: 20),
                        _buildTextFormField(
                          controller: _carNumberController,
                          label: 'Your car number',
                        ),
                        SizedBox(height: 60),
                        // Register button
                        ElevatedButton(
                          onPressed: _isSubmitting
                              ? null // Disable button while submitting
                              : () async {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    setState(() {
                                      _isSubmitting = true;
                                    });
                                    await _registerVehicle();
                                    setState(() {
                                      _isSubmitting = false;
                                    });
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0, 
                              horizontal: 100.0, 
                            ),
                            backgroundColor: const Color.fromARGB(255, 20, 20, 83),
                            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                            elevation: 6,
                          ),
                          child: Text(
                            _isSubmitting ? 'Registering...' : 'Register!',
                            style: const TextStyle(
                              fontSize: 18,
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
