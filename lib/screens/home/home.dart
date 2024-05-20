import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/constants/colors.dart';
import 'package:untitled2/screens/authentication/login.dart';
import 'package:untitled2/screens/home/rating.dart';
import 'package:untitled2/screens/home/veiwes/acc.dart';
import 'package:untitled2/screens/home/veiwes/add_to_cart/cart_screen.dart';
import 'package:untitled2/screens/home/veiwes/test_men.dart';
import 'package:untitled2/screens/home/veiwes/womens_ware.dart';
import 'package:untitled2/screens/promotions.dart';

import 'order_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _handleButtonPress(String buttonText) {
    // Implement your button press logic here based on buttonText
    print('Button pressed: $buttonText');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            Image.asset(
              'assets/applogo.jpg',
              scale: 9,
            )
          ],
        ),
        actions: [
          // Addtocart
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: const Icon(CupertinoIcons.cart)),
          // Logout
          IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                // Redirect the user to the login page or any other appropriate action after logout.
                // For example:
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Signin()));
              } catch (e) {
                print("Error signing out: $e");
              }
            },
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                "Welcome to DIOZA !",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TestScreen()));
                        },
                        child: Container(
                          height: 108,
                          width: 175,
                          decoration: BoxDecoration(
                            color: bgBlack,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 2, color: abcD),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.2), // Adjust opacity for desired shadow intensity
                                spreadRadius:
                                    4, // Adjust spreadRadius for shadow diffusion
                                blurRadius:
                                    7, // Adjust blurRadius for shadow softness
                                offset: Offset(0,
                                    3), // Adjust offset for shadow position (x, y)
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Men's wear",
                              style: TextStyle(
                                color: abcD,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WomenScreen()))
                        },
                        child: Container(
                          height: 108,
                          width: 175,
                          decoration: BoxDecoration(
                            color: bgBlack,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 2, color: abcD),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.2), // Adjust opacity for desired shadow intensity
                                spreadRadius:
                                    4, // Adjust spreadRadius for shadow diffusion
                                blurRadius:
                                    7, // Adjust blurRadius for shadow softness
                                offset: Offset(0,
                                    3), // Adjust offset for shadow position (x, y)
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Women's wear",
                              style: TextStyle(
                                  color: abcD,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AccScreen()))
                        },
                        child: Container(
                          height: 108,
                          width: 175,
                          decoration: BoxDecoration(
                            color: bgBlack,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 2, color: abcD),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.2), // Adjust opacity for desired shadow intensity
                                spreadRadius:
                                    4, // Adjust spreadRadius for shadow diffusion
                                blurRadius:
                                    7, // Adjust blurRadius for shadow softness
                                offset: Offset(0,
                                    3), // Adjust offset for shadow position (x, y)
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Accessories",
                              style: TextStyle(
                                  color: abcD,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TOderListItems()))
                        },
                        child: Container(
                          height: 108,
                          width: 175,
                          decoration: BoxDecoration(
                            color: bgBlack,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 2, color: abcD),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.2), // Adjust opacity for desired shadow intensity
                                spreadRadius:
                                    4, // Adjust spreadRadius for shadow diffusion
                                blurRadius:
                                    7, // Adjust blurRadius for shadow softness
                                offset: Offset(0,
                                    3), // Adjust offset for shadow position (x, y)
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Orders",
                              style: TextStyle(
                                  color: abcD,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProductReviewScreen()))
                        },
                        child: Container(
                          height: 108,
                          width: 175,
                          decoration: BoxDecoration(
                            color: bgBlack,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 2, color: abcD),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.2), // Adjust opacity for desired shadow intensity
                                spreadRadius:
                                    4, // Adjust spreadRadius for shadow diffusion
                                blurRadius:
                                    7, // Adjust blurRadius for shadow softness
                                offset: Offset(0,
                                    3), // Adjust offset for shadow position (x, y)
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Feedback",
                              style: TextStyle(
                                  color: abcD,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PromotionsPage()))
                        },
                        child: Container(
                          height: 108,
                          width: 175,
                          decoration: BoxDecoration(
                            color: bgBlack,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 2, color: abcD),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.2), // Adjust opacity for desired shadow intensity
                                spreadRadius:
                                    4, // Adjust spreadRadius for shadow diffusion
                                blurRadius:
                                    7, // Adjust blurRadius for shadow softness
                                offset: Offset(0,
                                    3), // Adjust offset for shadow position (x, y)
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Promotions",
                              style: TextStyle(
                                  color: abcD,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
