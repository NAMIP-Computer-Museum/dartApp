import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nam_ip_museum_web/feedback_form/form_complete.dart';
import 'package:nam_ip_museum_web/models/form_question.dart';
import 'package:nam_ip_museum_web/utils/navigation_service.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import '../utils/widgets.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {

  static String url = "https://docs.google.com/forms/d/e/1FAIpQLSdd5xZoPLZY-PaJKk89gX7TaYYw7YdLHkZqxnKrcMR2JDIGcA/viewform";

  List<FormQuestion> content = [];
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // final Map content = {
  //   "Globalement, êtes-vous satisfait du guide du visiteur ?" : [5, true, null, [["1"], ["2"], ["3"], ["4"], ["5"]], "Pas satisfait" , "Très satisfait" ],
  //   "Globalement, êtes-vous satisfait de la visite guidée ? (Ne répondez que si vous avez suivi une visite guidée)": [5, false, null, [["1"], ["2"], ["3"], ["4"], ["5"]], "Pas satisfait" , "Très satisfait" ],
  //   "Quelle est votre impression sur la qualité et la richesse des contenus proposés ?" : [5, true, null, [["1"], ["2"], ["3"]], "Passable", "Très bien" ],
  //   "Quelle est votre impression sur la présentation et la mise en valeur des collections?" : [5, true, null, [["1"], ["2"], ["3"]], "Passable", "Très bien" ],
  //   "Aidez nous à nous améliorer ... Que devrions-nous changer, prévoir pour l'avenir ...?": [1, true, TextEditingController()],
  //   "Souhaitez-vous être tenu au courant de nos activités ? Si oui, inscrivez votre adresse mail.": [0, false, TextEditingController()]
  // };

  Future<void> readData() async {
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
    //print(content);
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: content.map((e) => Column(
                        children: [
                          const SizedBox(height: 20),
                          FormField(
                            validator: (_) {
                              return assertValidAnswer(e) ? null : "Veuillez répondre à cette question";
                            },
                            builder: (FormFieldState state) => Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: state.hasError ? Colors.red : Colors.black),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: e.question, style: const TextStyle(fontSize: 18)),
                                        TextSpan(text: e.isForce ? " *" : "", style: const TextStyle(color: Colors.red, fontSize: 18)),
                                      ]
                                    )
                                  ),
                                  const SizedBox(height: 15),
                                  getAnswers(e),
                                  state.hasError ? Column(
                                    children: const [
                                      SizedBox(height: 15),
                                      Text("Cette question est obligatoire", style: TextStyle(color: Colors.red)),
                                    ],
                                  ) : const SizedBox(height: 0),
                                ],
                              ),
                            ),
                          )
                        ]
                      )).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      await sendForm();
                      Navigator.of(NavigationService.getContext()).push(MaterialPageRoute(builder: (context) => const FormComplete()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent.shade700,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: const Text("Envoyer", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ) : const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  void dispose() {
    for (FormQuestion item in content) {
      item.dispose();
    }
    super.dispose();
  }

  //https://docs.google.com/forms/d/e/1FAIpQLSfnz6I7WdYT00TFmumVTlxeSRA58_hAXPfn4ZXFZ6_gwtUJAw/viewform?usp=pp_url
  // &entry.33213020=Option+2
  // &entry.232582616=Test2+r%C3%A9ponse
  // &entry.1727957440=Test+3+r%C3%A9ponse
  // &entry.1353292799=4
  Future<void> sendForm() async {
    //print(Uri.encodeComponent("Test 3 réponse+"));
    if (_formKey.currentState!.validate()) {
      String submitURL = "https://docs.google.com/forms/d/e/1FAIpQLSdd5xZoPLZY-PaJKk89gX7TaYYw7YdLHkZqxnKrcMR2JDIGcA/formResponse?&submit=Submit?usp=pp_url";
      for (FormQuestion element in content) {
        String? answer = element.answer();
        if (answer != null) {
          submitURL += "&entry.${element.id}=${Uri.encodeComponent(answer)}";
        }
      }
      Uri uri = Uri.parse(submitURL);
      await http.get(uri);
    }
  }

  bool assertValidAnswer(FormQuestion question) {
    if (!question.isForce) return true;
    switch (question.type) {
      case 0:
      case 1:
        TextEditingController controller = question.value;
        return controller.text.isNotEmpty;
      case 2:
        if (question.value != null && question.value != "") return true;
        TextEditingController? controller = question.controllerForOtherInType2;
        return controller != null && controller.text.isNotEmpty;
      case 5:
        return question.value != null;
      default:
        print("Error");
        return false;
    }
  }

  Widget getAnswers(FormQuestion question) {
    switch (question.type) {
      case 0:
        return TextField(
          controller: question.value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Réponse',
          ),
        );
      case 1:
        return TextField(
          controller: question.value,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Réponse',
          ),
        );
      case 2:
        List list = question.params!;
        return Column(
          children: list.map((e) {
            if (e[4]) {
              question.controllerForOtherInType2 ??= TextEditingController();
            }
            return ListTile(
              title: e[4] ? Row(
                children: [
                  const Text("Autre :    "),
                  Expanded(
                    child: TextField(
                      controller: question.controllerForOtherInType2,
                    ),
                  )
                ],
              ) : Text(e[0]),
              leading: Radio<String>(
                value: e[0],
                groupValue: question.value,
                onChanged: (value) {
                  setState(() {
                    question.value = value;
                  });
                },
              ),
            );
          }).toList()
        );
      case 5:
        List list = question.params!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(list.length + 2, (index) {
              if (index == 0) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(question.min!),
                  ],
                );
              } else if (index == list.length + 1) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(question.max!),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Text(list[index - 1][0]),
                    const SizedBox(height: 10),
                    Radio<String>(
                      value: list[index - 1][0],
                      groupValue: question.value,
                      onChanged: (value) {
                        setState(() {
                          question.value = value;
                        });
                      },
                    ),
                  ],
                );
              }
            })
          ),
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
    int id = list[0][0];

    switch (type) {
      case 0: //Text
        content.add(FormQuestion(
          id: id,
          question: question,
          type: 0,
          isForce: isForce,
          value: TextEditingController(),
        ));
        break;
      case 1: //Paragraph
        content.add(FormQuestion(
          id: id,
          question: question,
          type: 1,
          isForce: isForce,
          value: TextEditingController(),
        ));
        break;
      case 2: //Multiple choice
        content.add(FormQuestion(
          id: id,
          question: question,
          type: 2,
          isForce: isForce,
          value: null,
          params: list[0][1],
        ));
        break;
      case 5: //Scale
        content.add(FormQuestion(
          id: id,
          question: question,
          type: 5,
          isForce: isForce,
          value: null,
          params: list[0][1],
          min: list[0][3][0],
          max: list[0][3][1],
        ));
        break;
      default:
        print("Type $type not supported");
        break;
    }
  }
}
