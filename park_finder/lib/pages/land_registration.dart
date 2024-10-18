import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_finder/pages/land_owner_registration.dart';

class LandRegistrationPage extends StatefulWidget {
  @override
  _LandRegistrationPageState createState() => _LandRegistrationPageState();
}

class _LandRegistrationPageState extends State<LandRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final _streetNo = TextEditingController();
  final _road = TextEditingController();
  final _city = TextEditingController();
  final _mobileNumber = TextEditingController();
  final _parkingSlot = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Land Registration'),
        backgroundColor: const Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
              constraints: const BoxConstraints(maxWidth: 400),
              child: SingleChildScrollView( 
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _streetNo,
                        decoration: InputDecoration(
                          labelText: 'Street No',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Road Input
                      TextFormField(
                        controller: _road,
                        decoration: InputDecoration(
                          labelText: 'Road',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // City Input
                      TextFormField(
                        controller: _city,
                        decoration: InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Mobile Number Input
                      TextFormField(
                        controller: _mobileNumber,
                        decoration: InputDecoration(
                          labelText: 'Land Owner Contact Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Parking Slot Input
                      TextFormField(
                        controller: _parkingSlot,
                        decoration: InputDecoration(
                          labelText: 'Number of Parking Slots',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      // Submit Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 50),
                          backgroundColor: const Color(0xFF0C0C5D), // Button color
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LandOwnerRegister(
                                landData: {
                                  'landLocation': {
                                    'streetNo': _streetNo.text,
                                    'road': _road.text,
                                    'city': _city.text,
                                  },
                                  'ownerContact': _mobileNumber.text,
                                  'noParkingSlot': _parkingSlot.text,
                                },
                              ),
                            ));
                          }
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
