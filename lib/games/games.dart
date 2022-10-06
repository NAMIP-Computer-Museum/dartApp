import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/games/snake/snake.dart';
import 'package:nam_ip_museum/games/tron/tron.dart';

import '../utils/widgets.dart';

class Games extends StatelessWidget {
  const Games({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: FittedBox(
              child: Container(
                width: 0.8 * width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: FittedBox(
                            child: Text("games".tr, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Snake())),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(child: Text("Snake", style: TextStyle(fontSize: 20, color: Colors.white))),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Tron())),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(child: Text("Tron", style: TextStyle(fontSize: 20, color: Colors.white))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
}
