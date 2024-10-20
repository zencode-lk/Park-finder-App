import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class PaymentScheduleScreen extends StatefulWidget {
  final String userId;

  PaymentScheduleScreen({required this.userId});

  @override
  _PaymentScheduleScreenState createState() => _PaymentScheduleScreenState();
}

class _PaymentScheduleScreenState extends State<PaymentScheduleScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? selectedPlaceName;
  String? selectedPlaceId;
  DateTime? selectedStartTime;
  DateTime? selectedEndTime;
  double calculatedFee = 0.0; // Variable to store the calculated fee

  List<dynamic> _places = [];

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
            Stack(
              children: [
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
            if (_places.isNotEmpty)
              Column(
                children: _places.map((place) {
                  return ListTile(
                    title: Text(place['landName'] ?? 'Land Name not available'),
                    subtitle: Text((place['availableSlot'] != null)
                        ? place['availableSlot'].toString()
                        : 'Slot info not available'),
                    onTap: () {
                      setState(() {
                        selectedPlaceName = place['landName'];
                        selectedPlaceId = place['_id'];
                      });
                      print('Selected place: $selectedPlaceName');
                      print('Selected id: $selectedPlaceId');
                    },
                  );
                }).toList(),
              ),

            SizedBox(height: screenHeight * 0.025),
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
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'DATE',
                hintText: 'YYYY-MM-DD',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dateController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
            ),
            SizedBox(height: 20),

            // Start Time Button
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedStartTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedStartTime != null) {
                  setState(() {
                    selectedStartTime = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      pickedStartTime.hour,
                      pickedStartTime.minute,
                    );
                    _calculateBookingFee(); // Calculate fee when start time is selected
                  });
                }
              },
              child: Text(
                selectedStartTime != null
                    ? 'Start Time: ${DateFormat('HH:mm').format(selectedStartTime!)}'
                    : 'SELECT START TIME',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(20, 20, 83, 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            SizedBox(height: 20),

            // End Time Button
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedEndTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedEndTime != null) {
                  setState(() {
                    selectedEndTime = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      pickedEndTime.hour,
                      pickedEndTime.minute,
                    );
                    _calculateBookingFee(); // Calculate fee when end time is selected
                  });
                }
              },
              child: Text(
                selectedEndTime != null
                    ? 'End Time: ${DateFormat('HH:mm').format(selectedEndTime!)}'
                    : 'SELECT END TIME',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(20, 20, 83, 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Display the calculated booking fee
            Center(
              child: Text(
                'LKR ${calculatedFee.toStringAsFixed(2)}', // Display fee
                style: TextStyle(
                  fontSize: 28,
                  color: Color.fromRGBO(20, 20, 83, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (selectedPlaceName != null &&
                    selectedPlaceId != null &&
                    selectedStartTime != null &&
                    selectedEndTime != null &&
                    _dateController.text.isNotEmpty) {
                  _schedulePayment();
                } else {
                  _showUnavailablePopup();
                }
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
    final String city = _locationController.text;
    final String url = 'http://localhost:3000/api/places/local?city=$city';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> places = data['results'];

        setState(() {
          _places = places;
        });

        if (places.isEmpty) {
          _showUnavailablePopup();
        }
      } else {
        print("Failed to load places: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching places: $e");
    }
  }

  void _calculateBookingFee() {
    if (selectedStartTime != null && selectedEndTime != null) {
      // Calculate the time difference in hours
      final duration =
          selectedEndTime!.difference(selectedStartTime!).inMinutes;
      final double hourlyRate = 150.0;
      
      setState(() {
        if(duration<=60){
          calculatedFee = 150.0;  
        }
         if(duration>=61){
          calculatedFee = (duration/60) * hourlyRate;
        }
        // Multiply by rate
      });
    }
  }

  void _schedulePayment() async {
    final String date = _dateController.text; // This is a non-nullable String
    final String userId = widget.userId; // Assuming this is non-null
    final String landId = selectedPlaceId!; // Now force unwrapping

    if (selectedStartTime != null &&
        selectedEndTime != null &&
        date.isNotEmpty) {
      try {
        DateTime parsedDate = DateTime.parse(date);

        DateTime fullStartTime = DateTime(
          parsedDate.year,
          parsedDate.month,
          parsedDate.day,
          selectedStartTime!.hour,
          selectedStartTime!.minute,
        );

        DateTime fullEndTime = DateTime(
          parsedDate.year,
          parsedDate.month,
          parsedDate.day,
          selectedEndTime!.hour,
          selectedEndTime!.minute,
        );

        final String apiUrl = 'http://localhost:3000/api/schedule/create';
        final Map<String, dynamic> scheduleData = {
          'landId': landId,
          'startTime': fullStartTime.toIso8601String(),
          'endTime': fullEndTime.toIso8601String(),
          'userId': userId,
          'date': date,
          'fee': calculatedFee,
        };

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(scheduleData),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Successfully scheduled, show success popup
          _showSuccessPopup();
        } else {
          print('Failed to create schedule: ${response.body}');
        }
      } catch (error) {
        print('Error scheduling payment: $error');
      }
    }
  }

  // Success Popup Function
  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Successful'),
          content: Text('Your booking has been created successfully.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
            ),
          ],
        );
      },
    );
  }

  void _showUnavailablePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scheduling currently unavailable'),
          content: Text(
              'Please select a valid location, date, and time to continue.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
