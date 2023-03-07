import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTitle extends StatelessWidget {
  const UserTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ibmPlexSansArabic(
          color: Color(0xFF1C4E4E),
          fontSize: 14,
          fontWeight: FontWeight.normal),
    );
  }
}
