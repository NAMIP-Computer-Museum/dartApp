import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../components_details/datasheet.dart';
import '../models/component.dart';

class ProportionalTimeline extends StatefulWidget {
  final bool isChecked;
  final List<Component> componentsSelected;

  const ProportionalTimeline({Key? key, required this.isChecked, required this.componentsSelected}) : super(key: key);

  @override
  State<ProportionalTimeline> createState() => _ProportionalTimelineState();
}

class _ProportionalTimelineState extends State<ProportionalTimeline> {

  Map<int, List<Component>> mapComponents = {};
  late final int beginYear = widget.componentsSelected.first.date;
  late final int endYear = widget.componentsSelected.last.date;

  List<Widget> timelineTiles = [];

  @override
  void initState() {
    for (int i = beginYear; i <= endYear; i++) {
      mapComponents[i] = [];
    }
    widget.componentsSelected.forEach((component) {
      mapComponents[component.date]?.add(component);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        timelineTiles = [];
        mapComponents.forEach((key, value) {
          timelineTiles.add(timelineTile(value, key == beginYear, key == endYear, key));
        });
        return Column(
          children: timelineTiles,
        );
      }
    );
  }

  Widget timelineTile(List<Component> components, bool isFirst, bool isLast, int date) {
    Color getIndicatorColor(int date) {
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
    return SizedBox(
      height: 140,
      child: TimelineTile(
          axis: TimelineAxis.vertical,
          alignment: TimelineAlign.manual,
          lineXY: 0.2,
          isFirst: isFirst,
          isLast: isLast,
          beforeLineStyle: LineStyle(
            color: getIndicatorColor(date),
          ),
          indicatorStyle: IndicatorStyle(
            indicatorXY: 0.0,
            color: getIndicatorColor(date),
          ),
          startChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: double.infinity,
                child: Text(date.toString(), style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          endChild: ListView(
            scrollDirection: Axis.horizontal,
            children: components.map((component) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Datasheet.fromComponent(component: component)));
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
                        !widget.isChecked ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(component.logo),
                                radius: 30,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                  child: Text(component.descFr, style: const TextStyle(fontSize: 14, color: Colors.white), maxLines: 4, overflow: TextOverflow.ellipsis)
                              ),
                            ],
                          ),
                        ) : Container(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(thickness: 2, color: Colors.grey),
                  ],
                ),
              ),
            ),).toList(),

          )
      ),
    );
  }
}
