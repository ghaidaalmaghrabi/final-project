import 'package:final_project/pages/home_page.dart';
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
        color: Color(0xFF7C81EC),
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
                      height: SizeConfig.blockV! * 35,
                    ),
                    SizedBox(height: (height >= 840) ? 40 : 30),
                    Text(
                      contents[i].title,
                      style: GoogleFonts.dancingScript(
                        fontWeight: FontWeight.w600,
                        fontSize: (width <= 550) ? 40 : 35,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      contents[i].desc,
                      style: TextStyle(
                        fontSize: (width <= 550) ? 17 : 25,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Mulish',
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
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff7C81EC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: (width <= 550)
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 20)
                                    : EdgeInsets.symmetric(
                                        horizontal: width * 0.2, vertical: 25),
                                textStyle: TextStyle(
                                    fontSize: (width <= 550) ? 13 : 17)),
                            child: const Text("START")),
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
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              },
                              style: TextButton.styleFrom(
                                elevation: 0,
                                textStyle: TextStyle(
                                    fontSize: (width <= 550) ? 13 : 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              child: const Text(
                                'SKIP',
                                style: TextStyle(color: Color(0xFF7C81EC)),
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
                                    backgroundColor: Color(0xff7C81EC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    elevation: 0,
                                    padding: (width <= 550)
                                        ? const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 25),
                                    textStyle: TextStyle(
                                        fontSize: (width <= 550) ? 13 : 17)),
                                child: const Text("NEXT")),
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
