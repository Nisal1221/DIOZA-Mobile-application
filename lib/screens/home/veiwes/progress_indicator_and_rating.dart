import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarIndicatorW extends StatelessWidget {
  final double rating;
  final double itemSize;

  const RatingBarIndicatorW({
    Key? key,
    required this.rating,
    required this.itemSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: itemSize,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.white,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}