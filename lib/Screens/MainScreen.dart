import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp2/Screens/gptPreviewScreen.dart';
import 'package:newsapp2/Screens/gptScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './homepage.dart';
import './localpage.dart';
import '../Widgets/myDrawer.dart';
  int curremtIndex = 0;
BuildContext? globalcontext;
class MainScreen extends StatefulWidget {
  static String routeName='/mainscreen';

  const MainScreen({super.key});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final tabs = [
    const HomePage(),
    const LocalNews(),
    const GptPreview(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeItem();
  }
  void changeItem()async{
   final prefs=await SharedPreferences.getInstance();
   if(prefs.getBool('preview')!=null && prefs.getBool('preview')!){
     tabs[2]=const GptScreen();
     setState(() {
       
     });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: Builder(
        builder: (context1) {
          globalcontext=context1;
          return tabs[curremtIndex];
        }
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curremtIndex,
        backgroundColor: const Color(0xff02011D),
        unselectedItemColor: Colors.white,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: curremtIndex==0?30:20,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity,size: curremtIndex==1?30:20,),
            label: 'Local',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/Icons/robotsleep.svg',height: curremtIndex==2?30:20,width: curremtIndex==0?30:20,color: curremtIndex==2?Colors.green:Colors.white,),
            label: 'ASK AI',
          ),
        ],
        onTap: (index) {
          setState(() {
            curremtIndex = index;
          });
        },
      ),
    );
  }
}