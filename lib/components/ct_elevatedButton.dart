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
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(74, 77, 139, 1),
              Color.fromRGBO(71, 74, 125, 0.6),
            ])),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.mukta(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
