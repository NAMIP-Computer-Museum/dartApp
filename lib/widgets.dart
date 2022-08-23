import 'package:flutter/material.dart';

import 'home_pages/home_page.dart';

class Widgets {

  static AppBar appBar(BuildContext context) {
    return AppBar( // TODO voir appbar
      title: const Text('NAM-IP Museum'),
      backgroundColor: Colors.red.shade900,
      shape: const Border(
        bottom: BorderSide(
          color: Colors.white,
          width: 2
        )
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          const HomePage()), (Route<dynamic> route) => false),
        )
      ],
    );
  }
}