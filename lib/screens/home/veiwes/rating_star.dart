
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled2/constants/colors.dart';
import 'package:untitled2/screens/home/veiwes/progress_indicator_and_rating.dart';

class ToOverallProductReviewScreen extends StatelessWidget {
  const ToOverallProductReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            const Text('Reviews and Ratings'),
            Image.asset(
              'assets/applogo.jpg',
              scale: 12,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ratings and reviews are verified and are from people who use the same type of device that you use ℹ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const ToOverallProductReviewScreen(),
              RatingBarIndicatorW(
                rating: 4.8,
                itemSize: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}