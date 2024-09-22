import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:park_finder/pages/user_register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ParkingLocationScreen(),
    );
  }
}

class ParkingLocationScreen extends StatefulWidget {
  @override
  _ParkingLocationScreenState createState() => _ParkingLocationScreenState();
}

class _ParkingLocationScreenState extends State<ParkingLocationScreen> {
  GoogleMapController? mapController;
  LatLng _currentLocation = LatLng(40.7580, -73.9855); // Default location
  final Set<Marker> _markers = {};
  final Location _location = Location();
 // Replace with your API key
List<dynamic> _places = [];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      final bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        final bool serviceRequested = await _location.requestService();
        if (!serviceRequested) {
          return;
        }
      }

      final PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        final PermissionStatus newPermission = await _location.requestPermission();
        if (newPermission != PermissionStatus.granted) {
          return;
        }
      }

      final LocationData locationData = await _location.getLocation();
      print("Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}"); // Debugging
      setState(() {
        _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        _addMarkers(); // Add markers after getting the location
        _fetchNearbyPlaces(); // Fetch nearby places
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _fetchNearbyPlaces() async {
  final String url = 'http://localhost:3000/api/places?location=${_currentLocation.latitude},${_currentLocation.longitude}&radius=1000';
  print(url);
  
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];

      setState(() {
        _places = results;
        _markers.clear();
        for (var place in _places) {
          final LatLng placeLocation = LatLng(
            place['geometry']['location']['lat'],
            place['geometry']['location']['lng'],
          );
          _markers.add(
            Marker(
              markerId: MarkerId(place['place_id']),
              position: placeLocation,
              infoWindow: InfoWindow(title: place['name']),
            ),
          );
          print(place['name']);
        }
      });
    } else {
      print("Failed to load places");
    }
  } catch (e) {
    print("Error fetching places: $e");
  }
}


  void _addMarkers() {
    // Add the marker for the current location
    final List<Marker> markers = [
      Marker(
        markerId: MarkerId('current_location'),
        position: _currentLocation,
        infoWindow: InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    ];

    setState(() {
      _markers.addAll(markers);
      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_currentLocation, 16.0),
        );
      }
    });
  }

  void _showPremiumPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(20, 20, 83, 1),
          content: Container(
            width: 300,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Click here to join as a premium user today,Shedule",
                  
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )
                ),
                SizedBox(height: 20),
                Text(
                  "Shedule",
                  
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserRegister(),
                    ));// Close the popup
                  },
                  child: Text(
                    "PREMIUM",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(20, 20, 83, 1),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Background color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Just for LKR 10,000",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.center,
          'Your Nearest Parking Location...',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,         
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          'Please select a parking loacation for navigation',
          style: TextStyle(
            fontSize: 19,         
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 20, 20, 83),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)
            )
          ),
          height: 300,
          width: 375,
          
          child: Stack(
            children: [
              GoogleMap(

                onMapCreated: (controller) {
                  mapController = controller;
                  if (_currentLocation != null) {
                    mapController!.animateCamera(
                      CameraUpdate.newLatLngZoom(_currentLocation, 16.0),
                    );
                  }
                },
                initialCameraPosition: CameraPosition(
                  target: _currentLocation,
                  zoom: 16.0,
                ),
                markers: _markers,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: ElevatedButton(
                  onPressed: () {
                    if (mapController != null) {
                      mapController!.animateCamera(
                        CameraUpdate.newLatLngZoom(_currentLocation, 16.0),
                      );
                    }
                  },
                  child: Text(
                    'Re-centre',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 23, 117, 239), 
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _places.length,
            itemBuilder: (context, index) {
              final place = _places[index];
              return ListTile(
                leading: Icon(Icons.location_pin),
                title: Text(place['name'] ?? 'No Name'), // Display place name
                subtitle: Text(place['vicinity']??'No Address'), // Display address
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Nearest'),
                    Text('50m'), // Placeholder text
                  ],
                ),
              );
            },
          ),
        ),
        Spacer(),
        // Bottom navigation bar
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_parking),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
          ],
          onTap: (index) {
            if (index == 0) {
                _showPremiumPopup(); // Show pop-up when the schedule button is pressed
            }
          },
        ),
      ],
    ),
  );
}

}
