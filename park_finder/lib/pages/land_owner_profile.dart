import 'package:flutter/material.dart';

class LandOwnerProfilePage extends StatelessWidget {
  final String name;
  final String email;

  LandOwnerProfilePage({
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 20, 83),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
        title: Text("Land Owner Profile"),
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
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
          child: SingleChildScrollView( // Allows scrolling on smaller screens
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
              children: [
                const SizedBox(height: 20),
                // Circle Avatar for profile picture
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 20, 20, 83),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Color.fromARGB(255, 255, 255, 255), // Placeholder icon color
                  ),
                ),
                const SizedBox(height: 20),
                // Basic Information Section
                const Text(
                  'Basic info.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 20, 83),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 20, 20, 83),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 20, 20, 83),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
