import 'package:final_project/pages/settings.dart';
import 'package:flutter/material.dart';

class CTAppBar extends StatelessWidget {
  const CTAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            );
          },
          child: const Icon(Icons.settings, color: Colors.grey)),
      automaticallyImplyLeading: false,
      title: Image.asset('assets/images/LogoName.png', height: 50),
      actions: [
        Image.asset('assets/images/LogoPic.png', width: 50, height: 50),
        const SizedBox(width: 10),
      ],
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }
}
