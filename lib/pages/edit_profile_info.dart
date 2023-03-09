import 'dart:developer';

import 'package:final_project/components/animated_textfield.dart';
import 'package:final_project/components/ct_elevatedButton.dart';
import 'package:final_project/models/explore.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditPersonalInfo extends StatefulWidget {
  const EditPersonalInfo({
    super.key,
  });

  @override
  State<EditPersonalInfo> createState() => _EditPersonalInfoState();
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  final supabase = Supabase.instance.client;

  /// This method is used to get the user name from the user metadata in Supabase.
  String userName() {
    final userMetadata = supabase.auth.currentUser?.userMetadata;
    final name = userMetadata?['data']['name'];

    if (name != null) {
      log(name.toString());
      return name.toString();
    } else {
      log('Name not found in user metadata.');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final linkedinController = TextEditingController();
    final githubController = TextEditingController();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      height: 600,
      clipBehavior: Clip.hardEdge,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextField(label: 'ادخل رقم الهاتف', suffix: null, xController: phoneController),
              const SizedBox(height: 16),
              AnimatedTextField(label: 'Linkedin ادخل حسابك على ', suffix: null, xController: linkedinController),
              const SizedBox(height: 16),
              AnimatedTextField(label: 'github ادخل حسابك على', suffix: null, xController: githubController),
              const SizedBox(height: 16),
              MyButton(
                title: 'تعديل',
                onTap: () async {
                  final editProfile = UserInfo(
                    usrId: userName(),
                    phoneNumber: phoneController.text,
                    gitHubLink: githubController.text.trim(),
                    linkedin: linkedinController.text.trim(),
                  );
                  final response =
                      await supabase.from('userInfo').update(editProfile.toJson()).eq('usrId', editProfile.usrId);

                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}