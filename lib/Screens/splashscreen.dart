import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    final mediaobj = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // First wave
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 1.0, end: 1.5),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (BuildContext context, double scale, Widget? child) {
                return Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: 1.5 - scale,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xff03004B).withOpacity(0.6),
                      radius: mediaobj.width * 0.22,
                    ),
                  ),
                );
              },
              onEnd: () {
                setState(() {
                  _scaleFactor = _scaleFactor == 1.0 ? 1.5 : 1.0;
                });
              },
            ),
           TweenAnimationBuilder(
              tween: Tween<double>(begin: 1.0, end: 1.4),
              duration: const Duration(seconds: 3),
              curve: Curves.easeInOut,
              builder: (BuildContext context, double scale, Widget? child) {
                return Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: 1.4 - scale,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xff6763D8).withOpacity(0.6),
                      radius: mediaobj.width * 0.22,
                    ),
                  ),
                );
              },
            ),
            // Main CircleAvatar
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: mediaobj.width * 0.2,
              backgroundImage: Image.asset('assets/Images/World.png').image,
            ),
          ],
        ),
      ),
    );
  }
}