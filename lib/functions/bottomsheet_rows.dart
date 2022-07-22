// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RowincolumnBottomSheet extends StatelessWidget {
  String imagePath;
  String text;
  Function function;
  RowincolumnBottomSheet({
    Key? key,
    required this.function,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          function;
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                imagePath,
              ),
            ),
            const SizedBox(width: 20,),
            Text(
              text,
              style: GoogleFonts.aBeeZee(
                fontSize: 20,
                color: const Color.fromARGB(255, 11, 90, 155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
