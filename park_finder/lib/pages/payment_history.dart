import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentHistoryPage extends StatefulWidget {
  final String userId; // Pass the logged-in user's ID
  final String userPlateNumber; // Pass the user's vehicle plate number

  PaymentHistoryPage({required this.userId, required this.userPlateNumber});

  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  String availableCredits = "\Rs0"; // Initial available credits
  List<Map<String, dynamic>> paymentHistory = [];

  @override
  void initState() {
    super.initState();
    fetchUserBalanceAndPayments();
  }

  Future<void> fetchUserBalanceAndPayments() async {
  try {
    // Fetch user account balance
    final userResponse = await http.get(
      Uri.parse('http://192.168.215.201:3000/api/users/${widget.userId}'),
    );

    if (userResponse.statusCode == 200) {
      var userData = json.decode(userResponse.body); // Decode the API response into userData

      // Check if 'userAcc' exists and update availableCredits
      if (userData.containsKey('userAcc')) {
        var userAcc = userData['userAcc']; // Extract userAcc from userData

        // Check if userAcc is a Decimal128 object (i.e., Map with "$numberDecimal")
        if (userAcc is Map && userAcc.containsKey('\$numberDecimal')) {
          setState(() {
            availableCredits = "Rs.${userAcc['\$numberDecimal']}"; // Use the Decimal128 value
          });
        } else {
          setState(() {
            availableCredits = "Rs.${userAcc.toString()}"; // Handle regular string conversion
          });
        }
      } else {
        print("userAcc not found in the user data.");
      }
    } else {
      print("Failed to fetch user data. Status code: ${userResponse.statusCode}");
    }
print('Requesting: http://192.168.215.201:3000/api/parkingEvents/search?number_plate=${widget.userPlateNumber}');

    // Fetch payment history based on user's vehicle number plate
    final paymentResponse = await http.get(
      
      Uri.parse(
        
          'http://192.168.215.201:3000/api/parkingEvents/search?number_plate=${widget.userPlateNumber}'),
          
    );

    if (paymentResponse.statusCode == 200) {
  List<dynamic> payments = json.decode(paymentResponse.body);
  setState(() {
    paymentHistory = payments.map((payment) {
      // Check if parking_cost is a Decimal128 object
      var parkingCost = payment['parking_cost'];
      String amount = "Rs.0";
      if (parkingCost is Map && parkingCost.containsKey('\$numberDecimal')) {
        amount = "Rs.${parkingCost['\$numberDecimal']}";  // Extract Decimal128 value
      } else {
        amount = "Rs.${parkingCost.toString()}";  // Handle normal number or string
      }

      return {
        "date": payment['detected_time'],
        "amount": amount,
        "Duration": payment['duration'],
        "Number_Plate": payment['number_plate'],
      };
    }).toList();
  });
} else {
  print("Failed to fetch payment history. Status code: ${paymentResponse.statusCode}");
}

  } catch (e) {
    print("Error fetching data: $e");
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History"),
        backgroundColor: Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Color(0xFF9E9EEC)],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available Credits:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    availableCredits,
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ],
              ),
            ),
            Expanded(
              child: paymentHistory.isNotEmpty
                  ? ListView.builder(
                      itemCount: paymentHistory.length,
                      itemBuilder: (context, index) {
                        var transaction = paymentHistory[index];
                        return Card(
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text("Amount: ${transaction['amount']}"),
                            subtitle: Text(
                              "Date: ${transaction['date']}\n"
                              "Duration: ${transaction['Duration']}\n"
                              "Number Plate: ${transaction['Number_Plate']}",
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No payment history available.",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
