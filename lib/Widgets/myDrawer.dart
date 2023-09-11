import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp2/Provider/userdata.dart';
import 'package:newsapp2/Screens/gptPreviewScreen.dart';
import 'package:newsapp2/Screens/savedNews.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './signOut.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void clearData()async{
    final prfs=await SharedPreferences.getInstance();
    prfs.clear();
  }
  @override
  Widget build(BuildContext context) {
   
    final mediaobj=MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: mediaobj.height*0.06),
            height:mediaobj.height*0.22,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 CircleAvatar(radius: 40,backgroundImage: Image.network(UserDataFetcher.profileUrl).image,),
                const SizedBox(height: 5,),
                Text(UserDataFetcher.username,style: TextStyle(fontFamily: 'Outfit',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03),)
              ],
            ),
          ), 
          const Divider(color: Colors.black,),
          ListTile(
            leading: SvgPicture.asset('assets/Icons/language.svg',height:mediaobj.height*0.03,width: mediaobj.width*0.005, ),
            title:  Text('Change Language',style:TextStyle(fontFamily: 'Outfit',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/Icons/robotsleep.svg',height:mediaobj.height*0.05 ),
            title: Text('GPT Info',style:TextStyle(fontFamily: 'Outfit',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(context, MaterialPageRoute(builder:(context)=>const GptPreview()));
            },
          ),
          ListTile(
            leading:SvgPicture.asset('assets/Icons/saved.svg',height:mediaobj.height*0.03 ),
            title: Text('Saved News',style:TextStyle(fontFamily: 'Outfit',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const SavedNewsSceeen()));
              
            },
          ),
          // ListTile(
          //   leading:SvgPicture.asset('assets/Icons/history.svg',height:mediaobj.height*0.03 ),
          //   title: Text('History',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
          //   onTap: () {
          //     // Update the state of the app
          //     // ...
          //     // Then close the drawer
          //     Navigator.pop(context);
          //   },
          // ),
          SizedBox(height: mediaobj.height*0.338+mediaobj.height*0.09,),
          ListTile(
            leading:SvgPicture.asset('assets/Icons/exit.svg',height:mediaobj.height*0.03 ),
            title: Text('Sign Out',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03,color: const Color(0xff00E324)) ,),
            onTap: () {
              clearData();
             signOut();
              Navigator.pop(context);
            },
          ),
          Container(
            height: mediaobj.height*0.08,
            width: double.infinity,     
            decoration: const BoxDecoration(
               color: Color(0xff02011D),
              borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30))
            ),
            child: Center(
              child: Container(
                height:mediaobj.height*0.005,
                width: 40,
                color: const Color(0xff00E324),
              ),
            ),
          )
        ],
      ),
    );
  }
}


