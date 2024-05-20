
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled2/constants/colors.dart';
import 'package:untitled2/screens/home/veiwes/item_details.dart';



class WomenScreen extends StatefulWidget {
  const WomenScreen({Key? key}) : super(key: key);

  @override
  _WomenScreenState createState() => _WomenScreenState();
}

class _WomenScreenState extends State<WomenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            const Text(
              'WomenWear',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              width: 70,
            ),
            Image.asset(
              'assets/applogo.jpg',
              scale: 12,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildStreamBuilder('womenitem1', 'womenitem2'),
            buildStreamBuilder('womenitem3', 'womenitem4'),
            buildStreamBuilder('womenitem5', 'womenitem6'),
            buildStreamBuilder('womenitem7', 'womenitem8'),
            buildStreamBuilder('womenitem9', 'womenitem10'),
            buildStreamBuilder('womenitem11', 'womenitem12'),
            buildStreamBuilder('womenitem13', 'womenitem14'),
            buildStreamBuilder('womenitem15', 'womenitem16'),
            buildStreamBuilder('womenitem17', 'womenitem18'),
            buildStreamBuilder('womenitem19', 'womenitem19'),
          ],
        ),
      ),
    );
  }

  Widget buildStreamBuilder(String documentId1, String documentId2) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: buildDocumentWidget(documentId1),
          ),
          SizedBox(width: 10),
          Expanded(
            child: buildDocumentWidget(documentId2),
          ),
        ],
      ),
    );
  }

  Widget buildDocumentWidget(String documentId) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('womenswear').doc(documentId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('No data available'));
        }
        var data = snapshot.data!.data()!;
        return buildItemWidget(data);
      },
    );
  }

  Widget buildItemWidget(Map<String, dynamic> data) {
    return Material(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
          bottom: Radius.circular(10),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Navigate to item details page and pass the item data
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemDetails(item: data)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(data['imagePath']),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 7,
                    ),
                    child: Text(
                      "🔥 HOT-Selling",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 1,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 7,
                    ),
                    child: Text(
                      "🚚  Free delivery",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                data['title'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                data['description'],
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        '${data['price']}', // Convert to string
                        style: TextStyle(
                          color: Color.fromARGB(255, 4, 76, 134),
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${data['oldPrice']}', // Convert to string
                        style: TextStyle(
                          color: Colors.blueGrey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.add_circle),
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