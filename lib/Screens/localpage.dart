import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Widgets/appbar.dart';

// class LocalNews extends StatefulWidget {
//   const LocalNews({super.key});

//   @override
//   State<LocalNews> createState() => _LocalNewsState();
// }

// class _LocalNewsState extends State<LocalNews> {
//   Position? position;
//   String? locality;
//   bool serviceEnabled=false;
//   @override
//   void initState() {
//     super.initState();
//     checkpermission();
//   }
//   checkpermission()async{
//     LocationPermission permission = await Geolocator.checkPermission();
//     if(permission==LocationPermission.denied){
//          showDialog(context: context, builder: (context)=>Dialog(
//              child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextButton(onPressed: ()async{
//                        permission = await Geolocator.requestPermission();
//                        decodepositon(await Geolocator.getCurrentPosition());
//                        serviceEnabled=true;
//                        Navigator.pop(context);
//                 }, child: const Text('Grant')),
//                 TextButton(onPressed:(){ Navigator.pushNamed(context, MainScreen.routeName);}, child:const Text('Later'))
//               ],
//              ),
//          ));
//     }
//     else{
//       serviceEnabled=true;
//       decodepositon(await Geolocator.getCurrentPosition());
//     }
//   }

//   decodepositon(Position position) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     Placemark p = placemarks[0];
//     locality = p.locality;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaobj = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           if (serviceEnabled) SizedBox(
//               height: double.infinity,
//               width: double.infinity,
//               // padding: EdgeInsets.only(top: mediaobj.height * 0.19),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: mediaobj.height * 0.12,
//                   ),
//                   // Expanded(
//                   //   child: Container(
//                   //     margin: EdgeInsets.symmetric(
//                   //         horizontal: mediaobj.width * 0.04, vertical: 0),
//                   //     child: ListView.builder(
//                   //       padding: const EdgeInsets.only(top: 0),
//                   //       itemCount: newsList.length,
//                   //       itemBuilder: (context, index) =>
//                   //           NewsTile(mediaobj, index),
//                   //     ),
//                   //   ),
//                   // )
//                 ],
//               )),
//           // if(!lpermission)    
//           appbar(mediaobj, locality) //it is my app bar
//         ],
//       ),
//     );
//   }
// }
class LocalNews extends StatelessWidget {
  const LocalNews({super.key});

  @override
  Widget build(BuildContext context) {
    final mediObj=MediaQuery.of(context).size;
    return Scaffold(
      body:Column(
        children: [
          appbar(mediObj,null),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: mediObj.height*0.5,
            width: double.infinity,
            child: SvgPicture.asset('assets/Icons/maintainence.svg',fit: BoxFit.contain,),),
        const Spacer()
        ],
      ),
    );
  }
}