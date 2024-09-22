import 'package:flutter/material.dart';

void main() {
  runApp(PaymentScheduleApp());
}

class PaymentScheduleApp extends StatelessWidget {
  

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Schedule',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: PaymentScheduleScreen(),
    );
  }
}

class PaymentScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10), // Add spacing from the top
            // Search bar
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 350),
            // Schedule title
            Center(
              child: Text(
                'SCHEDULE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(20, 20, 83, 1),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Date Picker
            TextField(
              decoration: InputDecoration(
                labelText: 'DATE',
                hintText: 'DD/MM/YYYY',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            // Time Picker
            TextField(
              decoration: InputDecoration(
                labelText: 'TIME',
                hintText: '00:00',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 30),
            // Payment amount
            Center(
              child: Text(
                'LKR 200,000',
                style: TextStyle(
                  fontSize: 28,
                  color: Color.fromRGBO(20, 20, 83, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            // Pay button
            ElevatedButton(
              onPressed: () {
                // Add your payment action here
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color.fromRGBO(20, 20, 83, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Pay',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
