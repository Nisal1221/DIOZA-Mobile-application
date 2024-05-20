import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    Key? key, // Fix the Key parameter
    this.showAddRemoveButtons = true,
  }) : super(key: key); // Fix the super constructor call

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (_, __) => SizedBox(height: 32), // Fix separatorBuilder
      itemBuilder: (_, index) => Column(
        children: [
         // TCartItem(), // Use the correct widget name TCartItem
          if (showAddRemoveButtons) SizedBox(height: 10),
          if (showAddRemoveButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 90),
                  ],
                ),
                // add a remove button
                Icon(
                  CupertinoIcons.minus_circle,
                  size: 25,
                  color: Colors.white,
                ),
                const SizedBox(width: 1),
                Text(
                  '2',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(width: 1),
                Icon(
                  CupertinoIcons.plus_circle,
                  size: 25,
                  color: Colors.white,
                ),
                Text(
                  'LKR 8,300',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                )
              ],
            )
        ],
      ),
    );
  }
}