import 'package:flutter/material.dart';

//inspired by horizontal_picker package : https://pub.dev/packages/horizontal_picker

class HorizontalPicker extends StatefulWidget {
  final List<Widget>? items;
  final List<dynamic>? data;
  final double height;
  final FixedExtentScrollController controller;
  final Function(double)? onChanged;
  final Color? activeItemTextColor;
  final Color? passiveItemsTextColor;

  const HorizontalPicker({super.key,
    this.items,
    this.data,
    required this.height,
    this.onChanged,
    required this.controller,
    this.activeItemTextColor = Colors.white,
    this.passiveItemsTextColor = Colors.white,
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
            itemExtent: 60,
            onSelectedItemChanged: (item) {
              // widget.onChanged(valueMap[item]["value"]);
              setState(() {});
            },
            children: widget.items == null ? (widget.data)!.map((e) {
              try {
                return getWidget(e, isSelected: (widget.data)!.indexOf(e) == widget.controller.selectedItem);
              } catch (error) {
                return getWidget(e, isSelected: (widget.data)!.indexOf(e) == widget.controller.initialItem);
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
    return FittedBox(
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? (widget.activeItemTextColor ?? Colors.black) : (widget.passiveItemsTextColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
