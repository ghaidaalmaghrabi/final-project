import 'dart:developer';

import 'package:final_project/components/animated_textfield.dart';
import 'package:final_project/pages/Bottom_Nav_Bar.dart';
import 'package:final_project/pages/registration/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Positioned(
          top: 50,
          right: 100,
          child: Image.asset('assets/images/codetech-logo.png',
              width: 230, height: 230),
        ),
        const Positioned(top: 280, right: 0, bottom: 0, child: LayerOne()),
        const Positioned(
          left: 20,
          top: 300,
          right: 20,
          bottom: 25,
          child: LayerTwo(),
        ),
        const Positioned(top: 320, right: 0, bottom: 48, child: LayerThree()),
      ]),
      backgroundColor: Colors.white,
    );
  }
}

// ignore: prefer-single-widget-per-file
class LayerOne extends StatelessWidget {
  const LayerOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFDAD5D1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: 654);
  }
}

// ignore: prefer-single-widget-per-file
class LayerThree extends StatefulWidget {
  const LayerThree({super.key});

  @override
  State<LayerThree> createState() => _LayerThreeState();
}

class _LayerThreeState extends State<LayerThree> {
  /// SUPABASE DECLARATION ...
  final supabase = Supabase.instance.client;

  /// TEXTFIELD CONTROLLERS ...
  final emailComtroller = TextEditingController();
  final passwordComtroller = TextEditingController();
  @override
  Future<void> singIn() async {
    try {
      await supabase.auth.signInWithPassword(
          email: emailComtroller.text, password: passwordComtroller.text);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  /// Dispose controllers ...
  @override
  void dispose() {
    emailComtroller.dispose();
    passwordComtroller.dispose();
    super.dispose();
  }

  /// Deleting TextFields ...
  void deleteTextFields() {
    emailComtroller.clear();
    passwordComtroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 584,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'البريد الالكتروني',
                style: GoogleFonts.notoSansArabic(
                  color: const Color(0xff0D1F38),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                  width: 330,
                  height: 50,
                  child: AnimatedTextField(
                      label: ' ادخل البريد الالكتروني',
                      suffix: null,
                      xController: emailComtroller)),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'كلمة المرور ',
                style: GoogleFonts.notoSansArabic(
                  color: const Color(0xff0D1F38),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 330,
                height: 50,
                child: AnimatedTextField(
                  label: ' ادخل كلمة المرور',
                  suffix: null,
                  xController: passwordComtroller,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              singIn();
              deleteTextFields();
              log('hey from git');
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0D1F38),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              width: 300,
              height: 35,
              child: Text(
                'دخول',
                style: GoogleFonts.notoSansArabic(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: Text(
                  'سجِّل الآن',
                  style: GoogleFonts.notoSansArabic(
                    decoration: TextDecoration.underline,
                    color: const Color.fromRGBO(41, 82, 78, 0.6),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'لا تمتلك حساب؟',
                style: GoogleFonts.notoSansArabic(
                  color: const Color(0xff0D1F38),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 220,
          ),
          Text(
            '.جميع الحقوق محفوظة لفريق كود تك © 1444هـ - 2023م',
            style: GoogleFonts.notoSansArabic(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file
class LayerTwo extends StatelessWidget {
  const LayerTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      width: 399,
      height: 584,
    );
  }
}
