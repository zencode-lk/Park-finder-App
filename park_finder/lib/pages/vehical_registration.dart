import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VehicleRegistrationForm extends StatefulWidget {
  @override
  _VehicleRegistrationFormState createState() => _VehicleRegistrationFormState();
}

class _VehicleRegistrationFormState extends State<VehicleRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _carMakeController,
                decoration: InputDecoration(labelText: 'Car Make'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your car make';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _carModelController,
                decoration: InputDecoration(labelText: 'Car Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your car model';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _carNumberController,
                decoration: InputDecoration(labelText: 'Car Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your car number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Process the vehicle registration data
                    final formData = {
                      'carMake': _carMakeController.text,
                      'carModel': _carModelController.text,
                      'carNumber': _carNumberController.text,
                    };
                    print('Form data: $formData');
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
