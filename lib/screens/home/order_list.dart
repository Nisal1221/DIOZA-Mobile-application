import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled2/constants/colors.dart';


class TOderListItems extends StatelessWidget {
  const TOderListItems({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            const Text(
              'Orders',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              width: 85,
            ),
            Image.asset(
              'assets/applogo.jpg',
              scale: 12,
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: getOrderTitles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemBuilder: (_, index) => TRoundedContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RowItem(
                      icon: Icons.delivery_dining,
                      text: 'Processing',
                      date: '07 April 2024',
                      hasButton: true,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: RowItem(
                            icon: CupertinoIcons.tag,
                            text: 'Order',
                            date: snapshot.data![index],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: RowItem(
                            icon: CupertinoIcons.calendar,
                            text: 'Deliver Date',
                            date: '22 April 2024',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<String>> getOrderTitles() async {
    User? user = FirebaseAuth.instance.currentUser;
    List<String> titles = [];
    if (user != null) {
      String email = user.email ?? '';
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance
          .collection('add_to_cart')
          .doc(email)
          .get();
      if (snapshot.exists) {
        List<dynamic> items = snapshot.data()!['items'] ?? [];
        titles = items.map((item) => item['title'] as String).toList();
      }
    }
    return titles;
  }

}

class TRoundedContainer extends StatelessWidget {
  final Widget child;

  const TRoundedContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
      ),
      padding: const EdgeInsets.all(12.0),
      child: child,
    );
  }
}

class RowItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String date;
  final bool hasButton;

  const RowItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.date,
    this.hasButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 35,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        if (hasButton)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios_outlined, size: 25),
          ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TOderListItems(),
  ));
}