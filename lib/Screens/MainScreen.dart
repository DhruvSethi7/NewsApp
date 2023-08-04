import 'package:flutter/material.dart';
import './homepage.dart';
BuildContext? globalcontext;
class MainScreen extends StatefulWidget {
  static String routeName='/mainscreen';

  const MainScreen({super.key});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final tabs = [
    const HomePage(),
    const LocalNews(),
    const WorldNews(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: Builder(
        builder: (context1) {
          globalcontext=context1;
          return tabs[_currentIndex];
        }
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xff02011D),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Local',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'World',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}