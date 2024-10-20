import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_finder/pages/land_owner_registration.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Land Registration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandRegistrationPage(),
    );
  }
}

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
  final _noReserveSlot = TextEditingController();
  final _landName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Land Registration'),
        backgroundColor: Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
               SizedBox(height: 20),
              // City Input
              TextFormField(
                controller: _landName,
                decoration: InputDecoration(
                  labelText: 'Land Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Street No Input
              TextFormField(
                controller: _streetNo,
                decoration: InputDecoration(
                  labelText: 'Street No',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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

              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
              SizedBox(height: 50),
              // Longitude Input
              TextFormField(
                controller: _noReserveSlot,
                decoration: InputDecoration(
                  labelText: 'noReserveSlot',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 50),
              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50),
                  backgroundColor: Color(0xFF0C0C5D), // Button color
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Navigate to LandOwnerRegister page, passing the land data
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LandOwnerRegister(
                        landData: {
                          'landLocation': {
                            'streetNo': _streetNo.text,
                            'road': _road.text,
                            'city': _city.text,
                          },
                          'landName': _landName.text,
                          'ownerContact': _mobileNumber.text,
                          'noParkingSlot': _parkingSlot.text,
                          'noReserveSlot': _noReserveSlot.text,
                        },
                      ),
                    ));
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
