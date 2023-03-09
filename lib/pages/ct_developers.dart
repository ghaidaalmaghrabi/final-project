import 'package:final_project/components/ct_textfield_title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../components/user_title.dart';

class CTDevelopers extends StatelessWidget {
  const CTDevelopers({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> titles = ['', '', ''];

    final List<Widget> images = [
      Card(
        color: const Color(0xFFA3B5C2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset('assets/images/gh 2.png'),
      ),
      Card(
        color: const Color(0xFFDAD5D1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset('assets/images/rh.png'),
      ),
      Card(
        color: const Color(0xFF8FA5B2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset('assets/images/ms.png'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.grey),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'المطورين الاساطير',
          style: GoogleFonts.ibmPlexSansArabic(color: Colors.black),
        ),
        actions: [
          Image.asset('assets/images/LogoPic.png', width: 50, height: 50),
          const SizedBox(width: 10),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        height: 1000,
        decoration: const BoxDecoration(
          color: Color(0xFF0D1F38),
        ),
        child: Column(
          children: [
            // Image.asset('assets/images/codetech-logo.png',
            //     width: 200, height: 200),
            Expanded(
              child: Container(
                // padding: const EdgeInsets.all(18.0),
                child: VerticalCardPager(
                    titles: titles, // required
                    images: images, // required
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold), // optional
                    onPageChanged: (page) {
                      // optional
                    },
                    onSelectedItem: (index) {
                      // optional
                    },
                    initialPage: 0, // optional
                    align: ALIGN.CENTER // optional
                    ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
