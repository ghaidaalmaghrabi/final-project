import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'ادخل كلمة المرور القديمة',
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'ادخل كلمة المرور الجديدة',
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
