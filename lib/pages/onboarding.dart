import 'package:final_project/pages/home_page.dart';
import 'package:final_project/pages/registration/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/onboarding_contents.dart';
import '../models/size_config.dart';

class onboarding extends StatefulWidget {
  const onboarding({Key? key}) : super(key: key);

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = const [
    Color(0xffFFFFFF),
    Color(0xffFFFFFF),
    Color(0xffFFFFFF),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      decoration: const BoxDecoration(
        color: Color(0xFF022D35),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      width: _currentPage == index ? 20 : 10,
      height: 10,
      margin: const EdgeInsets.only(right: 5),
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) => setState(() => _currentPage = value),
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(children: [
                    Image.asset(
                      contents[i].image,
                      height: SizeConfig.blockV! * 25,
                    ),
                    SizedBox(height: (height >= 840) ? 80 : 30),
                    Text(
                      contents[i].title,
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontWeight: FontWeight.normal,
                        fontSize: (width <= 550) ? 40 : 35,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      contents[i].desc,
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontSize: (width <= 550) ? 17 : 25,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]),
                );
              },
              itemCount: contents.length,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (int index) => _buildDots(index: index),
                  ),
                ),
                _currentPage + 1 == contents.length
                    ? Padding(
                        padding: const EdgeInsets.all(30),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff022D35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: (width <= 550)
                                  ? const EdgeInsets.symmetric(horizontal: 100, vertical: 20)
                                  : EdgeInsets.symmetric(horizontal: width * 0.2, vertical: 25),
                              textStyle: TextStyle(fontSize: (width <= 550) ? 13 : 17)),
                          child: Text(
                            'البدء',
                            style: GoogleFonts.ibmPlexSansArabic(fontSize: 14),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage()),
                                );
                              },
                              style: TextButton.styleFrom(
                                elevation: 0,
                                textStyle: TextStyle(fontSize: (width <= 550) ? 13 : 17, fontWeight: FontWeight.w600),
                              ),
                              child: Text(
                                'تخطي',
                                style: GoogleFonts.ibmPlexSansArabic(
                                  color: const Color(0xFF022D35),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff022D35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                elevation: 0,
                                padding: (width <= 550)
                                    ? const EdgeInsets.symmetric(horizontal: 30, vertical: 20)
                                    : const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                                textStyle: TextStyle(
                                  fontSize: (width <= 550) ? 13 : 17,
                                ),
                              ),
                              child: Text(
                                'التالي',
                                style: GoogleFonts.ibmPlexSansArabic(),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ]),
      ),
      backgroundColor: colors[_currentPage],
    );
  }
}
