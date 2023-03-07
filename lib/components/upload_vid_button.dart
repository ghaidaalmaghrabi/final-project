import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadVidButton extends StatelessWidget {
  const UploadVidButton({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: const Color(0xFF1C4E4E)),
            borderRadius: BorderRadius.circular(10)),
        height: 30,
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.ibmPlexSansArabic(
              color: const Color(0xFF1C4E4E),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
