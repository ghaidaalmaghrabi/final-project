import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../components/card_planet.dart';
import 'Bottom_Nav_Bar.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final data = [
    CardPlanetData(
      title: 'كُود تِك',
      subtitle: 'منصة بـ هوية عربية مختصة بعرض المشاريع البرمجيّة',
      image: const AssetImage("assets/images/codetech-logo.png"),
      backgroundColor: Color.fromARGB(255, 217, 224, 231),
      titleColor: Colors.pink,
      subtitleColor: const Color(0xFF022D35),
      background: LottieBuilder.asset(
        "assets/animation/anim1.json",
      ),
    ),
    CardPlanetData(
      title: 'كُود تِك',
      subtitle:
          ' تُمكنك من مشاركة و عرض مشروعك كـ فيديو لاااااااا لازم نكتب شي صاحي ',
      image: const AssetImage("assets/images/codetech-logo.png"),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color(0xFF022D35),
      background: LottieBuilder.asset("assets/animation/anim3.json"),
    ),
    CardPlanetData(
      title: 'كُود تِك',
      subtitle:
          'قُم بالتسجيل و عرض مشاريعك، او تابع كـ زائر و تصفّح المشاريع البرمجيّة ',
      image: const AssetImage("assets/images/codetech-logo.png"),
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      titleColor: Colors.yellow,
      subtitleColor: const Color(0xFF022D35),
      background: LottieBuilder.asset("assets/animation/anim2.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
          itemBuilder: (int index) {
            return CardPlanet(data: data[index],);
            
          },
          colors: data.map((e) => e.backgroundColor).toList(),
          onFinish: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const BottomNavBar()));
          },
          itemCount: data.length),
    );
  }
}

















// import 'package:concentric_transition/concentric_transition.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'Bottom_Nav_Bar.dart';

// final pages = [
//   const PageData(
//     title: 'Local news\nstories',
//     bgColor: Colors.grey,
//     textColor: Colors.white,
//   ),
//   const PageData(
//     title: 'Choose your\ninterests',
//     textColor: Colors.white,
//     bgColor: Color(0xFFFDBFDD),
//   ),
//   const PageData(
//     title: 'Drag and\ndrop to move',
//     bgColor: Color(0xFFFFFFFF),
//   ),
// ];

// class OnboardingExample extends StatelessWidget {
//   const OnboardingExample({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ConcentricPageView(
//       itemBuilder: (index) {
//         final page = pages[index % pages.length];
//         return _Page(page: page);
//       },
//       colors: pages.map((p) => p.bgColor).toList(),
//       opacityFactor: 2.0,
//       radius: 40,
//       direction: Axis.vertical,
//       nextButtonBuilder: (context) =>
//           const Icon(Icons.navigate_before_rounded, size: 40),
//     );
//   }
// }

// class PageData {
//   final String? title;
//   final IconData? icon;
//   final Color bgColor;
//   final Color textColor;

//   const PageData({
//     this.title,
//     this.icon,
//     this.bgColor = Colors.white,
//     this.textColor = Colors.black,
//   });
// }

// class _Page extends StatelessWidget {
//   final PageData page;

//   const _Page({Key? key, required this.page}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 200,
//         ),
//         Image.asset(
//           'assets/images/codetech-logo.png',
//           height: 200,
//           width: 200,
//         ),
//         SizedBox(
//           height: 100,
//         ),
//         _Text(
//           page: page,
//           style: TextStyle(),
//         ),
//         SizedBox(
//           height: 250,
//         ),
//         Row(
//           children: [
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => BottomNavBar()),
//                 );
//               },
//               style: TextButton.styleFrom(
//                 elevation: 0,
//                 textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//               child: Text(
//                 'تخطي',
//                 style: GoogleFonts.ibmPlexSansArabic(
//                   color: const Color(0xFF022D35),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _Text extends StatelessWidget {
//   const _Text({
//     Key? key,
//     required this.page,
//     this.style,
//   }) : super(key: key);

//   final PageData page;
//   final TextStyle? style;

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       page.title ?? '',
//       style: TextStyle(
//         color: page.textColor,
//         fontWeight: FontWeight.w600,
//         //letterSpacing: 0.0,
//         fontSize: 32,
//         height: 1.2,
//       ).merge(style),
//       textAlign: TextAlign.center,
//     );
//   }
// }
