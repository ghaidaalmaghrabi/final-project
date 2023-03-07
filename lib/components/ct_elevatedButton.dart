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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(74, 139, 86, 1),
              Color.fromRGBO(71, 125, 120, 0.6),
            ])),
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
