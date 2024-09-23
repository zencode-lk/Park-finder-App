import 'package:flutter/material.dart';
import 'package:park_finder/main.dart';
import 'package:park_finder/pages/land_owner_registration.dart';

// class LandRegistrationApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Land Registration',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LandRegistrationPage(),
//     );
//   }
// }

class LandRegistrationPage extends StatefulWidget {
  @override
  _LandRegistrationPageState createState() => _LandRegistrationPageState();
}

class _LandRegistrationPageState extends State<LandRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _landOwnerName = TextEditingController();
  final _streetNo = TextEditingController();
  final _road = TextEditingController();
  final _city = TextEditingController();
  final _mobileNumber = TextEditingController();
  final _parkingSlot = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _landOwnerName,
                decoration: InputDecoration(
                  labelText: 'Land owner Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
              TextFormField(
                controller: _mobileNumber,
                decoration: InputDecoration(
                  labelText: 'Land owner Contact Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50),
                  backgroundColor: Color(0xFF0C0C5D), // Button color
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 15.0),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate()?? false) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LandOwnerRegister(), // Pass the userId
                    ));
                    // Handle the registration logic here
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => AlertDialog(
                    //     title: Text('Registration Successful'),
                    //     content: Text('Land Owner: $_landOwnerName\n'
                    //         'Land Location: $_landLocation\n'
                    //         'Mobile Number: $_mobileNumber'),
                    //     actions: [
                    //       TextButton(
                    //         onPressed: () {
                    //           Navigator.of(context).push(MaterialPageRoute(
                    //             builder: (context) => LandOwnerRegister(), // Pass the userId
                    //           ));
                    //         },
                    //         child: Text('OK'),
                    //       ),
                    //     ],
                    //   ),
                    // );
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
