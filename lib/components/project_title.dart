import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectTitle extends StatelessWidget {
  const ProjectTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
          color: Color(0xFF1C4E4E),
          fontSize: 24,
          fontWeight: FontWeight.normal),
    );
  }
}
