import 'package:flutter/material.dart';
import 'package:park_finder/pages/land_owner_registration.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Land Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Land Owner Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the land owner\'s name';
                  }
                  return null;
                }
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Land Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the land location';
                  }
                  return null;
                }
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the mobile number';
                  }
                  return null;
                }
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate()?? false) {
                    // Handle the registration logic here
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Registration Successful'),
                        content: Text('Land Owner: $_landOwnerName\n'
                            'Land Location: $_landLocation\n'
                            'Mobile Number: $_mobileNumber'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LandOwnerRegister(), // Pass the userId
                              ));
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
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
