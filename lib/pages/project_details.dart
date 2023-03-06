import 'package:flutter/material.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff123A46),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('اسم المشروع'),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                ),
                child: const Text('وصف المشروع'),
              ),
              const SizedBox(height: 16),
              const Text('ديمو'),
              const Placeholder(
                // fallbackWidth: 100,
                fallbackHeight: 300,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text('github link'),
                  Icon(Icons.close),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
