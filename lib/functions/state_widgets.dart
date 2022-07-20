// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cup_cake/functions/widgets.dart';
import 'package:flutter/material.dart';

class DropDownButtons extends StatefulWidget {
  String text;
  List<String> items = [];
  DropDownButtons({
    Key? key,
    required this.text,
    required this.items,
  }) : super(key: key);

  @override
  State<DropDownButtons> createState() => _DropDownButtonsState();
}

class _DropDownButtonsState extends State<DropDownButtons> {
  final obj = Widgets();
  var currentselecteditem1;
  var currentselecteditem2;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Padding(
        padding: const EdgeInsets.only(
          left: 4,
        ),
        child: Text(
          widget.text,
          style: colorsobj.styles(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      value: currentselecteditem2,
      underline: const Divider(
        color: Colors.transparent,
      ),
      style: colorsobj.styles(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      items: widget.items.map(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      onChanged: (value) {
        setState(
          () {
            currentselecteditem2 = value;
          },
        );
      },
    );
  }
}

