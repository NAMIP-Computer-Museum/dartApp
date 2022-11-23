import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:nam_ip_museum/utils/widgets.dart';
import 'package:googleapis/forms/v1.dart' as forms;

import 'oauth.dart';


class TestHTTP extends StatefulWidget {
  const TestHTTP({Key? key}) : super(key: key);

  @override
  State<TestHTTP> createState() => _TestHTTPState();
}

class _TestHTTPState extends State<TestHTTP> {

  Map<String, dynamic> content = {}; // String = questions, dynamic = answers
  bool isLoading = false;

  static String url = "https://docs.google.com/forms/d/e/1FAIpQLSdd5xZoPLZY-PaJKk89gX7TaYYw7YdLHkZqxnKrcMR2JDIGcA/viewform";

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future<void> readData() async {

    http.Client client = await obtainAuthenticatedClient();

    forms.FormsApi api = forms.FormsApi(client);
    var a = await api.forms.get("1FAIpQLSdd5xZoPLZY-PaJKk89gX7TaYYw7YdLHkZqxnKrcMR2JDIGcA");
    print(a);

    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    String body = response.body;
    var document = parse(body);
    var form = document.querySelector("form");
    List? items = form?.querySelectorAll("div[role='listitem']");
    items?.forEach((element) {
      var div = element.querySelector("div");
      parseFormItem(div.attributes["data-params"]);
    });
    //content.forEach((key, value) {print("$key : $value");});
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: isLoading ? Container(
        color: const Color.fromRGBO(246, 246, 246, 1),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                children: [
                  Image.asset("assets/NAMIP.jpg"),
                  Column(
                    children: content.entries.map((e) => Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(text: e.key, style: const TextStyle(fontSize: 18)),
                                          TextSpan(text: e.value[1] ? " *" : "", style: const TextStyle(color: Colors.red, fontSize: 18)),
                                        ]
                                    )
                                ),
                                const SizedBox(height: 15),
                                getAnswers(e.value)
                              ],
                            ),
                          )
                        ]
                    )).toList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ) : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget getAnswers(List params) {
    switch (params[0]) {
      case 0:
        return const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Réponse',
          ),
        );
      case 1:
        return const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Réponse',
          ),
        );
      case 2:
        List list = params[3];
        return Column(
            children: list.map((e) => ListTile(
              title: Text(e[0]),
              leading: Radio<String>(
                value: e[0],
                groupValue: params[2],
                onChanged: (value) {
                  setState(() {
                    params[2] = value;
                  });
                },
              ),
            )).toList()
        );
      case 5:
        List list = params[3];
        return Row(
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                Text(params[4]),
              ],
            ),
            Row(
                children: list.map((e) => Column(
                  children: [
                    Text(e[0]),
                    const SizedBox(height: 10),
                    Radio<String>(
                      value: e[0],
                      groupValue: params[2],
                      onChanged: (value) {
                        setState(() {
                          params[2] = value;
                        });
                      },
                    ),
                  ],
                )).toList()
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                Text(params[5]),
              ],
            )
          ],
        );
      default:
        return const Text("error");
    }
  }

  void parseFormItem(String item) {
    int a = item.indexOf('"');
    int b = item.indexOf('"', a + 1);
    String question = item.substring(a + 1, b);
    int type = int.parse(item[b + 7]);

    int c = item.indexOf(']]]]', b + 1);
    String answers = item.substring(b + 9, c + 4);
    List list = jsonDecode(answers);
    bool isForce = list[0][2];

    switch (type) {
      case 0: //Text
        content[question] = [0, isForce, TextEditingController()];
        break;
      case 1: //Paragraph
        content[question] = [1, isForce, TextEditingController()];
        break;
      case 2: //Multiple choice
        content[question] = [2, isForce, null, list[0][1]];
        break;
      case 5: //Scale
        content[question] = [5, isForce, null, list[0][1] /*scaling*/, list[0][3][0] /*min*/, list[0][3][1] /*max*/];
        break;
      default:
        print("Type $type not supported");
        break;
    }
  }
}
