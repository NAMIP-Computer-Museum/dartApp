import 'package:flutter/material.dart';
import 'package:nam_ip_museum/components_details/datasheet.dart';

import '../data/db_helper.dart';
import '../models/component.dart';
import '../utils/widgets.dart';

class Rechercher extends StatefulWidget {
  const Rechercher({Key? key}) : super(key: key);

  @override
  State<Rechercher> createState() => _RechercherState();
}

class _RechercherState extends State<Rechercher> {

  List<Component> dataComponents = [];
  Component? _selectedComponent;

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
    _selectedComponent = component;
  }

  void _onChange(String? value) {
    if (_selectedComponent?.name != value) {
      _selectedComponent = null;
    }
  }

  void _onSubmit(TextEditingController controller) {
    if (_selectedComponent != null) {
      Component component = _selectedComponent!;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          Datasheet.fromComponent(component: component)));
    } else {
      if (controller.text == '') {
        return;
      } else {
        try {
          _selectedComponent = dataComponents.firstWhere((Component option) {
            return option.name.toLowerCase() == controller.text.toLowerCase();
          });
        } catch (e) {
          _selectedComponent = null;
        }
        if (_selectedComponent != null) {
          Component component = _selectedComponent!;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              Datasheet.fromComponent(component: component)));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) => TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onChanged: _onChange,
                      decoration: InputDecoration(
                        hintText: 'Rechercher',
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white,),
                          onPressed: () {
                            _onSubmit(textEditingController);
                          },
                        ),
                      ),
                    ),
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
