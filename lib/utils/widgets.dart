import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nam_ip_museum/utils/navigation_service.dart';

import '../home_pages/home_page.dart';

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

  static Widget containerWithBinaryBackground({required child}) {
    return Center(
      child: Container(
        height: MediaQuery.of(NavigationService.getContext()).size.height,
        width: kIsWeb ? MediaQuery.of(NavigationService.getContext()).size.height * 0.6 : MediaQuery.of(NavigationService.getContext()).size.width,
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