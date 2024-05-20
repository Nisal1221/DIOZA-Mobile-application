import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  String _documentName = '';
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
        title: Text(
          'Update Menswear Item',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Text color
          ),
        ),
        backgroundColor: Colors.black, // Background color
        iconTheme: IconThemeData(
          color: Colors.white, // Back button color
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /*Text(
                'Update Menswear item',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),*/
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Document Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a document name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _documentName = value!;
                },
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
                    updateDataInFirestore();
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateDataInFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String imagePath = '';

    if (_image != null) {
      Reference storageRef = FirebaseStorage.instance.ref().child('menswear_images').child(_documentName);
      UploadTask uploadTask = storageRef.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;
      imagePath = await taskSnapshot.ref.getDownloadURL();
    }

    firestore.collection('menswear').doc(_documentName).update({
      'title': _title,
      'description': _description,
      'price': _price,
      'oldPrice': _oldPrice,
      if (imagePath.isNotEmpty) 'imagePath': imagePath,
    }).then((_) {
      print('Data updated in Firestore');
    }).catchError((error) {
      print('Error updating data in Firestore: $error');
    });
  }
}