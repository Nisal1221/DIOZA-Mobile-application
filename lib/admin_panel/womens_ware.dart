import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled2/admin_panel/update_mens_ware.dart';
import 'package:untitled2/constants/colors.dart';


 // Import the update page

class WomenswearPage extends StatefulWidget {
  @override
  _WomenswearPageState createState() => _WomenswearPageState();
}

class _WomenswearPageState extends State<WomenswearPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  String _title = '';
  String _description = '';
  double _price = 0.0;
  double _oldPrice = 0.0;

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            const Text(
              'Womenswear',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              width: 40,
            ),
            Image.asset(
              'assets/applogo.jpg',
              scale: 12,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add a new Womenswear item',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: getImage,
                child: _image == null
                    ? Icon(Icons.add_photo_alternate, size: 100)
                    : Image.file(_image!, height: 200, width: 200),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Old Price',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an old price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _oldPrice = double.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    uploadDataToFirestore();
                  }
                },
                child: Text('Upload'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the update page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdatePage()), // Replace UpdatePage() with the actual update page
                  );
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void uploadDataToFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String imagePath = '';

    if (_image == null) {
      print('No image selected.');
      return;
    }

    Reference storageRef = FirebaseStorage.instance.ref().child('Womenswear_images').child(_title);
    UploadTask uploadTask = storageRef.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    imagePath = await taskSnapshot.ref.getDownloadURL();

    // Use the title as the document ID when adding data to Firestore
    firestore.collection('womenswear').doc(_title).set({
      'title': _title,
      'description': _description,
      'price': _price,
      'oldPrice': _oldPrice,
      'imagePath': imagePath,
    }).then((_) {
      print('Data added to Firestore');
    }).catchError((error) {
      print('Error adding data to Firestore: $error');
    });
  }
}