import 'dart:developer';

import 'package:final_project/models/Explore.dart';
import 'package:final_project/pages/developers_list_page.dart';
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
        title: const Text('الصفحة الرئيسية'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20.0),
          const Align(
              alignment: Alignment.topRight, child: Text('المشاريع الاكثر اعجابا', style: TextStyle(fontSize: 40.0))),
          Container(
            color: Colors.red,
            height: 250.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                ///
                /// In this section we will add the most liked projects ...
                ///
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Text(
              'استكشف المشاريع',
              style: TextStyle(fontSize: 40.0),
            ),
          ),
          for (var i in exploreSection) ...[
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DevelopersListPage()));
              },
              child: Container(
                padding: const EdgeInsets.all(20.0),
                color: Colors.blue,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(i.pName),
                        const SizedBox(width: 20.0),
                        CircleAvatar(
                          backgroundImage: NetworkImage(i.pImage),
                          radius: 30.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(i.pDescription, textAlign: TextAlign.right),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ],
      ),
    );
  }
}
