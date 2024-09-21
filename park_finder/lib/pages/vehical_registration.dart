import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:park_finder/pages/premium_user_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VehicleRegistrationForm(),
    );
  }
}

class VehicleRegistrationForm extends StatefulWidget {
  @override
  _VehicleRegistrationFormState createState() => _VehicleRegistrationFormState();
}

class _VehicleRegistrationFormState extends State<VehicleRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carNumberController = TextEditingController();
  bool _isLoading = false;
  
  Future<void> _registerVehicle(Map<String, String> formData) async {
    // Your API call logic here
    final response = await http.post(
      Uri.parse('https://yourapi.com/register_vehicle'),
      body: jsonEncode(formData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Vehicle registered successfully!');
    } else {
      print('Failed to register vehicle');
    }
  } // Ensure _isLoading is initialized

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
              constraints: BoxConstraints(maxWidth: 600), // Max width for the form
              child: Column(
                mainAxisSize: MainAxisSize.min, // Adjusts to the content size
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
                          label: 'Car Make',
                        ),
                        SizedBox(height: 16),
                        _buildTextFormField(
                          controller: _carModelController,
                          label: 'Car Model',
                        ),
                        SizedBox(height: 16),
                        _buildTextFormField(
                          controller: _carNumberController,
                          label: 'Car Number',
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    final formData = {
                                      'carMake': _carMakeController.text,
                                      'carModel': _carModelController.text,
                                      'carNumber': _carNumberController.text,
                                    };
                                    await _registerVehicle(formData);

                                    setState(() {
                                      _isLoading = false;
                                    });

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 30.0),
                            backgroundColor: Colors.deepPurple,
                            elevation: 6,
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
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

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        labelStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
