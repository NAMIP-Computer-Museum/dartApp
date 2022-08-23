import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets.dart';

class TestHTTP extends StatefulWidget {
  const TestHTTP({Key? key}) : super(key: key);

  @override
  State<TestHTTP> createState() => _TestHTTPState();
}

class _TestHTTPState extends State<TestHTTP> {

  List<dynamic> data = [];

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future<void> readData() async {
    Uri url = Uri.https('sig.cetic.be', '/trajectware-0.1/v0/artefact/find');
    http.Response response = await http.get(url);
    setState(() {
      data = json.decode(utf8.decode(response.bodyBytes));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              children: data.map((e) =>
                Wrap(
                  children: [
                    Text('${e['name']} : ${e['description']}', style: const TextStyle(color: Colors.white, fontSize: 20)),
                    const SizedBox(height: 50, width: 2),
                  ],
                ),
              ).toList(),
            ),
          ),
        ),
      )
    );
  }
}
