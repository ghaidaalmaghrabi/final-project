import 'dart:developer';

import 'package:final_project/models/Explore.dart';
import 'package:final_project/pages/developers_list_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'add_new_project_page.dart';

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
      // appBar: AppBar(
      //   title: const Text('الصفحة الرئيسية'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(context, MaterialPageRoute(builder: (context) => VideoSelectorWidget()));
      //       },
      //       icon: const Icon(Icons.add),
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${userName()},مرحباً '),
                  Image.asset('assets/images/codetech-logo.png', height: 100.0),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Align(
                alignment: Alignment.topRight, child: Text('المشاريع الاكثر اعجابا', style: TextStyle(fontSize: 40.0))),
            Container(
              color: Colors.red,
              height: 200.0,
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
            SizedBox(
              height: 350.0,
              child: ListView(
                children: [
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
                            Text(
                              i.pDescription,
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.home_outlined,
                        size: 45.0,
                      ),
                      const Icon(
                        Icons.data_saver_on_sharp,
                        size: 45.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VideoSelectorWidget()),
                          );
                        },
                        child: const Icon(
                          Icons.data_saver_on_sharp,
                          size: 45.0,
                        ),
                      ),
                      const Icon(
                        Icons.person_outline_outlined,
                        size: 45.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
