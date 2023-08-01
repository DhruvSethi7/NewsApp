import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Models/User.dart';
import 'dart:math' as math;

enum buttonstates { init, loading, completed }


final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
class HomePage extends StatefulWidget {
  static String routeName = '/HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  UserData? userData;
  buttonstates buttonstate = buttonstates.init;
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();
  @override
  void initState() {
    // TODO: implement initState
    getCurrentUserData();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> getCurrentUserData() async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .get();
        if (userSnapshot.exists) {
          // If the user document exists, return the user object
          userData = UserData(
              uid: currentUser.uid,
              name: userSnapshot['name'],
              email: userSnapshot['email'],
              country: userSnapshot['country'],
              language: userSnapshot['language'],
              imageUrl: userSnapshot['profileurl']);
          setState(() {});
        }
      }
      return; // User not found in Firestore
    } catch (e) {
      print("Error getting current user data: $e");
      return;
    }
  }

  String url ='https://googleflutter.com/sample_image.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(onPressed:(){
                    signOut();
                  }, child:const Text('Sign Out')),
                  AnimatedBuilder(animation: controller, child: chotacircle(buttonstate),builder: (BuildContext context,Widget? child){
                    return Transform.rotate(angle: controller.value*2*math.pi,child: child);
                  }),
                ],
              ))),
    );
  }
}

Widget chotacircle(buttonstates buttonstate) {
  return const CircleAvatar(
    radius: 80,
    backgroundColor: Colors.black,
    child: CircleAvatar(
      radius: 70,
      backgroundColor: Colors.orange,
      child: Text('Ghum rha h bhai'),
    ),
  );
}


Future<void> signOut() async {
  try {
    await _googleSignIn.signOut();  // Google Sign Out
    await _firebaseAuth.signOut();  // Firebase Sign Out
  } catch (e) {
    print(e);  // Error handling
  }
}