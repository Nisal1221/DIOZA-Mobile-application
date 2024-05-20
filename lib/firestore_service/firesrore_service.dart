import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Method to create a menswear collection in Firestore
  Future<void> createMenswearCollection() async {
    try {
      // Get a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create the menswear collection
      await firestore.collection('menswear').doc('info').set({
        // You can add more fields here if needed
        'created_at': FieldValue.serverTimestamp(),
      });

      print('Menswear collection created successfully.');
    } catch (e) {
      print('Error creating menswear collection: $e');
    }
  }
}

void main() async {
  // Create an instance of FirestoreService
  FirestoreService firestoreService = FirestoreService();

  // Call the method to create the menswear collection
  await firestoreService.createMenswearCollection();
}