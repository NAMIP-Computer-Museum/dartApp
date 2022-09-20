import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../components_details/datasheet.dart';
import '../models/component.dart';
import '../navigation_service.dart';

class CompareTimeline extends StatelessWidget {

  final List<Component> firstComponents;
  final List<Component> secondComponents;
  Map<int, List<Component>> data1 = {};
  Map<int, List<Component>> data2 = {};
  List<int> dates = [];

  CompareTimeline({Key? key, required this.firstComponents, required this.secondComponents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initData();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: dates.map((e) => timelineTile(
            data1[e] ?? [],
            data2[e] ?? [],
            dates.indexOf(e) == 0,
            dates.indexOf(e) == dates.length - 1,
            e,
          )).toList()
        ),
      ),
    );
  }

  void initData() {
    if (data1.isEmpty) {
      for (final component in firstComponents) {
        if (data1.containsKey(component.date)) {
          data1[component.date]!.add(component);
        } else {
          data1[component.date] = [component];
          dates.add(component.date);
        }
      }
    }
    if (data2.isEmpty) {
      for (final component in secondComponents) {
        if (data2.containsKey(component.date)) {
          data2[component.date]!.add(component);
        } else {
          data2[component.date] = [component];
          if (!dates.contains(component.date)) {
            dates.add(component.date);
          }
        }
      }
    }
  }

  Widget timelineTile(List<Component> components1, List<Component> components2, bool isFirst, bool isLast, int date) {
    Color getIndicatorColor() {
      if (date < 1973) {
        return Colors.blue;
      } else if (date < 1977) {
        return Colors.green;
      } else if (date < 1992) {
        return Colors.pink;
      } else {
        return Colors.orangeAccent;
      }
    }
    return TimelineTile(
        axis: TimelineAxis.vertical,
        alignment: TimelineAlign.center,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: getIndicatorColor(),
        ),
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 20,
          indicator: Container(
            decoration: BoxDecoration(
              color: getIndicatorColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                date.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        startChild: Column(
          children: components1.map((e) => componentTile(e)).toList(),
        ),
        endChild: Column(
          children: components2.map((e) => componentTile(e)).toList()
        ),
    );
  }

  Widget componentTile(Component component) {
    return GestureDetector(
      onTap: () {
        Navigator.of(NavigationService.getContext()).push(MaterialPageRoute(builder: (context) => Datasheet.fromComponent(component: component)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(component.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 2, color: Colors.grey),
          ],
        ),
      )
    );
  }
}

