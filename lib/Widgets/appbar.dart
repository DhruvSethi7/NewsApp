import 'package:flutter/material.dart';
import '../Screens/MainScreen.dart';
Container appbar(Size mediaobj,String? locality) {
  return Container(
    height: mediaobj.height * 0.12,
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(mediaobj.width * 0.01, mediaobj.height * 0.05,
        mediaobj.width * 0.01, 0),
    decoration: BoxDecoration(
        color: const Color(0xff02011D),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(mediaobj.width * 0.05),
            bottomRight: Radius.circular(mediaobj.width * 0.05))),
    child:  Row(
      children: [
        IconButton(
            onPressed:(){
              print('Drawer');
             Scaffold.of(globalcontext!).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 40,
            )),
        // Text('Connection',style: TextStyle(color: Colors.white),),
        const Spacer(),
        if(locality!=null)Container(child: Text(locality,style: TextStyle(fontSize: 20,color: Colors.white,),)),
        const IconButton(
          icon: Icon(
            Icons.location_on,
            size: 30,
            color: Colors.white,
          ),
          onPressed: null,
        ),
        const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ))
      ],
    ),
  );
}