import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Models/User.dart';
class HomePage extends StatefulWidget {
  static String routeName='/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserData? userData;
  @override
  void initState() {
    // TODO: implement initState
    getCurrentUserData();
    super.initState();
  }
  Future<void> getCurrentUserData() async {
  try {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).get();
      if (userSnapshot.exists) {
        // If the user document exists, return the user object
        userData= UserData(uid:currentUser.uid, name:userSnapshot['name'], email:userSnapshot['email'], country:userSnapshot['country'], language:userSnapshot['language'], imageUrl:userSnapshot['profileurl']);
        setState(() {
          
        });
      }
    }
    return null; // User not found in Firestore
  } catch (e) {
    print("Error getting current user data: $e");
    return null;
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userData!=null?
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage:NetworkImage(userData!.imageUrl) ,
            ),
            Text('Name  is ${userData?.name}'),
            Text('Email is${userData?.email}'),
            Text('Country is ${userData?.country}'),
            Text('Language is ${userData?.country} ')
          ],
        ),
      ):Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(onPressed: (){
        getCurrentUserData();
      }),
    );
  }
}
