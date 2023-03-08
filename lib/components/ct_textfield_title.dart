import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CTTextFieldTittle extends StatelessWidget {
  const CTTextFieldTittle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: Text(
            text,
            style: GoogleFonts.notoSansArabic(
                color: Color.fromARGB(255, 67, 77, 77),
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
