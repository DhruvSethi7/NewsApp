import 'package:flutter/material.dart';
import 'package:newsapp2/Screens/homepage.dart';
import 'package:newsapp2/Screens/language.dart';
import 'package:newsapp2/Screens/region.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import './Screens/login.dart';

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
                        side: BorderSide(
                            color: Colors.black,
                            width: 2) // Change this to your desired color
                        )),
                backgroundColor: MaterialStatePropertyAll(Color(0xff00E324)),
              ),
            )),
        routes: {
        RegionSelection.routeName:(context) => RegionSelection(),
        LanguageSelection.routeName:(context) => LanguageSelection(),
        HomePage.routeName:(context) => HomePage()
        },    
        home:LoginScreen());
  }
}
