import 'package:flutter/material.dart';
import 'package:nam_ip_museum/functions.dart';

import 'home_pages/home_page.dart';

class Widgets {

  static AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text("NAM-IP Micro${Functions.getStringLang(fr: "-ordinateur", en: "computer", nl: "computer")}"),
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