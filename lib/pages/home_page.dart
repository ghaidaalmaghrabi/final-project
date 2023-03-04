import 'dart:developer';

import 'package:final_project/models/Explore.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Explore> exploreSection = [];

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

  /// This mehtod is used to get Explore section data from the Supabase.

  Future<List<Explore>> getExploreSection() async {
    final response = await supabase.from('explore').select().execute();

    List<Explore> newExploreSection = [];

    for (var explore in response.data) {
      final newExplore = Explore.fromJson(explore);
      newExploreSection.add(newExplore);
    }
    setState(() {
      exploreSection = newExploreSection;
    });
    return newExploreSection;
  }

  @override
  void initState() {
    getExploreSection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: ListView(
        children: [
          Text(
            userName(),
            style: const TextStyle(fontSize: 40.0),
          ),
          const SizedBox(height: 20.0),
          const Text('Most Like Project', style: TextStyle(fontSize: 40.0)),
          Container(
            color: Colors.red,
            height: 250.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i in exploreSection)
                  Container(
                    color: Colors.blue,
                    width: 200.0,
                    child: Column(
                      children: [
                        Text(i.pName),
                        Text(i.pDescription),
                        Text(i.pImage),
                      ],
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
