import 'package:flutter/material.dart';
import 'vehical_registration.dart' as vehicalRegistration;
import 'vehical_registration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text(
          'Parking App',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Rs.5700.00',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCardButton(context, 'Schedule', Icons.schedule),
                buildCardButton(context, 'Find Parking', Icons.local_parking),
                buildCardButton(context, 'Reviews', Icons.rate_review),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Recent Activity',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 8),
            buildActivity('Payment Successful - rs. 5700.00'),
            buildActivity('Parking Scheduled - Silva\'s Car Park'),
            buildActivity('Parking Deducted - rs. 500.00'),
            SizedBox(height: 16),
            Spacer(), // Push the button to the bottom
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VehicleRegistrationForm()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                backgroundColor: Colors.deepPurple[300],
              ),
              child: Text(
                'Payment Method',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      backgroundColor: Colors.purple[100], // Light purple background
    );
  }

  Widget buildCardButton(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title button pressed')),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActivity(String activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              activity,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}