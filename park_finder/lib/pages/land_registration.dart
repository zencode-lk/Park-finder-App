import 'package:flutter/material.dart';

void main() => runApp(LandRegistrationApp());

class LandRegistrationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Land Registration',
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

  final _landOwnerName = TextEditingController();
  final _landLocation = TextEditingController();
  final _mobileNumber = TextEditingController();
  final _parkingSlots = TextEditingController(); // New controller for parking slots

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Land Registration'),
      ),
      backgroundColor: Colors.white, // White background to match the design
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView( // Added scroll view to handle keyboard overlap
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _landOwnerName,
                    decoration: InputDecoration(
                      labelText: 'Land owner name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the land owner\'s name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _landLocation,
                    decoration: InputDecoration(
                      labelText: 'Land location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the land location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _mobileNumber,
                    decoration: InputDecoration(
                      labelText: 'Land owner contact number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the mobile number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _parkingSlots, // New field for parking slots
                    decoration: InputDecoration(
                      labelText: 'Number of parking slots',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    keyboardType: TextInputType.number, // Ensures number input
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of parking slots';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.indigo[900], // Dark blue color for the button
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle the registration logic here
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Registration Successful'),
                            content: Text(
                              'Land Owner: ${_landOwnerName.text}\n'
                              'Land Location: ${_landLocation.text}\n'
                              'Mobile Number: ${_mobileNumber.text}\n'
                              'Parking Slots: ${_parkingSlots.text}', // Display number of parking slots
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Register!',
                      style: TextStyle(fontSize: 18),
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
