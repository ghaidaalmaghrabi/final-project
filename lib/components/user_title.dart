import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserNameTitle extends StatelessWidget {
  const UserNameTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ibmPlexSansArabic(
          color: Color.fromARGB(255, 57, 57, 57),
          fontSize: 20,
          fontWeight: FontWeight.normal),
    );
  }
}
