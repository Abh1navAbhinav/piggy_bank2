import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Colours {
  colorslight() {
    return const LinearGradient(
      colors: <Color>[
         Color.fromARGB(255, 253, 251, 251),
        Color.fromARGB(255, 235, 237, 238),
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
    colorsearch() {
    return const LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 209, 252, 249),
        Color.fromARGB(255, 243, 211, 220),
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
