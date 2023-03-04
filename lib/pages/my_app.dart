
import 'package:final_project/pages/onboarding.dart';
import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  const onboarding(),
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}
