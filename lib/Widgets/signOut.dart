import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _db = FirebaseFirestore.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

void signOut() async {
  User? currentUser = _auth.currentUser;

  if (currentUser != null) {
    DocumentSnapshot userDocument;
    try {
      userDocument = await _db.collection('Users').doc(currentUser.uid).get();
    } catch (e) {
      print('Error fetching user document from Firestore: $e');
      return;
    }

    if (userDocument.exists) {
      String? provider = userDocument.get('provider');

      if (provider == 'anonymous') {
        // Anonymous user
        try {
          await _db.collection('users').doc(currentUser.uid).delete();
        } catch (e) {
          print('Error deleting user from Firestore: $e');
        }
      } else if (provider == 'google') {
        // Google sign-in user
        await googleSignIn.signOut();
      }
    } else {
      print('No document found for user ${currentUser.uid}');
    }

    // Sign out the user from Firebase
    await _auth.signOut();
  } else {
    print('No user is currently signed in.');
  }
}
