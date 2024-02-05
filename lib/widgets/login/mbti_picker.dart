import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';

class MBTIPicker extends StatefulWidget {
  final String initMBTI;
  final Function(String mbti) onChanged;

  const MBTIPicker(
      {super.key, required this.onChanged, required this.initMBTI});

  @override
  State<MBTIPicker> createState() => _MBTIPickerState();
}

class _MBTIPickerState extends State<MBTIPicker> {
  final List<String> firstPickerItems = ['E', 'I'];
  final List<String> secondPickerItems = ['N', 'S'];
  final List<String> thirdPickerItems = ['F', 'T'];
  final List<String> forthPickerItems = ['J', 'P'];

  late String firstValue;
  late String secondValue;
  late String thirdValue;
  late String forthValue;

  @override
  void initState() {
    super.initState();
    initMBTIState();
  }

  void initMBTIState() {
    if(widget.initMBTI == '') {
      firstValue = 'E';
      secondValue = 'N';
      thirdValue = 'F';
      forthValue = 'J';
    } else {
      firstValue = widget.initMBTI[0];
      secondValue = widget.initMBTI[1];
      thirdValue = widget.initMBTI[2];
      forthValue = widget.initMBTI[3];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildInfinitePicker(firstPickerItems, (value) {
          firstValue = value;
          widget.onChanged("$firstValue$secondValue$thirdValue$forthValue");
        }, firstValue),
        buildInfinitePicker(secondPickerItems, (value) {
          secondValue = value;
          widget.onChanged("$firstValue$secondValue$thirdValue$forthValue");
        }, secondValue),
        buildInfinitePicker(thirdPickerItems, (value) {
          thirdValue = value;
          widget.onChanged("$firstValue$secondValue$thirdValue$forthValue");
        }, thirdValue),
        buildInfinitePicker(forthPickerItems, (value) {
          forthValue = value;
          widget.onChanged("$firstValue$secondValue$thirdValue$forthValue");
        }, forthValue),
      ],
    );
  }

  Widget buildInfinitePicker(
      List<String> items, Function(String value) onChanged, String value) {
    int initValue = items.indexOf(value);
    final controller = FixedExtentScrollController(
        initialItem: 500 * items.length + initValue);

    return Container(
      height: 80,
      width: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Palette.secondary, width: 2)),
      child: ListWheelScrollView(
        controller: controller,
        overAndUnderCenterOpacity: 0.3,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (int index) {
          onChanged(items[index % items.length]);
        },
        itemExtent: 70,
        children: [
          for (int i = 0; i < 1000; i++)
            ...items.map((e) => Center(
                    child: Text(
                  e,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 32),
                )))
        ],
      ),
    );
  }
}
