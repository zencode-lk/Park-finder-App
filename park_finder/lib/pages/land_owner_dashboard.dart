import 'package:flutter/material.dart';
import 'package:park_finder/pages/land_owner_profile.dart';

class LandOwnerScreen extends StatelessWidget {
  final String userId;

  final String userName = "Manindu Lakmith";
  final String userEmail = "manindulakmith@gmail.com";

  LandOwnerScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 20, 20, 83),
        elevation: 0,
        actions: [
          IconButton(
            iconSize: 50,
            icon: Icon(Icons.person),
            color: Color.fromARGB(255, 255, 255, 255),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LandOwnerProfilePage(
                  name: userName,
                  email: userEmail,
                ),
              ));
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Color(0xFF9E9EEC)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildCard("01", "LKR.5000.00", "income", "15", "20"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String number, String amount, String label, String completed, String total) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("0$number", style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    amount,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(label, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.purple[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "$completed/$total",
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
