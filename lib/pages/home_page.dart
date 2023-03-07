import 'dart:developer';

import 'package:final_project/models/Explore.dart';
import 'package:final_project/pages/developers_list_page.dart';
import 'package:final_project/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../components/project_title.dart';
import '../components/title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Explore> exploreSection = [];

  VideoPlayerController? _controller;

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

  /// THIS METHOD IS USED TO GET VIDEO FROM SUPABASE ...
  getVideo() {
    return supabase.storage.from('demo-vid').getPublicUrl('tst');
  }

  /// INIT STATE ...
  @override
  void initState() {
    getExploreSection();
    _controller = VideoPlayerController.network(getVideo());
    _controller!.initialize().then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
              child: const Icon(Icons.list, color: Colors.grey),
            ),
            automaticallyImplyLeading: false,
            title: Image.asset('assets/images/LogoName.png', height: 50),
            actions: [
              Image.asset('assets/images/LogoPic.png', width: 50, height: 50),
              const SizedBox(width: 10)
            ],
            backgroundColor: Colors.white,
            centerTitle: true),
        body: ListView(children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            color: Colors.white,
            child: Column(children: [
              const Align(
                  alignment: Alignment.topRight,
                  child: MyTitle('المشاريع الاكثر إعجابًا')),
              Container(
                color: Colors.white,
                height: 250.0,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  InkWell(
                    onTap: () {
                      print(getVideo());
                      log(_controller.toString());
                      _controller!.play();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xffECEFF1),
                        borderRadius: BorderRadius.circular(20),
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.grey.withOpacity(0.5),
                        //       offset: const Offset(0, 3),
                        //       blurRadius: 4)
                        // ],
                      ),
                      width: 160.0,
                      margin: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        const Align(
                            alignment: Alignment.topRight,
                            child: Text('اسم المشروع')),
                        SizedBox(
                          width: 100.0,
                          height: 172.0,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!)),
                          ),
                        ),
                        Row(children: const [
                          Icon(Icons.favorite_border_outlined, size: 16.0),
                          Text('  900'),
                        ])
                      ]),
                    ),
                  ),
                ]),
              ),
              const Align(
                  alignment: Alignment.topRight,
                  child: MyTitle('استكشف المشاريع')),
              const SizedBox(height: 20.0),
              SizedBox(
                  height: 380,
                  child: ListView(children: [
                    for (var i in exploreSection) ...[
                      InkWell(
                          onTap: () {
                            log(i.pName);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DevelopersListPage(
                                        projectName: i.pName)));
                          },
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 204, 218, 218),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        offset: const Offset(0, 3),
                                        blurRadius: 4)
                                  ]),
                              child: Column(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ProjectTitle(i.pName),
                                      const SizedBox(width: 20.0),
                                      WidgetCircularAnimator(
                                          innerColor: const Color(0xff70788A),
                                          outerColor: const Color(0xff455A64),
                                          innerAnimation: Curves.easeInOutBack,
                                          outerAnimation: Curves.easeInOutBack,
                                          size: 80,
                                          innerIconsSize: 3,
                                          outerIconsSize: 3,
                                          innerAnimationSeconds: 10,
                                          outerAnimationSeconds: 10,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  shape: BoxShape.circle),
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      const Color(0xff034C5C),
                                                  radius: 32,
                                                  child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                              i.pImage),
                                                      radius: 30))))
                                    ]),
                                const SizedBox(height: 20.0),
                                Text(i.pDescription,
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2)
                              ]))),
                      const SizedBox(height: 20.0)
                    ]
                  ]))
            ]),
          ),
        ]),
        backgroundColor: Colors.white);
  }
}
