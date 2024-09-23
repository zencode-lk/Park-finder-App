import 'package:flutter/material.dart';

void main() {
  runApp(LandOwnerDashboardApp());
}

class LandOwnerDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Land Owner Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LandOwnerDashboardScreen(),
    );
  }
}

class LandOwnerDashboardScreen extends StatelessWidget {
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
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Add profile navigation
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
        onPressed: () {
          // Add action for floating button
        },
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
          // Index row (e.g., "01")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(index, style: TextStyle(color: Colors.white70, fontSize: 20)),
              Text(income, style: TextStyle(color: Colors.white, fontSize: 18)),
              Text('income', style: TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
          SizedBox(height: 10),
          // Number count section
          Row(
            children: [
              // Blank square (if you have content to place, you can modify here)
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
              // Count with total count
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
}
