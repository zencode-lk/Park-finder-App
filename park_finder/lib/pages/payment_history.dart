import 'package:flutter/material.dart';

class PaymentHistoryPage extends StatelessWidget {
  final List<Map<String, String>> paymentHistory = [
    {
      "date": "2024-10-01",
      "amount": "\$200",
      "method": "Credit Card",
      "status": "Completed"
    },
    {
      "date": "2024-09-15",
      "amount": "\$100",
      "method": "PayPal",
      "status": "Pending"
    },
    {
      "date": "2024-08-28",
      "amount": "\$150",
      "method": "Bank Transfer",
      "status": "Completed"
    },
  ];

  final String availableCredits = "\$500"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment History"),
        backgroundColor: const Color.fromRGBO(20, 20, 83, 1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Container(
        decoration: const BoxDecoration(
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
                const Text(
                  "Available Credits:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  availableCredits,
                  style: const TextStyle(fontSize: 18, color: Colors.green),
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
                        "Method: ${transaction['method']}\n"
                        "Status: ${transaction['status']}",
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              )
            : const Center(
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
