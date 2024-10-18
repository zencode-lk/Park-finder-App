import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScheduleScreen extends StatefulWidget {
  @override
  _PaymentScheduleScreenState createState() => _PaymentScheduleScreenState();
}

class _PaymentScheduleScreenState extends State<PaymentScheduleScreen> {
  final TextEditingController _locationController = TextEditingController();
  List<dynamic> _places = []; // List to hold nearby places

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _fetchNearbyPlaces,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            // Display nearby places
            if (_places.isNotEmpty)
              Column(
                children: _places.map((place) {
                  return ListTile(
                    title: Text(place['name']),
                    subtitle: Text(place['vicinity']),
                    onTap: () => _showUnavailablePopup(), 
                  );
                }).toList(),
              ),
            const SizedBox(height: 300), 

            // Schedule title
            const Center(
              child: Text(
                'SCHEDULE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(20, 20, 83, 1),
                ),
              ),
            ),
            const SizedBox(height: 20),

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
            const SizedBox(height: 20),
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
            const SizedBox(height: 30),
            // Payment amount
            const Center(
              child: Text(
                'LKR -',
                style: TextStyle(
                  fontSize: 28,
                  color: Color.fromRGBO(20, 20, 83, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                _showUnavailablePopup();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color.fromRGBO(20, 20, 83, 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
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
    final String url = 'http://192.168.43.28:3000/api/places?location=$location&radius=300';

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
          backgroundColor: const Color.fromRGBO(20, 20, 83, 1),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
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
                  Navigator.pop(context); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
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

  // Show the success dialog after payment is completed
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: const Color.fromRGBO(20, 20, 83, 1),
          content: const Column(
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
            ],
          ),
        );
      },
    );
  }
}
