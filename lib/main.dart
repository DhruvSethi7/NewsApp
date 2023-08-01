import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp2/Screens/homepage.dart';
import 'package:newsapp2/Screens/language.dart';
import 'package:newsapp2/Screens/region.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import './Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// Call this method when user completes onboarding
Future<void> setOnboardingComplete() async {
  User? user = _firebaseAuth.currentUser;
  if (user != null) {
    await _firestore.collection('users').doc(user.uid).set({
      'onboardingComplete': true,
    }, SetOptions(merge: true));
  }
}

// Call this method to check if onboarding is complete for the user
Future<bool> isOnboardingComplete() async {
  User? user = _firebaseAuth.currentUser;
  if (user != null) {
    DocumentSnapshot doc = await _firestore.collection('Users').doc(user.uid).get();
    return doc.get('country')!=null;
  }
  return false;
}



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green,
           
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(
                            color: Colors.black,
                            width: 2) // Change this to your desired color
                        )),
                backgroundColor: const MaterialStatePropertyAll(Color(0xff00E324)),
              ),
            )),
        routes: {
        RegionSelection.routeName:(context) => const RegionSelection(),
        LanguageSelection.routeName:(context) => LanguageSelection(),
        HomePage.routeName:(context) => const HomePage()
        },    
        home:const RootPage());
  }
}
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        print("Status is${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          print('User is'+user.toString());
          if (user == null) {
            return const LoginScreen(); // If user not signed in return Login Page
          } else {
            return FutureBuilder<bool>(
              future: isOnboardingComplete(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print("Data is ${snapshot.data.runtimeType}");

                  if (snapshot.data == true) {
                    print('homepage shifted');
                    return const HomePage();  // If onboarding is complete return Home Page
                  } else {
                    print("yahi aya");
                    return const RegionSelection();  // If onboarding is not complete return Onboarding Page
                  }
                } else {
                  return const CircularProgressIndicator();  // While checking onboarding status show loading screen
                }
              },
            );
          }
        } else {
          return const CircularProgressIndicator(); // While checking user state show loading screen
        }
      },
    );
  }
}