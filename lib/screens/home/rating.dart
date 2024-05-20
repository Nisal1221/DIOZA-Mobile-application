
import 'package:flutter/material.dart';
import 'package:untitled2/constants/colors.dart';
import 'package:untitled2/screens/home/veiwes/user_review_card.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({Key? key}) : super(key: key);

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
              scale: 14,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4.8',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingRowWidget(text: '5', value: 1.0),
                      RatingRowWidget(text: '4', value: 0.8),
                      RatingRowWidget(text: '3', value: 0.6),
                      RatingRowWidget(text: '2', value: 0.4),
                      RatingRowWidget(text: '1', value: 0.2),
                      Text(
                        "1,220",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                  height:
                  2), // Add some space between the existing column and the new column

              Column(
                children: [
                  ReviewForm(onSubmit: (String name, double rating, String review) {  },),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RatingRowWidget extends StatelessWidget {
  const RatingRowWidget({
    required this.text,
    required this.value,
    Key? key,
  }) : super(key: key);
  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ' $text',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 230,
          height: 10,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 11,
            backgroundColor: Colors.grey.shade800,
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ],
    );
  }
}