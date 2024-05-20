
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled2/constants/colors.dart';
import 'package:untitled2/screens/home/veiwes/add_to_cart/check_out.dart';





class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            const Text(
              'My Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              width: 120,
            ),
            Image.asset(
              'assets/applogo.jpg',
              scale: 12,
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('Your cart is empty'));
          } else {
            return Container(
              color: Colors.black, // Set background color to black
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data![index];
                        return buildCartItem(context, item);
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      double subtotal = calculateSubtotal(snapshot.data!);
                      // Navigate to the checkout page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckOutScreen(subtotal: subtotal)),
                      );
                    },
                    child: Text('Checkout'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildCartItem(BuildContext context, Map<String, dynamic> item) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(item['imagePath']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item['description'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Size: ${item['size']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'LKR ${item['price']}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    removeFromCart(context, item);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email ?? '';
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('add_to_cart').doc(email).get();
      if (snapshot.exists) {
        List<dynamic> items = snapshot.data()!['items'] ?? [];
        return items.cast<Map<String, dynamic>>().toList();
      }
    }
    return [];
  }

  void removeFromCart(BuildContext context, Map<String, dynamic> item) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email ?? '';
      CollectionReference cartRef = FirebaseFirestore.instance.collection('add_to_cart');
      DocumentReference userCartRef = cartRef.doc(email);

      await userCartRef.update({
        'items': FieldValue.arrayRemove([item])
      }).then((value) {
        print('Item removed from cart successfully!');
        // Refresh the cart page after removing the item
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CartScreen()));
      }).catchError((error) {
        print('Failed to remove item from cart: $error');
      });
    }
  }

  double calculateSubtotal(List<Map<String, dynamic>> items) {
    double subtotal = 0;
    for (var item in items) {
      // Assuming the price is stored in 'price' key of each item map
      subtotal += item['price'];
    }
    return subtotal;
  }
}

void main() {
  runApp(MaterialApp(
    home: CartScreen(),
  ));
}