import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled2/constants/colors.dart';

import 'add_to_cart/cart_screen.dart';

class ItemDetails extends StatelessWidget {
  final Map<String, dynamic> item;
  String selectedSize = '';

  ItemDetails({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            Image.asset(
              'assets/applogo.jpg',
              scale: 9,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await addToCart(selectedSize, context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.cart,
              color: Colors.white, // Change the color to black
            ),
          ),
        ],
        iconTheme: IconThemeData(
            color:
                Colors.white), // Change the color of the back button to black
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 3,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(item['imagePath']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "⭐4.94(1000+)",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${item['price']}', // Convert to string
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${item['oldPrice']}', // Convert to string
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            buildSizeButton('S'),
                            buildSizeButton('M'),
                            buildSizeButton('L'),
                            buildSizeButton('XL'),
                            buildSizeButton('2XL'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: TextButton(
                          onPressed: () {
                            // Add item to cart logic here
                            addToCart(
                                selectedSize, context); // Use selectedSize
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSizeButton(String size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Set the selected size when the button is tapped
          selectedSize = size;
          print('Selected size: $selectedSize');
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black, // Change text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(30, 30), // Change button size
        ),
        child: Text(
          size,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Future<void> addToCart(String size, BuildContext context) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Obtain the user's email
        String email = user.email ?? '';

        // Create a reference to the Firestore collection 'add_to_cart' and the document with the user's email.
        CollectionReference cartRef =
            FirebaseFirestore.instance.collection('add_to_cart');
        DocumentReference userCartRef = cartRef.doc(email);

        // Check if the user's cart document already exists
        bool cartExists =
            await userCartRef.get().then((docSnapshot) => docSnapshot.exists);

        // Create a map containing the details of the item to add to the cart, including the selected size.
        Map<String, dynamic> cartItem = {
          'title': item['title'],
          'description': item['description'],
          'price': item['price'],
          'oldPrice': item['oldPrice'],
          'size': size, // Use the selected size
          'imagePath': item['imagePath'], // Add the image path
        };

        if (cartExists) {
          // If the cart exists, update the cart with the new item data
          userCartRef.update({
            'items': FieldValue.arrayUnion(
                [cartItem]) // Add the new item to the 'items' array
          }).then((value) {
            print('Item added to cart successfully!');
            // You can navigate to the cart page or show a message to the user.
          }).catchError((error) {
            print('Failed to add item to cart: $error');
          });
        } else {
          // If the cart doesn't exist, create a new cart document and add the item data
          userCartRef.set({
            'items': [cartItem] // Create a new 'items' array with the item data
          }).then((value) {
            print('Cart created and item added to cart successfully!');
            // You can navigate to the cart page or show a message to the user.
          }).catchError((error) {
            print('Failed to create cart and add item to cart: $error');
          });
        }
      } else {
        // Handle the case where the user is not logged in
        print('User is not logged in');
        // You can redirect the user to the login page or display a message asking them to log in.
        // For example:
        // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } catch (error) {
      print('Error adding item to cart: $error');
    }
  }
}
