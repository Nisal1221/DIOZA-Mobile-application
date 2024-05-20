import 'package:flutter/material.dart';
import 'package:untitled2/constants/colors.dart';
import 'package:untitled2/screens/home/veiwes/add_to_cart/payment_success_page.dart';

class CheckOutScreen extends StatelessWidget {
  final double subtotal;

  const CheckOutScreen({Key? key, required this.subtotal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            Expanded(
              // Wrap the AppBar title with Expanded
              child: Text(
                'Buy now',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              width: 110,
            ),
            Image.asset(
              'assets/applogo.jpg',
              scale: 12,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              // Your cart items widget goes here
              const SizedBox(height: 32),

              /// billing section
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade600, // Background Color
                  border: Border.all(color: Colors.white), // Border
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Column(
                  children: [
                    /// Subtotal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('  Subtotal',
                            style: TextStyle(color: Colors.black)),
                        Text('LKR $subtotal ',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 20 / 2),

                    /// Delivery fee
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('  Delivery fee',
                            style: TextStyle(color: Colors.black)),
                        Text('LKR 300 ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 20 / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('  Order Total',
                            style: TextStyle(color: Colors.black)),
                        Text(
                            'LKR ${subtotal + 300} ', // Add delivery fee to subtotal
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: 20 / 2,
                    ),
                    // Divider
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),

                    // Payment section
                    Column(
                      children: [
                        Text(
                          'Pay with ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        Image.asset(
                          'assets/paypal2.jpg',
                          height: 70,
                          width: 100,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentSuccessPage(),
            ),
          );
        },
        child: Text('Pay Now'),
      ),
    );
  }
}
