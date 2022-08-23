import 'package:flutter/material.dart';

import '../home_pages/home_page.dart';

class ComponentImage extends StatelessWidget {
  final String img;

  const ComponentImage({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            const HomePage()), (Route<dynamic> route) => false),
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset(img),
        ),
      ),
    );
  }
}
