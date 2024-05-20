
import 'package:flutter/material.dart';
import 'package:untitled2/screens/home/home.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Text(
              'Payment Successful',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text(
              'Thank you for your payment!',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Your transaction was successful.',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate back to home
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Back to Home',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: PaymentSuccessPage(),
  ));
}