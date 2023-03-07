import 'package:final_project/pages/home_page.dart';
import 'package:final_project/pages/onboarding.dart';
import 'package:flutter/material.dart';

import 'onBoarding_animation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingPage(),
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}
