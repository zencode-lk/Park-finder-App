import 'package:flutter/material.dart';
import 'package:park_finder/pages/land_registration.dart';
import 'package:park_finder/pages/review.dart';
import 'package:park_finder/pages/land_owner_profile.dart';
import 'package:park_finder/pages/user_register.dart'; // Ensure this imports the correct profile page

void main() {
  runApp(MyApp());
}
                                       
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Land Owner Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LandOwnerDashboardScreen(userId: 'user123'),
    );
  }
}

class LandOwnerDashboardScreen extends StatelessWidget {
  final String userId;

  LandOwnerDashboardScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        leading: Icon(Icons.menu, color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total income ', style: TextStyle(color: Colors.white70)),
            Text('Rs. 20,000.00', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.person, color: Colors.white),
            onSelected: (String choice) {
              switch (choice) {
                case 'Profile':
                  _navigateToProfile(context);
                  break;
                case 'Reviews':
                  _showReviews(context);
                  break;
                case 'Terms and Conditions':
                  _showTermsAndConditions(context);
                  break;
                case 'Become a User':
                  _navigateToBecomeUser(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                'Profile',
                'Reviews',
                'Terms and Conditions',
                'Become a User'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildIncomeCard(
              index: '01',
              income: 'LKR.5000.00',
              count: '15',
              totalCount: '20',
            ),
            SizedBox(height: 20),
            _buildIncomeCard(
              index: '02',
              income: 'LKR.15000.00',
              count: '07',
              totalCount: '30',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildIncomeCard({
    required String index,
    required String income,
    required String count,
    required String totalCount,
  }) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(index, style: TextStyle(color: Colors.white70, fontSize: 20)),
              Text(income, style: TextStyle(color: Colors.white, fontSize: 18)),
              Text('income', style: TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 60,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.purple.shade900,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(count, style: TextStyle(color: Colors.white, fontSize: 24)),
                      Text(totalCount, style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToProfile(BuildContext context) {
    // Navigate to the Profile page with sample data
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LandOwnerProfilePage(
        name: 'John Doe',
        email: 'johndoe@example.com',
      ),
    ));
  }

  void _showReviews(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ReviewPage(),
    ));
  }

  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terms and Conditions'),
          content: SingleChildScrollView(
            child: Text('These are the terms and conditions...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToBecomeUser(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UserRegister(),
    ));
  }
}
