import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTitle extends StatelessWidget {
  const MyTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ibmPlexSansArabic(
          color: Color(0xFF0D1F38),
          fontSize: 20,
          fontWeight: FontWeight.normal),
    );
  }
}
