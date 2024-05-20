import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled2/constants/colors.dart';
import 'package:untitled2/constants/description.dart';
import 'package:untitled2/constants/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  File? _image;

  // Function to handle image selection from gallery
  // Function to handle image selection from gallery
  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  createUserWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });

      final email = _email.text;
      final password = _password.text;

      // Upload image to Firebase Storage
      String imageUrl = '';
      if (_image != null) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('user_profile_images')
            .child(email);
        await ref.putFile(_image!);
        imageUrl = await ref.getDownloadURL();
      }

      // Create user in Firebase Authentication
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create document in Firestore collection 'users' with email as document ID
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'email': email,
        'password': password,
        'profileImageUrl': imageUrl, // Save image URL in Firestore
      });

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Signin()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred while signing up.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            Image.asset(
              'assets/applogo.jpg',
              scale: 9,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    titleregister,
                    style: registerStyle,
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                description,
                style: descriptionStyle,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: _selectImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(
                              Icons.add_a_photo,
                              size: 50,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Email is empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Email",
                          labelText: "Email",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          labelStyle: TextStyle(
                              color: Colors
                                  .white), // Set label text color to white
                          hintStyle: TextStyle(
                              color:
                                  Colors.white), // Set hint text color to white
                          prefixIcon: Icon(
                            Icons.email,
                            color:
                                Colors.white, // Change the icon color to white
                          ),
                        ),
                        style: TextStyle(
                          color:
                              Colors.white, // Set the color for the input text
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        controller: _password,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Password is empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Password",
                          labelText: "Password",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          labelStyle: TextStyle(
                              color: Colors
                                  .white), // Set label text color to white
                          hintStyle: TextStyle(
                              color:
                                  Colors.white), // Set hint text color to white
                          prefixIcon: Icon(
                            Icons.lock,
                            color:
                                Colors.white, // Change the icon color to white
                          ),
                        ),
                        style: TextStyle(
                          color:
                              Colors.white, // Set the color for the input text
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Login with social accounts",
                          style: descriptionStyle),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: Image.asset(
                              'assets/gooogle.png',
                              height: 45,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: descriptionStyle,
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signin()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: mainBlue, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            createUserWithEmailAndPassword();
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            color: bgBlack,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: abcD),
                          ),
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: abcD,
                                fontWeight: FontWeight.w600,
                              ),
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
}
