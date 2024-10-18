import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final List<String> vehicles;

  UserProfilePage({
    required this.name,
    required this.email,
    required this.vehicles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 20, 83),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
        title: const Text("User Profile"),
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); 
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
          child: SingleChildScrollView( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 20, 20, 83),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 20),

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
                const SizedBox(height: 30),
                
                const Text(
                  'Registered vehicles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 20, 83),
                  ),
                ),
                const SizedBox(height: 10),
                
                Column(
                  children: vehicles.map(
                    (vehicle) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        vehicle,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 20, 20, 83),
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
