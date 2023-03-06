import 'package:final_project/pages/change_password_page.dart';
import 'package:final_project/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool languageSwitchValue = true;
  bool modeSwitchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff123A46),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.arrow_back_ios),
                              Text('الملف الشخصي'),
                            ],
                          ),
                        ),
                        const Divider(thickness: 2),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChangePasswordPage(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.arrow_back_ios),
                              Text('تغير كلمة المرور'),
                            ],
                          ),
                        ),
                        const Divider(thickness: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoSwitch(
                              value: languageSwitchValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  languageSwitchValue = value ?? false;
                                });
                              },
                              activeColor: CupertinoColors.systemGrey,
                            ),
                            const Text('اللغة'),
                          ],
                        ),
                        const Divider(thickness: 2),
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
                              activeColor: CupertinoColors.systemGrey,
                            ),
                            const Text('النمط الفاتح'),
                          ],
                        ),
                        const Divider(thickness: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(Icons.arrow_back_ios),
                            Text('مطورين التطبيق'),
                          ],
                        ),
                        const Divider(thickness: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(Icons.arrow_back_ios),
                            Text('سياسة الخصوصية'),
                          ],
                        ),
                        const Divider(thickness: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(Icons.arrow_back_ios),
                            Text('الشروط والاحكام'),
                          ],
                        ),
                        const Divider(thickness: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.logout),
                            SizedBox(width: 4),
                            Text(
                              'تسجيل الخروج',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
