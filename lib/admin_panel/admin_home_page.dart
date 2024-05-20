import 'package:flutter/material.dart';
import 'package:untitled2/admin_panel/accessoies.dart';
import 'package:untitled2/admin_panel/mens_ware.dart';
import 'package:untitled2/admin_panel/womens_ware.dart';
import 'package:untitled2/constants/colors.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Text(
          'Admin Home Page',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Manage Items',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenswearPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade400,
              ),
              child: Text(
                'Menswear',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WomenswearPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400),
              child: Text(
                'Womenswear',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccessoriesPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400),
              child: Text(
                'Accessories',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
