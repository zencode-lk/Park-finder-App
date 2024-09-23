import 'package:flutter/material.dart';
import 'package:park_finder/pages/user-land_owner.dart';

// Entry point of the application
void main() {
  runApp(MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TermsAndConditionsPage(), // Set TermsAndConditionsPage as the home
    );
  }
}

// Terms and Conditions Page
class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _isChecked = false; // Variable to track if the checkbox is checked

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: TextStyle(color: Colors.white), // Heading text color set to white
        ),
        backgroundColor: Color.fromARGB(255, 5, 5, 5),

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Black back button
          onPressed: () {
            Navigator.of(context).pop(); // Action for back button
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '**Park Finder**',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Last Updated: ${DateTime.now().toLocal().toString().split(' ')[0]}', // Today's date
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '**Welcome to Park Finder**, developed by **Zencode Labs**! These Terms and Conditions ("Terms") govern your use of our mobile application and services (the "App"). Please read these Terms carefully before using the App. By accessing or using the App, you agree to be bound by these Terms. If you do not agree with these Terms, you may not use the App.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '1. Acceptance of Terms\n\n'
              'By downloading, installing, or using **Park Finder**, you agree to these Terms. We may update these Terms periodically, and it is your responsibility to review them regularly.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '2. Data Collection and Privacy\n\n'
              '• We collect location information, personal details, and car details during the registration process.\n'
              '• We use this information to provide our services, including showing available parking spots, managing bookings, and verifying user identities.\n'
              '• Your privacy is important to us.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '3. User Accounts\n\n'
              '• To use some features of the App, you may need to create an account. You are responsible for maintaining the confidentiality of your account credentials.\n'
              '• You must provide accurate and complete information when creating an account.\n'
              '• You are responsible for all activity that occurs under your account.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '4. Service Availability\n\n'
              '**Park Finder** provides users with parking location information and related services. While we strive to ensure accurate information, we do not guarantee the availability or accuracy of parking spots listed on the App.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '5. User Conduct\n\n'
              'You agree not to:\n'
              '• Use the App for any illegal or unauthorized purpose.\n'
              '• Interfere with or disrupt the operation of the App.\n'
              '• Provide false or misleading information.\n'
              '• Reverse-engineer or attempt to derive the source code of the App.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '6. Parking Terms\n\n'
              '• Users must ensure to park at their own risk, without looking at their phone while driving, and must not violate driving rules and regulations.\n'
              '• Security for vehicles parked is the responsibility of the user. **Park Finder** only provides information about available parking spots, and while some landowners may oversee their properties, it is not our responsibility.\n'
              '• Private locations may have security measures in place, but the landowner of private property is responsible for ensuring vehicle security.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '7. New Landowners\n\n'
              '• Newly registering landowners must contact us to obtain the necessary hardware for parking management.\n'
              '• Landowners are responsible for the costs associated with the hardware, which can be purchased outright or through installment plans.\n'
              '• We will collect all relevant land document information for security purposes.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '8. Commissions and Fees\n\n'
              '• **Park Finder** charges a 15% commission on each parking slot payment processed through the App.\n'
              '• Users must top up their accounts to make payments. If payment for a booked parking slot is not made, penalty fees may apply.\n'
              '• Membership may be canceled if payment is not received within 10 days of the due date.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '9. Booking and Payment\n\n'
              '• When a parking spot is booked, the amount charged will correspond to the hours the vehicle is parked.\n'
              '• If payment is not made, users will not be able to view available slots.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '10. System Accuracy\n\n'
              '• While we strive for accuracy, the system may not always provide precise information regarding available parking slots.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '11. Limitation of Liability\n\n'
              'We make no warranties or guarantees regarding the availability, accuracy, or reliability of the App. In no event shall **Zencode Labs** be liable for any indirect, incidental, or consequential damages arising from your use of the App.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '12. Termination\n\n'
              'We reserve the right to suspend or terminate your account and access to the App at our discretion, without notice, for any violation of these Terms.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '13. Governing Law\n\n'
              'These Terms are governed by the laws of Sri Lanka, and any disputes arising from your use of the App will be resolved in the courts of [Your Jurisdiction].',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '14. Contact Us\n\n'
              'If you have any questions or concerns about these Terms, please contact us at [Your Hotline].',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            // Checkbox with a label
            CheckboxListTile(
              title: Text(
                'I agree to the following terms and conditions',
                style: TextStyle(fontSize: 16),
              ),
              value: _isChecked, // Whether the checkbox is checked or not
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false; // Update the checkbox state
                });
              },
              controlAffinity: ListTileControlAffinity.leading, // Place checkbox at the start
            ),
            SizedBox(height: 20),
            // Continue button (can be disabled if the checkbox is not checked)
            ElevatedButton(
              onPressed: _isChecked
                  ? () {
                      // Action when checkbox is checked and button pressed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Terms and Conditions Accepted')),
                      );
                      Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserLandOwner(), // Pass the userId
                          ));
                    }
                  : null, // Disable button if checkbox is not checked
              child: Text('Continue'), // Changed text to "Continue"
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Correct background color usage
              ),
            ),
          ],
        ),
      ),
    );
  }
}
