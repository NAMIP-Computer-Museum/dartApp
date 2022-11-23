import 'package:flutter/material.dart';

import '../functions.dart';
import '../home_pages/home_page.dart';
import 'navigation_service.dart';

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

  static Widget containerWithBinaryBackground({required child}) {
    return Center(
      child: Container(
        height: MediaQuery.of(NavigationService.getContext()).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}