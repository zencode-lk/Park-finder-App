import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
   final String url = 'http://localhost:3000/api/places?location=${_currentLocation.latitude},${_currentLocation.longitude}&radius=5000&key=AIzaSyBgR3SW80TThORkVhmG6vuv4JhLk4P8pyE';
   print(url);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];
        
        setState(() {
          _markers.clear();
          for (var place in results) {
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
          CameraUpdate.newLatLngZoom(_currentLocation, 14.0),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Nearest Parking Location...'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                    if (_currentLocation != null) {
                      mapController!.animateCamera(
                        CameraUpdate.newLatLngZoom(_currentLocation, 14.0),
                      );
                    }
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 14.0,
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
                          CameraUpdate.newLatLngZoom(_currentLocation, 14.0),
                        );
                      }
                    },
                    child: Text('Re-centre'),
                  ),
                ),
              ],
            ),
          ),
          // Additional widgets for parking locations list
          // ...
        ],
      ),
    );
  }
}
