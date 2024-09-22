// vehicle_registration.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



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

  Future<void> _registerVehicle() async {
    final url = Uri.parse(
        'http://localhost:3000/api/vehicles/register'); // Update the URL as needed

    final response = await http.post(
      url,
      body: jsonEncode({
        'make': _carMakeController.text, // Update key to 'make'
        'model': _carModelController.text, // Update key to 'model'
        'plateNumber': _carNumberController.text, // Update key to 'plateNumber'
        'userId': widget.userId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print('Vehicle registered successfully!');
    } else {
      print('Failed to register vehicle: ${response.body}');
    }
  }

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
          child: Column(
            children: [
              TextFormField(
                controller: _carMakeController,
                decoration: InputDecoration(labelText: 'Car Make'),
                validator: (value) => value!.isEmpty ? 'Enter car make' : null,
              ),
              TextFormField(
                controller: _carModelController,
                decoration: InputDecoration(labelText: 'Car Model'),
                validator: (value) => value!.isEmpty ? 'Enter car model' : null,
              ),
              TextFormField(
                controller: _carNumberController,
                decoration: InputDecoration(labelText: 'Car Number'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter car number' : null,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _registerVehicle();
                  }
                },
                child: Text('Register Vehicle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
