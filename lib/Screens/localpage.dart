import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:newsapp2/Screens/MainScreen.dart';
import '../Widgets/appbar.dart';
import '../Widgets/newstile.dart';
import '../Provider/newsprovider.dart';
import 'package:geolocator/geolocator.dart';

class LocalNews extends StatefulWidget {
  const LocalNews({super.key});

  @override
  State<LocalNews> createState() => _LocalNewsState();
}

class _LocalNewsState extends State<LocalNews> {
  Position? position;
  String? locality;
  bool serviceEnabled=false;
  @override
  void initState() {
    super.initState();
    checkpermission();
  }
  checkpermission()async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
         showDialog(context: context, builder: (context)=>Dialog(
             child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: ()async{
                       permission = await Geolocator.requestPermission();
                       decodepositon(await Geolocator.getCurrentPosition());
                       serviceEnabled=true;
                       Navigator.pop(context);
                }, child: const Text('Grant')),
                TextButton(onPressed:(){ Navigator.pushNamed(context, MainScreen.routeName);}, child:const Text('Later'))
              ],
             ),
         ));
    }
    else{
      serviceEnabled=true;
      decodepositon(await Geolocator.getCurrentPosition());
    }
  }

  decodepositon(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark p = placemarks[0];
    locality = p.locality;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaobj = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          if (serviceEnabled) SizedBox(
              height: double.infinity,
              width: double.infinity,
              // padding: EdgeInsets.only(top: mediaobj.height * 0.19),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mediaobj.height * 0.12,
                  ),
                  // Expanded(
                  //   child: Container(
                  //     margin: EdgeInsets.symmetric(
                  //         horizontal: mediaobj.width * 0.04, vertical: 0),
                  //     child: ListView.builder(
                  //       padding: const EdgeInsets.only(top: 0),
                  //       itemCount: newsList.length,
                  //       itemBuilder: (context, index) =>
                  //           NewsTile(mediaobj, index),
                  //     ),
                  //   ),
                  // )
                ],
              )),
          // if(!lpermission)    
          appbar(mediaobj, locality) //it is my app bar
        ],
      ),
    );
  }
}
