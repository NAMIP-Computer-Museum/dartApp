import 'package:flutter/material.dart';
import '../informations/introduction.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  _HomePageDrawerState createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {

  int page = 0;

  final List<Widget> widgets = [const Introduction(), const Scaffold(), const Scaffold(), const Scaffold(), const Scaffold(), const Scaffold()];

  @override
  Widget build(BuildContext context) {

    Widget buildItem(IconData icon, String text, int item) {
      return ListTile(
          title: Text(text),
          leading: Icon(icon),
          onTap: () {
            setState(() {
              Navigator.pop(context);
              page = item;
            });
          }
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("NAM-IP Museum"),
          backgroundColor: Colors.red.shade900,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Image.asset('assets/NAMIP.jpg', fit: BoxFit.fitWidth),
              ),
              buildItem(Icons.home, "Introduction",0),
              buildItem(Icons.search, "Rechercher",1),
              buildItem(Icons.timeline, "Ligne du temps",2),
              buildItem(Icons.video_call, "Videos",3),
              buildItem(Icons.quiz, "Quiz", 4),
              buildItem(Icons.add, "A propos", 5),
            ],
          ),
        ),
        body: widgets[page]
    );
  }
}