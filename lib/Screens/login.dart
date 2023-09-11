import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp2/Screens/language.dart';
import 'package:newsapp2/Widgets/signTile.dart';
import '../Widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  warningdialog(BuildContext context, Size mediaobj) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.only(top: mediaobj.height * 0.22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          height: mediaobj.height * 0.36,
          width: mediaobj.width * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/Icons/warning.svg'),
              addverticalSpace(mediaobj.height * 0.03),
              const Text(
                'Without Sign In you will loose some features ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    //  shadows: [
                    //    Shadow(
                    //      offset: Offset(0, 4),
                    //      blurRadius: 3
                    //      ,color: Colors.black.withOpacity(0.25)
                    //    )
                    //  ],
                     fontFamily: 'Outfit',

                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              addverticalSpace(mediaobj.height * 0.04),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: mediaobj.height * 0.05,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xff00E324)),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Inter'),
                    ),
                  ),
                ),
              ),
              addverticalSpace(mediaobj.height * 0.02),
              GestureDetector(
                onTap: () async {
                  try {
                    final userCredential =
                        await FirebaseAuth.instance.signInAnonymously();
                    print("Signed in with temporary account.");

                    // Get a reference to the Firestore instance.
                    FirebaseFirestore firestore = FirebaseFirestore.instance;

                    // Add the user data to Firestore
                    firestore
                        .collection('Users')
                        .doc(userCredential.user?.uid)
                        .set({
                      'provider':
                          'anonymous', // Add additional fields as needed
                      // 'fieldName': 'value',
                    });
                  } on FirebaseAuthException catch (e) {
                    print(e.code);
                    if(e.code=='network-request-failed'){
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something Went  Wrong')));
                      return;
                    }
                    switch (e.code) {
                      case "operation-not-allowed":
                        print(
                            "Anonymous auth hasn't been enabled for this project.");
                        break;
                      default:
                        print("Unknown error.");
                    }
                  }
                  Navigator.pushNamedAndRemoveUntil(
                      context, LanguageSelection.routeName, (route) => false);
                },
                child: Container(
                  height: mediaobj.height * 0.05,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xff00E324)),
                  child: const Center(
                    child: Text(
                      'May be later',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Inter'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
   late Animation<Offset> _positionAnimation2;
  late Animation<double> _sizeAnimation;
   @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _positionAnimation2 = Tween<Offset>(
      begin: const Offset(0,-1),
      end: const Offset(0,0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)); 
    _positionAnimation = Tween<Offset>(
      begin: const Offset(0.8,2),
      end: const Offset(0.8, 1.4),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)); 
    _sizeAnimation = Tween<double>(
      begin: 1.2,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mediaobj = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: mediaobj.height * 0.3 +
                    mediaobj.width * 0.19 +
                    mediaobj.height * 0.1),
            child: SizedBox(
              width: double.infinity,
              //  color: Colors.orange,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        shadows: <Shadow>[
                          Shadow(
                            offset: const Offset(0, 3),
                            blurRadius: 4.0,
                            color: const Color(0xff000000).withOpacity(0.25),
                          ),
                        ]),
                  ),
                  addverticalSpace(mediaobj.height * 0.02),
                  SignTile(
                      imageName: 'google', mediaobj: mediaobj, title: 'Google'),
                  addverticalSpace(mediaobj.height * 0.02),
                  SignTile(
                      imageName: 'twitter',
                      mediaobj: mediaobj,
                      title: 'Twitter'),
                  addverticalSpace(mediaobj.height * 0.02),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 1,
                        width: mediaobj.width * 0.3,
                        child: const Divider(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: mediaobj.width * 0.03,
                      ),
                      const Text(
                        'OR',
                        style: TextStyle(
                             fontFamily: 'Outfit',
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: mediaobj.width * 0.03,
                      ),
                      SizedBox(
                        height: 1,
                        width: mediaobj.width * 0.3,
                        child: const Divider(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  addverticalSpace(mediaobj.height * 0.04),
                  Text(
                    'Skip Sign In',
                    style: TextStyle(
                      
                        shadows: <Shadow>[
                          Shadow(
                            offset: const Offset(0, 3),
                            blurRadius: 4.0,
                            color: const Color(0xff000000).withOpacity(0.25),
                          ),
                        ],
                         fontFamily: 'Outfit',
                        fontSize: 24,
                        fontWeight: FontWeight.w800),
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          shadowColor: MaterialStatePropertyAll(Colors.black),
                          elevation: MaterialStatePropertyAll(10)),
                      onPressed: () {
                        warningdialog(context, mediaobj);
                      },
                      child: Container(
                          height: mediaobj.height * 0.053,
                          width: mediaobj.width * 0.3,
                          decoration: const BoxDecoration(),
                          child: const Center(
                            child: Text(
                              'NEXT',
                              style: TextStyle( fontFamily: 'Outfit',fontSize: 24),
                            ),
                          )))
                ],
              ),
            ),
          ),
          SlideTransition(
            position: _positionAnimation2,
            child: Container(
              height: mediaobj.height * 0.345,
              decoration: BoxDecoration(
                  color: const Color(0xff02011d),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff000000).withOpacity(0.25),
                        offset: const Offset(0, 4),
                        blurRadius: 4)
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(mediaobj.width / 5),
                      bottomRight: Radius.circular(mediaobj.width / 5))),
            ),
          ),
          SlideTransition(
      position: _positionAnimation,
      child: ScaleTransition(
        scale: _sizeAnimation,
        child: Positioned(
            top: mediaobj.height * 0.345 - mediaobj.width * 0.19,
            left: mediaobj.width / 2 - mediaobj.width * 0.19,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff000000).withOpacity(0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: mediaobj.width * 0.19,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: mediaobj.width * 0.182,
                    backgroundImage: const AssetImage('assets/Images/World.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        ],
      ),
    );
  }
}
