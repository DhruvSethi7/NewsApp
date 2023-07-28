import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp2/Widgets/signTile.dart';
import '../Widgets/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaobj = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: mediaobj.height * 0.345 +
                    mediaobj.width * 0.19 +
                    mediaobj.height * 0.1),
            child: Container(
              width: double.infinity,
              //  color: Colors.orange,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0,3),
                            blurRadius: 4.0,
                            color: Color(0xff000000).withOpacity(0.25),
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
                      Container(
                        height: 1,
                        width: mediaobj.width * 0.3,
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: mediaobj.width * 0.03,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: mediaobj.width * 0.03,
                      ),
                      Container(
                        height: 1,
                        width: mediaobj.width * 0.3,
                        child: Divider(
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
                            offset: Offset(0,3),
                            blurRadius: 4.0,
                            color: Color(0xff000000).withOpacity(0.25),
                          ),
                        ],
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.w800),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Container(
                          height: mediaobj.height * 0.053,
                          width: mediaobj.width * 0.3,
                          decoration: BoxDecoration(),
                          child: Center(
                            child: Text(
                              'NEXT',
                              style: TextStyle(fontSize: 24),
                            ),
                          )))
                ],
              ),
            ),
          ),
          Container(
            height: mediaobj.height * 0.345,
            decoration: BoxDecoration(
                color: Color(0xff02011d),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff000000).withOpacity(0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(mediaobj.width / 4),
                    bottomRight: Radius.circular(mediaobj.width / 4))),
          ),
          Positioned(
            top: mediaobj.height * 0.345 - mediaobj.width * 0.19,
            left: mediaobj.width / 2 - mediaobj.width * 0.19,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff000000).withOpacity(0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4)
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: mediaobj.width * 0.19,
                  ),
                ),
                Text(
                  'NAME',
                  style: TextStyle(fontSize: 34, fontFamily: 'Inter'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}