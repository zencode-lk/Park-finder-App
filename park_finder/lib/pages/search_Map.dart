import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:park_finder/pages/premium_user_dashboard.dart';
import 'package:park_finder/pages/schedule.dart';
import 'package:park_finder/pages/user_login.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:geolocator/geolocator.dart'; // For distance calculations
import 'package:park_finder/pages/user_register.dart';


class ParkingLocationScreen extends StatefulWidget {
  final bool isLoggedIn; 

  ParkingLocationScreen({required this.isLoggedIn});

  @override
  _ParkingLocationScreenState createState() => _ParkingLocationScreenState();
}

class _ParkingLocationScreenState extends State<ParkingLocationScreen> {
  GoogleMapController? mapController;
  LatLng _currentLocation = const LatLng(40.7580, -73.9855); // Default location
  final Set<Marker> _markers = {};
  final Location _location = Location();
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
      setState(() {
        _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        _addMarkers();
        _fetchNearbyPlaces(); 
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _fetchNearbyPlaces() async {
    final String url = 'http://172.20.10.2:3000/api/places?location=${_currentLocation.latitude},${_currentLocation.longitude}&radius=5000';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];

        setState(() {
          _places = results.map((place) {
            final LatLng placeLocation = LatLng(
              place['geometry']['location']['lat'],
              place['geometry']['location']['lng'],
            );

            // Calculate distance between current location and place location
            double distance = Geolocator.distanceBetween(
              _currentLocation.latitude,
              _currentLocation.longitude,
              placeLocation.latitude,
              placeLocation.longitude,
            ) / 1000; // Convert meters to kilometers

            return {
              'place': place,
              'distance': distance, // Add distance to each place
            };
          }).toList();

          // Sort the places by distance
          _places.sort((a, b) => a['distance'].compareTo(b['distance']));

          _markers.clear();
          for (var item in _places) {
            final place = item['place'];
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
    final List<Marker> markers = [
      Marker(
        markerId: const MarkerId('current_location'),
        position: _currentLocation,
        infoWindow: const InfoWindow(title: 'Your Location'),
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

  void _launchMapsUrl(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showPremiumPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(20, 20, 83, 1),
          content: Container(
            width: 300,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Click here to join as a premium user today",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )
                ),
                const SizedBox(height: 20),
                const Text(
                  "Schedule",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserRegister(),
                    ));
                  },
                  child: Text(
                    "PREMIUM",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(20, 20, 83, 1),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Color(0xFF9E9EEC)], 
          ),
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              textAlign: TextAlign.center,
              'Your Nearest Parking Location...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Race Sport',
                fontSize: 30,         
              ),
            ),
            const Text(
              textAlign: TextAlign.center,
              'Please select a parking location for navigation',
              style: TextStyle(
                fontSize: 19,         
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 350, 
              width: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // Changes the position of the shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), 
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
                        child: const Text(
                          'Re-center',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 23, 117, 239), 
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  final place = _places[index]['place'];
                  final distance = _places[index]['distance']; // Get the distance
                  final LatLng placeLocation = LatLng(
                    place['geometry']['location']['lat'],
                    place['geometry']['location']['lng'],
                  );
                  return ListTile(
                    leading: const Icon(Icons.location_pin),
                    iconColor: const Color.fromARGB(255, 20, 20, 83),
                    title: Text(
                      place['name'] ?? 'No Name',
                      style: const TextStyle(
                        color: Color.fromRGBO(20, 20, 83, 1),
                      ),
                    ), // Display place name
                    subtitle: Text(
                      place['vicinity'] ?? 'No Address',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ), // Display address
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${distance.toStringAsFixed(2)} km',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ), // Display distance
                      ],
                    ),
                    onTap: () {
                      _launchMapsUrl(placeLocation.latitude, placeLocation.longitude); // Launch Google Maps
                    },
                  );
                },
              ),
            ),
            // Container(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => SignInScreen(),
            //       ));
            //     },
            //     style: ElevatedButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       padding: const EdgeInsets.symmetric(vertical: 20),
            //       backgroundColor: Colors.white,
            //     ),
            //     child: const Center(
            //       child: Text(
            //         'Private parking location',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20,),
            // Bottom navigation bar
            Container(
              height: 70,
              child: BottomNavigationBar(
                backgroundColor: const Color(0xFF9E9EEC),
                iconSize: 30.0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.schedule),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    label: '',
                  ),
                ],
                onTap: (index) {
                  if (widget.isLoggedIn) {
                    if (index == 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaymentScheduleScreen(),
                      ));
                    }
                    if (index == 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen(userId: "66efc133b6f54c14ec81d843",),
                      ));
                    }
                  } else {
                    _showPremiumPopup();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
