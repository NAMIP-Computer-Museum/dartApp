import 'package:flutter/material.dart';

import '../models/type_component.dart';

class DatasheetLegend extends StatelessWidget {
  final TypeComponent type;
  final Map<String, Object?> data;

  const DatasheetLegend({Key? key, required this.type, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String path = "assets/legend_components_images";
    const TextStyle style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

    Widget buildLine(String assetImage, Object? textData) {
      return textData == null ? const SizedBox(width: 0) : Wrap(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(assetImage, width: 20, height: 20, color: Colors.white,),
          const SizedBox(width: 5),
          Text(textData.toString(), style: style,)
        ],
      );
    }

    switch (type) {
      case TypeComponent.micro:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildLine("$path/annual.png", data["année"]),
                buildLine("$path/micro/country.png", data['Pays']),
                buildLine("$path/fabricant.png", data['Fabricant']),
                buildLine("$path/micro/os.png", data['OS']),
                buildLine("$path/micro/cpu.png", data['CPU']),
                buildLine("$path/micro/ram.png", data['RAM']),
                buildLine("$path/micro/rom.png", data['ROM']),
              ],
            ),
          ),
        );
      case TypeComponent.os:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildLine("$path/annual.png", data["année"]),
                buildLine("$path/os/developer.png", data['Fabricant']),
                buildLine("$path/os/licensing.png", data['Licence']),
                buildLine("$path/os/coding.png", data['Langage']),
                buildLine("$path/os/cpu.png", data['Plateforme']),
              ],
            ),
          ),
        );
      case TypeComponent.cpu:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildLine("$path/annual.png", data["année"]),
                buildLine("$path/fabricant.png", data['Marque']),
                buildLine("$path/cpu/transistor.png", data['Transistors']),
                buildLine("$path/cpu/bits.png", data['Bits']),
                buildLine("$path/cpu/frequency.png", data['Fréquence']),
              ],
            ),
          ),
        );
      case TypeComponent.ihm:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildLine("$path/annual.png", data["année"]),
                buildLine("$path/ihm/engineer.png", data['Inventeur']),
              ],
            ),
          ),
        );
      case TypeComponent.app:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildLine("$path/annual.png", data["année"]),
                buildLine("$path/app/typeApp.png", data['TypeApp']),
                buildLine("$path/app/developer.png", data['Developpeur']),
                buildLine("$path/app/coding.png", data['Langage']),
                buildLine("$path/app/old-computer.png", data['Environnement']),
              ],
            ),
          ),
        );
      default:
        return const SizedBox(width: 0);
    }
  }
}
