import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp2/Provider/userdata.dart';
import './signOut.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    print('User Details are');
    print(UserDataFetcher.username);
    print(UserDataFetcher.profileUrl);
    final mediaobj=MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: mediaobj.height*0.06),
            height:mediaobj.height*0.2,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 CircleAvatar(radius: 40,backgroundImage: Image.network(UserDataFetcher.profileUrl).image,),
                const SizedBox(height: 5,),
                Text(UserDataFetcher.username,style: TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03),)
              ],
            ),
          ), 
          const Divider(color: Colors.black,),
          ListTile(
            leading: SvgPicture.asset('assets/Icons/language.svg',height:mediaobj.height*0.03,width: mediaobj.width*0.005, ),
            title:  Text('Change Language',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/Icons/state.svg',height:mediaobj.height*0.03 ),
            title: Text('Change Region',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:SvgPicture.asset('assets/Icons/saved.svg',height:mediaobj.height*0.03 ),
            title: Text('Saved',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:SvgPicture.asset('assets/Icons/history.svg',height:mediaobj.height*0.03 ),
            title: Text('History',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03) ,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          SizedBox(height: mediaobj.height*0.338,),
          ListTile(
            leading:SvgPicture.asset('assets/Icons/exit.svg',height:mediaobj.height*0.03 ),
            title: Text('Sign Out',style:TextStyle(fontFamily: 'Anony',fontWeight: FontWeight.w700,fontSize:mediaobj.height*0.03,color: const Color(0xff00E324)) ,),
            onTap: () {
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


