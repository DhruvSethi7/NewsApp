import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignTile extends StatelessWidget {
  final String title;
  final String imageName;
  final Size mediaobj;
  SignTile(
      {required this.imageName, required this.mediaobj, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: mediaobj.width * 0.78,
      height: mediaobj.height * 0.06,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/${imageName}.svg',
            height: mediaobj.height * 0.04,
          ),
          SizedBox(width: 10,),
          Text(
            title,
            style: TextStyle(fontFamily: 'Inter',fontSize: 24,fontWeight: FontWeight.w600),
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(30)),
      
          ),
    );
  }
}
