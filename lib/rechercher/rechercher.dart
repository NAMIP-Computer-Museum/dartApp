import 'package:flutter/material.dart';

class Rechercher extends StatefulWidget {
  const Rechercher({Key? key}) : super(key: key);

  @override
  State<Rechercher> createState() => _RechercherState();
}

class _RechercherState extends State<Rechercher> {

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future<void> readData() async {

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
