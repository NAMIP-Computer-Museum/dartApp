import 'package:flutter/material.dart';

import 'home_pages/home_page.dart';

class Widgets {

  static AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('NAM-IP Museum'),
      backgroundColor: Colors.red.shade900,
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