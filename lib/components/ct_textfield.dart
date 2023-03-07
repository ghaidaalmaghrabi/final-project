import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CTTextField extends StatelessWidget {
  const CTTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter a search term',
      ),
    );
  }
}
