import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ext.dart';

class Tema {
  inputDec(String hintText, IconData icon) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.quicksand(
        color: renk(metin_renk),
      ),
      prefixIcon: Icon(
        icon,
        color: renk("5BA7FB"),
      ),
    );
  }

  inputBoxDec({Color? boxColor}) {
    return BoxDecoration(
      color: boxColor ?? renk("333443"),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
