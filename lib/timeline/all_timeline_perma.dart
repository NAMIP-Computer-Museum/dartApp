import 'dart:convert';

import 'package:enough_convert/enough_convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nam_ip_museum/models/event.dart';
import 'package:nam_ip_museum/widgets.dart';
import 'package:timeline_tile/timeline_tile.dart';

class AllTimelinePerma extends StatefulWidget {
  const AllTimelinePerma({Key? key}) : super(key: key);

  @override
  State<AllTimelinePerma> createState() => _AllTimelinePermaState();
}

class _AllTimelinePermaState extends State<AllTimelinePerma> {

  List<Event> events = [];
  bool isLoading = false;

  int? previousDate;
  Map<String, List<Event>> mapEvents = {};

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future<void> readData() async {
    const codec = Windows1252Codec();
    final ByteData byteData = await rootBundle.load("assets/data/all_data.json");
    final String response = codec.decode(byteData.buffer.asUint8List());
    final List<dynamic> data = await json.decode(response);
    for (final Map<String, dynamic> item in data) {
      events.add(Event.fromMap(item));
    }
    for (final Event event in events) {
      final String date = event.date;
      if (mapEvents.containsKey(date)) {
        mapEvents[date]!.add(event);
      } else {
        mapEvents[date] = [event];
      }
    }
    setState(() {
      isLoading = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: isLoading ? Widgets.containerWithBinaryBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Builder(builder: (context) {
              List<Widget> timelineTiles = [];
              String beginYear = events.first.date;
              String endYear = events.last.date;
              mapEvents.forEach((key, value) {
                timelineTiles.add(timelineTile(
                    value, key == beginYear, key == endYear, key));
              });
              return Column(
                children: timelineTiles,
              );
            })
          ),
        ),
      ) : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget timelineTile(List<Event> components, bool isFirst, bool isLast, String date) {
    int? previousDate = this.previousDate;
    this.previousDate = int.parse(date);
    return SizedBox(
      height: components.isEmpty ? 50 : 140,
      child: TimelineTile(
        axis: TimelineAxis.vertical,
        alignment: TimelineAlign.manual,
        lineXY: 0.3,
        isFirst: isFirst,
        isLast: isLast,
        // beforeLineStyle: LineStyle(
        //   color: getIndicatorColor(date),
        // ),
        indicatorStyle: const IndicatorStyle(
          indicatorXY: 0.0,
          //color: getIndicatorColor(date),
        ),
        startChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: double.infinity,
            child: Text(date.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold
              )
            )
          ),
        ),
        endChild: ListView(
          scrollDirection: Axis.horizontal,
          children: components
            .map(
              (component) => GestureDetector(
            // onTap: () {
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) =>
            //           Datasheet.fromComponent(component: component)));
            // },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                          String text = component.getTitle();
                          if (component.getTitle().length > 12) {
                            text = "${component.getTitle().substring(0, 10)}...";
                          }
                          return Text(text,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            )
                          );
                        }
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(
                        //width: MediaQuery.of(context).size.width * 0.8,
                        child: FlutterLogo(
                          size: 50,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(thickness: 2, color: Colors.grey),
                ],
              ),
            ),
            ),
          ).toList(),
        )),
    );
  }
}
