import 'package:flutter/material.dart';
import 'package:nam_ip_museum/components_details/datasheet.dart';

import '../db_helper.dart';
import '../models/component.dart';
import '../widgets.dart';

class Rechercher extends StatefulWidget {
  const Rechercher({Key? key}) : super(key: key);

  @override
  State<Rechercher> createState() => _RechercherState();
}

class _RechercherState extends State<Rechercher> {

  List<Component> dataComponents = [];

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future<void> readData() async {
    DBHelper dbHelper = DBHelper();
    List<Component> dataComponents1 = await dbHelper.getComponentsMicro();
    List<Component> dataComponents2 = await dbHelper.getComponentsPerma();
    setState(() {
      dataComponents = dataComponents1 + dataComponents2;
    });
  }

  static String _displayStringForOption(Component option) => option.name;

  void _onSelected(Component component) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        Datasheet.fromComponent(component: component)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Builder(
            builder: (context) {
              if(dataComponents.isEmpty) {
                return const CircularProgressIndicator(color: Colors.white,);
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Autocomplete<Component>(
                    displayStringForOption: _displayStringForOption,
                    onSelected: _onSelected,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<Component>.empty();
                      }
                      return dataComponents.where((Component option) {
                        return option.toString().toLowerCase().contains(
                            textEditingValue.text.toLowerCase());
                      });
                    }
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
