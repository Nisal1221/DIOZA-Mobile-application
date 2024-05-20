import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/admin_panel/admin_authentication_page.dart';
import 'package:untitled2/constants/colors.dart';
import 'package:untitled2/constants/description.dart';
import 'package:untitled2/constants/styles.dart';
import 'package:untitled2/screens/authentication/register.dart';
import 'package:untitled2/screens/home/home.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  signInWithEmailAndPassword(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,

      );

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print('Invalid email or password');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password.'),
          ),
        );

        _email.clear();
        _password.clear();
      } else {
        print('An error occurred while signing in: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred while signing in.'),
          ),
        );
      }
    } catch (e) {
      print('Unexpected error: $e');
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
                    titlesign,
                    style: signStyle,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                description,
                style: descriptionStyle,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: Image.asset(
                      'assets/1.png',
                      height: 150,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _email,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Email is empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors
                                .white, // Set the desired color for the icon
                          ),
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              Colors.white, // Set the color for the input text
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _password,
                         obscureText: true,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Password is empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors
                                .white, // Set the desired color for the icon
                          ),
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              Colors.white, // Set the color for the input text
                        ),
                      ),
                      const SizedBox(height: 15),
                      /*Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),*/
                      const SizedBox(height: 20),
                      const Text("Login with social accounts",
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
                      const SizedBox(height: 20),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()),
                                );
                              },
                              child: Text(
                                'Create an Account',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            signInWithEmailAndPassword(context);
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
                          child: const Center(
                            child: Text(
                              "LOG IN",
                              style: TextStyle(
                                  color: abcD, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdminAuthenticationPage()),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            color: bgBlack,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: mainBlue),
                          ),
                          child: const Center(
                            child: Text(
                              "Admin log in",
                              style: TextStyle(
                                  color: abcD, fontWeight: FontWeight.w600),
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
