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
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            // Search bar with search button
            Stack(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                 
                    },
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.4), 
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
                _simulatePayment(context);
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

  // Simulate a payment process
  void _simulatePayment(BuildContext context) async {
    // Simulate some payment processing delay (for example, 2 seconds)
    await Future.delayed(Duration(seconds: 2));

    // After payment process is complete, showing the success dialog
    _showSuccessDialog(context);
  }

  // the success dialog after payment is completed
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Color.fromRGBO(20, 20, 83, 1),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Deposit transaction completed successfully.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pop(context); // Close the dialog
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //   ),
              //   child: Text(
              //     'Dashboard',
              //     style: TextStyle(
              //       color: Color.fromRGBO(20, 20, 83, 1),
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
