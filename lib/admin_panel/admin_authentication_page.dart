import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/admin_panel/admin_home_page.dart';
import 'package:untitled2/constants/colors.dart';
import 'package:untitled2/constants/styles.dart';

class AdminAuthenticationPage extends StatefulWidget {
  @override
  _AdminAuthenticationPageState createState() =>
      _AdminAuthenticationPageState();
}

class _AdminAuthenticationPageState extends State<AdminAuthenticationPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _error = '';

  Future<String?> fetchAllowedEmailFromDatabase() async {
    // Implement this method to fetch the allowed email from the database
    // For demonstration purposes, let's assume the allowed email is hardcoded
    return 'nisallakshan@gmail.com';
  }

  signInWithEmailAndPassword(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });

      // Get the allowed email from the database
      String? allowedEmail = await fetchAllowedEmailFromDatabase();

      // Check if the entered email matches the allowed email
      if (_emailController.text != allowedEmail) {
        setState(() {
          isLoading = false;
          _error = 'You are not authorized to login with this email.';
        });
        return;
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      setState(() {
        isLoading = false;
      });

      // Navigate to home page if authentication is successful
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AdminHomePage(), // Replace HomePage with your actual home page widget
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print('Invalid email or password');
        setState(() {
          _error = 'Invalid email or password.';
        });
        _emailController.clear();
        _passwordController.clear();
      } else {
        print('An error occurred while signing in: ${e.message}');
        setState(() {
          _error = 'An error occurred while signing in.';
        });
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
        title: Text('Admin Authentication'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration:
                    InputDecoration(labelText: 'Email', labelStyle: signStyle),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                controller: _emailController,
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Password', labelStyle: signStyle),
                obscureText: true,
                validator: (val) =>
                    val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                controller: _passwordController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle:
                      TextStyle(color: const Color.fromARGB(255, 48, 21, 21)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    signInWithEmailAndPassword(context);
                  }
                },
                child: Text('Sign In'),
              ),
              SizedBox(height: 12),
              Text(
                _error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
