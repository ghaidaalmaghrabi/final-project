import 'package:concentric_transition/concentric_transition.dart';
import 'package:final_project/pages/registration/login_page.dart';
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
      subtitleColor: const Color(0xFF0D1F38),
      background: LottieBuilder.asset(
        "assets/animation/anim1.json",
      ),
    ),
    CardPlanetData(
      title: 'كُود تِك',
      subtitle:
          ' تُمكنك من مشاركة و عرض مشاريعك البرمجيّة كـ مقاطع فيديو يمكن للجميع رؤيتها دون الحاجة للرجوع للأكواد وتشغيلها ',
      image: const AssetImage("assets/images/codetech-logo.png"),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color(0xFF0D1F38),
      background: LottieBuilder.asset("assets/animation/anim3.json"),
    ),
    CardPlanetData(
      title: 'كُود تِك',
      subtitle: 'قُم بالتسجيل و عرض مشاريعك، او تصفّح المشاريع البرمجيّة ',
      image: const AssetImage("assets/images/codetech-logo.png"),
      backgroundColor: Color.fromARGB(255, 237, 232, 227),
      titleColor: Colors.yellow,
      subtitleColor: const Color(0xFF0D1F38),
      background: LottieBuilder.asset("assets/animation/animpage3.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
          itemBuilder: (int index) {
            return CardPlanet(
              data: data[index],
            );
          },
          colors: data.map((e) => e.backgroundColor).toList(),
          onFinish: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          itemCount: data.length),
    );
  }
}
