import 'package:final_project/pages/onboarding.dart';
import 'package:flutter/material.dart';

import 'add_new_project_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoSelectorWidget(),
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}
