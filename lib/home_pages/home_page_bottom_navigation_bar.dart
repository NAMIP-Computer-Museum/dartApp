import 'package:flutter/material.dart';
import '../informations/introduction.dart';

class HomePageBottomNavBar extends StatefulWidget {
  const HomePageBottomNavBar({Key? key}) : super(key: key);

  @override
  State<HomePageBottomNavBar> createState() => _HomePageBottomNavBarState();
}

class _HomePageBottomNavBarState extends State<HomePageBottomNavBar> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Introduction(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NAM-IP Museum"),
        backgroundColor: Colors.red.shade900,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Introduction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Rechercher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Ligne du temps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'A propos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
