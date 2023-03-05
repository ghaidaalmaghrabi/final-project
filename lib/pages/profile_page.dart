import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /// Supabase Deceleration ...
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
        backgroundColor: const Color(0xff123A46),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(userName(), style: const TextStyle(fontSize: 28), textAlign: TextAlign.right),
                    const SizedBox(width: 16),
                    const Placeholder(
                      fallbackWidth: 50,
                      fallbackHeight: 80,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [const Icon(Icons.alternate_email), Text(userEmail())],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
