import 'package:flutter/material.dart';

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

class ParkingLocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Nearest Parking Location...'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map and Re-centre button
          Container(
            height: 300,
            child: Stack(
              children: [
                Center(child: Text('Map Here')), // Placeholder for map
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Re-centre'),
                  ),
                ),
              ],
            ),
          ),
          // Parking locations list
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
