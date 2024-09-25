import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class PaymentScheduleScreen extends StatefulWidget {
  @override
  _PaymentScheduleScreenState createState() => _PaymentScheduleScreenState();
}

class _PaymentScheduleScreenState extends State<PaymentScheduleScreen> {
  final TextEditingController _locationController = TextEditingController();
  List<dynamic> _places = []; // List to hold nearby places

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
                  controller: _locationController,
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
                    onPressed: _fetchNearbyPlaces,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
           // Adjusted space for places list
            // Display nearby places
            if (_places.isNotEmpty)
              Column(
                children: _places.map((place) {
                  return ListTile(
                    title: Text(place['name']),
                    subtitle: Text(place['vicinity']),
                    onTap: () => _showUnavailablePopup(), // Show popup when tapped
                  );
                }).toList(),
              ),
            SizedBox(height: screenHeight * 0.025), // Space before schedule title
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
                'LKR -',
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
               
                _showUnavailablePopup();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color.fromRGBO(20, 20, 83, 0.5),
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

  Future<void> _fetchNearbyPlaces() async {
    final String location = _locationController.text;
    final String url = 'http://localhost:3000/api/places?location=$location&radius=300';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Access the results key directly to get the list of places
        final List<dynamic> places = data['results'];
        setState(() {
          _places = places; // Update the state with fetched places
        });
      } else {
        print("Failed to load places: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching places: $e");
    }
  }

  // Show popup when scheduling is unavailable
  void _showUnavailablePopup() {
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
                'Scheduling currently unavailable.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Color.fromRGBO(20, 20, 83, 1),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Simulate a payment process
 

  // Show the success dialog after payment is completed
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
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Color.fromRGBO(20, 20, 83, 1),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
