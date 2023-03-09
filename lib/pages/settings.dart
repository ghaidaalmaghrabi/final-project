import 'package:final_project/components/ct_textfield_title.dart';
import 'package:final_project/pages/change_password_page.dart';
import 'package:final_project/pages/home_page.dart';
import 'package:final_project/pages/profile_page.dart';
import 'package:final_project/pages/registration/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'ct_developers.dart';
import 'onBoarding_animation.dart';
//
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  /// SUPABASE DECLARATION ...
  final supabase = Supabase.instance.client;
  Future<void> signOut() async {
    await supabase.auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OnboardingPage()));
  }

  bool languageSwitchValue = true;
  bool modeSwitchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          ),
          automaticallyImplyLeading: false,
          title: Image.asset('assets/images/LogoName.png', height: 50),
          actions: [
            Image.asset('assets/images/LogoPic.png', width: 50, height: 50),
            const SizedBox(width: 10)
          ],
          backgroundColor: Colors.white,
          centerTitle: true),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.arrow_back_ios, size: 18, color: Colors.grey),
                  CTTextFieldTittle('الملف الشخصي')
                ],
              ),
            ),
            const Divider(thickness: 1),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePasswordPage()));
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.arrow_back_ios, size: 18, color: Colors.grey),
                      CTTextFieldTittle('تغير كلمة المرور')
                    ])),
            const Divider(thickness: 1),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.arrow_back_ios, size: 18, color: Colors.grey),
                  CTTextFieldTittle('تغيير اللغة')
                ]),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoSwitch(
                    value: modeSwitchValue,
                    onChanged: (bool? value) {
                      setState(() {
                        modeSwitchValue = value ?? false;
                      });
                    },
                    activeColor: CupertinoColors.systemGreen),
                const CTTextFieldTittle('النمط الفاتح')
              ],
            ),
            const Divider(thickness: 1),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CTDevelopers()),
                );
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.arrow_back_ios, size: 18, color: Colors.grey),
                    CTTextFieldTittle('المطورين')
                  ]),
            ),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.arrow_back_ios, size: 18, color: Colors.grey),
                CTTextFieldTittle('سياسة الخصوصية')
              ],
            ),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.arrow_back_ios, size: 18, color: Colors.grey),
                CTTextFieldTittle('الشروط والاحكام')
              ],
            ),
            const Divider(thickness: 1),
            InkWell(
              onTap: signOut,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back_ios,
                      size: 18, color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Text(
                      'تسجيل الخروج',
                      style: GoogleFonts.notoSansArabic(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ]),
      backgroundColor: Colors.white,
    );
  }
}
