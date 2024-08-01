import 'package:flutter/material.dart';
import 'vehical_registration.dart' as vehicalRegistration;

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
        title: Text('Parking App'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Rs.5700.00',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton(context, 'Schedule', Icons.schedule),
                buildButton(context, 'Find Parking', Icons.local_parking),
                buildButton(context, 'Reviews', Icons.rate_review),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Recent Activity',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            buildActivity('Payment Successful - rs. 5700.00'),
            buildActivity('Parking Scheduled - Silva\'s Car Park'),
            buildActivity('Parking Deducted - rs. 500.00'),
            SizedBox(height: 16),
            Spacer(), // To push the button to the bottom of the screen
            ElevatedButton(
              onPressed: () {
                vehicalRegistration.main();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: Text(
                'Register Vehicle',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String title, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title button pressed')),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ],
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
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
