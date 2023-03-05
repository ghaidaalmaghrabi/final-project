import 'dart:developer';

import 'package:final_project/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// SUPABASE DECLARATION ...
  final supabase = Supabase.instance.client;

  /// TEXTFIELD CONTROLLERS ...
  final emailComtroller = TextEditingController();
  final passwordComtroller = TextEditingController();

  /// SIGN IN FUNCTION ...
  Future<void> singIn() async {
    try {
      await supabase.auth.signInWithPassword(email: emailComtroller.text, password: passwordComtroller.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailComtroller,
            decoration: const InputDecoration(
              hintText: 'Email',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: passwordComtroller,
            decoration: const InputDecoration(
              hintText: 'Password',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              singIn();
              deleteTextFields();
              log('hey from git');
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
