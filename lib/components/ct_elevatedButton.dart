import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        decoration: const BoxDecoration(
          color: Color(0xFF0D1F38),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.ibmPlexSansArabic(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
