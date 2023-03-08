import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_animate_border.dart';

class AnimatedTextField extends StatefulWidget {
  final String label;
  final Widget? suffix;
  final TextEditingController xController;
  const AnimatedTextField({
    Key? key,
    required this.label,
    required this.suffix,
    required this.xController,
  }) : super(key: key);

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation<double> alpha;
  final focusNode = FocusNode();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    final Animation<double> curve =
        CurvedAnimation(parent: controller!, curve: Curves.easeInOut);
    alpha = Tween(begin: 0.0, end: 1.0).animate(curve);

    // controller?.forward();
    controller?.addListener(() {
      setState(() {});
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller?.forward();
      } else {
        controller?.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffA2B5C1)),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: const Color(0xff0D1F38),
              ),
        ),
        child: CustomPaint(
          painter: CustomAnimateBorder(alpha.value),
          child: TextField(
              controller: widget.xController,
              focusNode: focusNode,
              decoration: InputDecoration(
                  label: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text(widget.label)]),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: InputBorder.none),
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.end,
              autocorrect: true),
        ),
      ),
    );
  }
}
