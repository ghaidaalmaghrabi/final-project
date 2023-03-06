import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final phNumberController = TextEditingController();

  /// SUPABASE DECLARATION ...
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

  String userEmail() {
    final response = supabase.auth.currentUser?.email;
    return response.toString();
  }

  @override
  void dispose() {
    phNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff123A46),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                const Icon(Icons.account_circle, size: 150),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(hintText: userName(), border: InputBorder.none),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(hintText: userEmail(), border: InputBorder.none),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(phNumberController.text),
                      const SizedBox(width: 4),
                      const Icon(Icons.phone, size: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(hintText: 'github link here', border: InputBorder.none),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(hintText: 'github link here', border: InputBorder.none),
                    textAlign: TextAlign.end,
                  ),
                ),
                TextField(
                  controller: phNumberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('تعديل'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
