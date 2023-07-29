import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp2/Screens/region.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_login/twitter_login.dart';
  String userName='';
  String profileUrl='';
class SignTile extends StatelessWidget {
  final String title;
  final String imageName;
  final Size mediaobj;
  SignTile(
      {required this.imageName, required this.mediaobj, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
       await FirebaseAuth.instance.signOut(); 
       if(title=='Google'){ 
       GoogleSignIn google_sign_in=GoogleSignIn();
       if(await google_sign_in.isSignedIn()){
        print('True');
        // return;
       }
       await google_sign_in.signOut();
       UserCredential? userCredential=await signInWithGoogle();
       if(userCredential!=null){
       addDataToFirestore(userCredential!,'Users',{'id':FirebaseAuth.instance.currentUser!.uid,'name':userCredential!.user!.email,'email':userCredential.user!.email,'profileurl':userCredential.user!.photoURL});
       Navigator.pushNamed(context, RegionSelection.routeName);
       }
       }
       else{
        //  Twitter login
        
       UserCredential userCredential=await signInWithTwitter();
       addDataToFirestore(userCredential!,'Users',{'id':FirebaseAuth.instance.currentUser!.uid,'name':userName,'email':userCredential.user!.email,'profileurl':profileUrl});
       Navigator.pushNamed(context, RegionSelection.routeName);

       }

      },
      child: Card(
        shadowColor: Colors.black,
        elevation: 5,
          shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
      side: BorderSide(color: Colors.black, width: 2),
      ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: mediaobj.width * 0.78,
          height: mediaobj.height * 0.06,
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/Images/${imageName}.svg',
                height: mediaobj.height * 0.04,
              ),
              SizedBox(width: 10,),
              Text(
                title,
                style: TextStyle(fontFamily: 'Inter',fontSize: 24,fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}

 Future<UserCredential> signInWithTwitter() async {
  // Create a TwitterLogin instance
  final twitterLogin = new TwitterLogin(
    apiKey: 'p5RiJNbyBX4AjYXjO4ovOVLJS',
    apiSecretKey:'8xkhZsXdfV4zZKhJxQm9QRKoLcjVmepwitrQnuDV4SwyYbzBCk',
    redirectURI: 'newsapp://'
  );

  // Trigger the sign-in flow
  final authResult = await twitterLogin.login();
  print('Name is ${authResult.user!.name}');
  print(authResult.status);
  // Create a credential from the access token
  final twitterAuthCredential = TwitterAuthProvider.credential(
    accessToken: authResult.authToken!,
    secret: authResult.authTokenSecret!,
  );
  userName=authResult.user!.name;
  profileUrl=authResult.user!.thumbnailImage;
   
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
}

Future<UserCredential?> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  try{
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
   
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
   
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  catch(e){
    print("Error is $e");
  }
}
Future<void> addDataToFirestore(UserCredential userCredential,String collectionName, Map<String, dynamic> data) async {
  try {
    await FirebaseFirestore.instance.collection(collectionName).doc(userCredential.user!.uid).set(data);
    print("Data added to Firestore successfully!");
  } catch (e) {
    print("Error adding data to Firestore: $e");
  }
}