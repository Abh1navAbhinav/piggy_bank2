import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Colours {
  colorslight() {
    return const LinearGradient(
      colors: <Color>[
        Color.fromARGB(247, 252, 242, 250),
        Color.fromARGB(255, 224, 250, 251),
      ],
    );
  }

  colorsdark() {
    return const LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 187, 251, 247),
        Color.fromARGB(255, 255, 203, 219),
      ],
    );
  }

  styles({
    Color color = Colors.black,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
