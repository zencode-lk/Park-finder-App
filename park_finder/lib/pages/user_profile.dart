import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // For date/time formatting

class UserProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final List<String> vehicles;
  final String userId; // Add userId to the constructor

  UserProfilePage({
    required this.name,
    required this.email,
    required this.vehicles,
    required this.userId, // Required parameter
  });

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  List<Map<String, dynamic>> schedules = []; // List to hold schedules

  @override
  void initState() {
    super.initState();
    _fetchUserSchedules(); // Fetch schedules when the page loads
  }

  // Function to fetch user schedules from backend
  Future<void> _fetchUserSchedules() async {
    final String apiUrl = 'http://localhost:3000/api/schedule/data/${widget.userId}';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> scheduleData = jsonDecode(response.body);
        setState(() {
          schedules = scheduleData.map((schedule) => {
            'date': schedule['date'],
            'place': schedule['place'],
            'startTime': schedule['startTime'],
            'endTime': schedule['endTime'],
            'fee': schedule['fee'],
          }).toList();
        });
      } else {
        print('Failed to fetch schedules: ${response.body}');
      }
    } catch (error) {
      print('Error fetching schedules: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 89, 10, 236),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Basic info.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                widget.email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Registered vehicles',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: widget.vehicles.map(
                  (vehicle) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      vehicle,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ).toList(),
              ),
              SizedBox(height: 30), // Add some spacing
              Text(
                'Your Schedules',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              
              // Display the list of schedules
              schedules.isNotEmpty
                  ? _buildScheduleList() // Builds the styled and formatted schedule list
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'No schedules available.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build the schedule list with styling and formatting
  Widget _buildScheduleList() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.deepPurple[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: schedules.map((schedule) {
          // Parse and format the date and time
          DateTime startTime = DateTime.parse(schedule['startTime']);
          DateTime endTime = DateTime.parse(schedule['endTime']);
          double fee = schedule['fee'].toDouble();

          String formattedDate = DateFormat('dd/MM').format(startTime);
          String formattedStartTime = DateFormat('HH:mm').format(startTime);
          String formattedEndTime = DateFormat('HH:mm').format(endTime);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '$formattedStartTime - $formattedEndTime',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '\$$fee',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.greenAccent[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
