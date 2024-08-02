import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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
  GoogleMapController? mapController; // Make it nullable
 LatLng _currentLocation = LatLng(23.0525, 72.5667);
  final Set<Marker> _markers = {};
  final Location _location = Location();

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
        _addMarkers(); // Add markers after getting the location
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _addMarkers() {
    if (_currentLocation == null) return; // Ensure current location is not null

    final List<Marker> markers = [
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(_currentLocation!.latitude + 0.01, _currentLocation!.longitude),
        infoWindow: InfoWindow(title: 'Parking Location 1'),
      ),
      Marker(
        markerId: MarkerId('2'),
        position: LatLng(_currentLocation!.latitude, _currentLocation!.longitude + 0.01),
        infoWindow: InfoWindow(title: 'Parking Location 2'),
      ),
      // Add more markers as needed
    ];

    setState(() {
      _markers.addAll(markers);
      if (mapController != null && _currentLocation != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_currentLocation!, 14.0),
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
                        CameraUpdate.newLatLngZoom(_currentLocation!, 14.0),
                      );
                    }
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation ?? LatLng(0, 0),
                    zoom: 14.0,
                  ),
                  markers: _markers,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentLocation != null && mapController != null) {
                        mapController!.animateCamera(
                          CameraUpdate.newLatLngZoom(_currentLocation!, 14.0),
                        );
                      }
                    },
                    child: Text('Re-centre'),
                  ),
                ),
              ],
            ),
          ),
          // Parking locations list (can be updated based on fetched data)
          ListTile(
            leading: Icon(Icons.location_pin),
            title: Text("LNBTI's car park"),
            subtitle: Text('High level rd, Maharagama'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Nearest'),
                Text('50m'),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.local_parking),
            title: Text('Silva\'s car park'),
            subtitle: Text('Old kottawa rd, Maharagama'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('170m'),
                Text('(5 Slots)'),
              ],
            ),
          ),
          Spacer(),
          // Bottom navigation bar
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
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
            onTap: (index) {},
          ),
        ],
      ),
    );
  }
}
