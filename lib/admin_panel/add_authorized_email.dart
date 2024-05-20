import 'package:cloud_firestore/cloud_firestore.dart';

// Function to insert authorized email into Firestore
Future<void> addAuthorizedEmail(String email) async {
  try {
    await FirebaseFirestore.instance.collection('authorized_emails').doc(email).set({
      'email': email,
    });
    print('Authorized email added successfully: $email');
  } catch (e) {
    print('Error adding authorized email: $e');
  }
}

void main() {
  // Call the function to add an authorized email
  addAuthorizedEmail('nisallakshan@gmail.com');
}