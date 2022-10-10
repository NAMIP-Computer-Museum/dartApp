import 'package:flutter/material.dart';

//inspired by horizontal_picker package : https://pub.dev/packages/horizontal_picker

class HorizontalPicker extends StatefulWidget {
  final List<Widget>? items;
  final List<dynamic>? data;
  final double height;
  final FixedExtentScrollController controller;
  final Function(int)? onChanged;
  final Color? activeItemTextColor;
  final Color? passiveItemsTextColor;
  final double? itemExtent; //width of each item

  const HorizontalPicker({super.key,
    this.items,
    this.data,
    required this.height,
    this.itemExtent,
    this.onChanged,
    required this.controller,
    this.activeItemTextColor,
    this.passiveItemsTextColor,
  }) : assert (items != null || data != null);

  @override
  State<HorizontalPicker> createState() => _HorizontalPickerState();
}

class _HorizontalPickerState extends State<HorizontalPicker> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.items == null ? const EdgeInsets.all(8) : const EdgeInsets.all(2.0),
      height: widget.height,
      alignment: Alignment.center,
      child: RotatedBox(
        quarterTurns: 3,
        child: ListWheelScrollView(
            controller: widget.controller,
            itemExtent: widget.itemExtent ?? 60,
            onSelectedItemChanged: (item) {
              if (widget.onChanged != null) widget.onChanged!(item);
              setState(() {});
            },
            children: widget.items == null ? (widget.data)!.map((e) {
              try {
                return getWidget(e.toString(), isSelected: (widget.data)!.indexOf(e) == widget.controller.selectedItem);
              } catch (error) {
                return getWidget(e.toString(), isSelected: (widget.data)!.indexOf(e) == widget.controller.initialItem);
              }
            }).toList()
          : widget.items!.map((e) => RotatedBox(
              quarterTurns: 1,
              child: e,
            )).toList()
        )
      ),
    );
  }

  Widget getWidget(String text, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        print("tapped");
      },
      child: FittedBox(
        child: RotatedBox(
          quarterTurns: 1,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? (widget.activeItemTextColor ?? Colors.white) : (widget.passiveItemsTextColor ?? Colors.white.withOpacity(0.7)),
            ),
          ),
        ),
      ),
    );
  }
}
