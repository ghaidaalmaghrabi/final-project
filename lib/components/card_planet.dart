import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPlanetData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  CardPlanetData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.background,
  });
}

class CardPlanet extends StatefulWidget {
  const CardPlanet({
    required this.data,
    Key? key,
  }) : super(key: key);

  final CardPlanetData data;

  @override
  State<CardPlanet> createState() => _CardPlanetState();
}

class _CardPlanetState extends State<CardPlanet> {
  @override
  Widget build(BuildContext context) {
    //
    return Stack(
      children: [
        if (widget.data.background != null)
          Positioned(
            left: 4,
            right: 4,
            top: 130,
            child: widget.data.background!,
          ),
        Padding(
          padding: const EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Flexible(
                flex: 20,
                child: Image(
                  image: widget.data.image,
                  height: 200,
                  width: 200,
                ),
              ),
              const Spacer(flex: 4),
              Text(
                '',
                style: GoogleFonts.ibmPlexSansArabic(
                  color: widget.data.titleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1,
                ),
                maxLines: 1,
              ),
              const Spacer(flex: 1),
              Text(
                widget.data.subtitle,
                style: GoogleFonts.ibmPlexSansArabic(
                  color: widget.data.subtitleColor,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const Spacer(flex: 10),
            ],
          ),
        ),
      ],
    );
  }
}
