import 'dart:developer';

import 'package:final_project/pages/home_page.dart';
import 'package:final_project/pages/registration/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userName = '';

  /// SUPABASE DECLARATION ...
  final supabase = Supabase.instance.client;

  /// TEXTFIELD CONTROLLERS ...
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// SIGN UP FUNCTION ...

  Future<void> signUp() async {
    try {
      await supabase.auth.signUp(email: emailController.text, password: passwordController.text, data: {
        'data': {
          'name': nameController.text,
        },
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
      setState(() {
        userName = nameController.text;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  /// Dispose controllers ...
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Deleting TextFields ...
  void deleteTextFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              signUp();
              deleteTextFields();
              log('Sign Up Button Pressed');
            },
            child: const Text('Register'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              log('Sign In Button Pressed');
            },
            child: const Text('Log In'),
          ),
        ],
      ),
    );
  }
}
