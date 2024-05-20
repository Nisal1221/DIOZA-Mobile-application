import 'package:flutter/material.dart';
import 'package:untitled2/constants/colors.dart';
import 'package:untitled2/screens/home/veiwes/add_to_cart/cart_screen.dart';

class PromotionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            const Text(
              'Promotions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              width: 80,
            ),
            Image.asset(
              'assets/applogo.jpg',
              scale: 12,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: promotions.length,
        itemBuilder: (context, index) {
          return PromotionCard(promotion: promotions[index]);
        },
      ),
    );
  }
}

class Promotion {
  final String title;
  final String description;
  final String asset;
  final double discountPercentage;
  final String validityPeriod;
  final String termsAndConditions;

  Promotion({
    required this.title,
    required this.description,
    required this.asset,
    required this.discountPercentage,
    required this.validityPeriod,
    required this.termsAndConditions,
  });
}

class PromotionCard extends StatelessWidget {
  final Promotion promotion;

  const PromotionCard({Key? key, required this.promotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: const Color.fromARGB(255, 39, 38, 38),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            promotion.asset,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promotion.title,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  promotion.description,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${promotion.discountPercentage}% OFF',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Valid until ${promotion.validityPeriod}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // button is pressed
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text(
                    'Claim Offer',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Terms & Conditions: ${promotion.termsAndConditions}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Sample data
final List<Promotion> promotions = [
  Promotion(
    title: '🌟New Year Sale🌟',
    description: 'Get ready for New Year with amazing discounts!',
    asset: 'assets/newyear1.jpg',
    discountPercentage: 30,
    validityPeriod: '30 Apr 2024',
    termsAndConditions: 'You should buy at least 4 items to claim this offer.',
  ),
  Promotion(
    title: '⚡Flash Sale⚡',
    description: 'Limited time offer! Grab your favorites now.',
    asset: 'assets/flashsale.jpg',
    discountPercentage: 50,
    validityPeriod: '15 April 2024',
    termsAndConditions: 'Limited stock available.',
  ),

  Promotion(
    title: '💥Black Friday💥',
    description: 'Get ready for Black Friday with amazing discounts!',
    asset: 'assets/blackfriday.jpg',
    discountPercentage: 50,
    validityPeriod: '30 Apr 2024',
    termsAndConditions: 'You should buy at least 6 items to claim this offer.',
  ),
  // Add more promotions
];
