import 'dart:async';
import 'dart:developer';

import 'package:final_project/models/explore.dart';
import 'package:final_project/pages/developers_list_page.dart';
import 'package:final_project/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  int index = 0;
  late final Timer timer;
  final ImageProvider = [
    Image.asset(
      'assets/images/ui1.webp',
      fit: BoxFit.cover,
      key: const Key('1'),
    ),
    Image.asset(
      'assets/images/ui2.webp',
      fit: BoxFit.cover,
      key: const Key('2'),
    ),
    // Image.asset(
    //   'assets/images/ui3.webp',
    //   fit: BoxFit.cover,
    //   key: Key('3'),
    // ),
    Image.asset(
      'assets/images/ui4.jpeg',
      fit: BoxFit.cover,
      key: Key('3'),
    ),
    Image.asset(
      'assets/images/ui5.jpeg',
      fit: BoxFit.cover,
      key: Key('4'),
    ),
    // Image.asset(
    //   'assets/images/ui6.jpeg',
    //   fit: BoxFit.cover,
    //   key: Key('6'),
    // ),
  ];
  bool isLiked = false;
  var numbOfLikes = 0;
  List<Explore> exploreSection = [];
  List<AddNewProject> mostLikeProjects = [];

  VideoPlayerController? _controller;
  VideoPlayerController? _controller2;
  VideoPlayerController? _controller3;

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

  ///This method to get usr URL ...
  String funcGetVideoURL() {
    final response =
        supabase.from('newProject').select().eq('gitHubLink', userName());
    return response.toString();
  }

  /// THIS METHOD IS USED TO GET VIDEO FROM SUPABASE ...
  getVideo() {
    return supabase.storage.from('demo-vid').getPublicUrl('videos/vid');
  }

  getVideo2() {
    return supabase.storage.from('demo-vid').getPublicUrl('videos/vid-2');
  }

  getVideo3() {
    return supabase.storage.from('demo-vid').getPublicUrl('videos/vid-3');
  }

  /// INIT STATE ...
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() => index++);
    });
    getExploreSection();
    _controller = VideoPlayerController.network(getVideo());
    _controller!.initialize().then((_) {
      setState(() {});
    });

    // /// Second Video ...
    _controller2 = VideoPlayerController.network(getVideo2());
    _controller2!.initialize().then((_) {
      setState(() {});
    });

    // /// Third Video ...
    _controller3 = VideoPlayerController.network(getVideo3());
    _controller3!.initialize().then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Image.asset('assets/images/setting.png', width: 50, height: 50),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/LogoName.png', height: 50),
        actions: [
          Image.asset('assets/images/LogoPic.png', width: 50, height: 50),
          const SizedBox(width: 10)
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            color: Colors.white,
            child: Column(children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 1500),
                child: ImageProvider[index % ImageProvider.length],
              ),
              InkWell(
                onTap: () {
                  print(funcGetVideoURL());
                  log('clicked');
                },
                child: const Align(
                    alignment: Alignment.topRight,
                    child: MyTitle('المشاريع الاكثر إعجابًا')),
              ),
              Container(
                color: Colors.white,
                height: 195.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  children: [
                    InkWell(
                      onTap: () {
                        print(funcGetVideoURL());
                        log(_controller.toString());
                        _controller!.play();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xffDAD5D1),
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        width: 130.0,
                        margin: const EdgeInsets.all(6),
                        child: Column(children: [
                          SizedBox(
                            width: 80.0,
                            height: 130.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                      numbOfLikes += isLiked ? 1 : -1;
                                    });
                                    supabase
                                        .from('newProject')
                                        .update({'postLike': numbOfLikes})
                                        .eq('userName', userName())
                                        .execute();
                                  },
                                  child: Row(children: [
                                    Icon(
                                        size: 18,
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isLiked ? Colors.red : null),
                                    // Text(numbOfLikes.toString())
                                  ]),
                                ),
                              ]),
                              const Text('i.pName'),
                            ],
                          ),
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print(getVideo2());
                        log(_controller2.toString());
                        _controller2!.play();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 209, 218, 214),
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        width: 130.0,
                        margin: const EdgeInsets.all(6),
                        child: Column(children: [
                          SizedBox(
                            width: 80.0,
                            height: 130.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: AspectRatio(
                                  aspectRatio: _controller2!.value.aspectRatio,
                                  child: VideoPlayer(_controller2!)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                      numbOfLikes += isLiked ? 1 : -1;
                                    });
                                    supabase
                                        .from('newProject')
                                        .update({'postLike': numbOfLikes})
                                        .eq('userName', userName())
                                        .execute();
                                  },
                                  child: Row(children: [
                                    Icon(
                                        size: 18,
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isLiked ? Colors.red : null),
                                    // Text(numbOfLikes.toString())
                                  ]),
                                ),
                              ]),
                              const Text('i.pName'),
                            ],
                          ),
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print(getVideo2());
                        log(_controller3.toString());
                        _controller3!.play();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 212, 219, 223),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        width: 130.0,
                        margin: const EdgeInsets.all(6),
                        child: Column(children: [
                          SizedBox(
                            width: 80.0,
                            height: 130.0,
                            child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                clipBehavior: Clip.hardEdge,
                                child: AspectRatio(
                                    aspectRatio:
                                        _controller3!.value.aspectRatio,
                                    child: VideoPlayer(_controller3!))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                      numbOfLikes += isLiked ? 1 : -1;
                                    });
                                    supabase
                                        .from('newProject')
                                        .update({'postLike': numbOfLikes})
                                        .eq('userName', userName())
                                        .execute();
                                  },
                                  child: Icon(
                                      size: 18,
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isLiked ? Colors.red : null),
                                ),
                                const Text('i.pName'),
                              ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              const Align(
                  alignment: Alignment.topRight,
                  child: MyTitle('استكشف المشاريع')),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: ListView(children: [
                  for (var i in exploreSection) ...[
                    InkWell(
                      onTap: () {
                        log(i.pName);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DevelopersListPage(projectName: i.pName)),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 214, 221, 225),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(0, 3),
                                blurRadius: 4),
                          ],
                        ),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ProjectTitle(i.pName),
                                const SizedBox(width: 20.0),
                                WidgetCircularAnimator(
                                  innerColor: Color.fromARGB(255, 192, 75, 75),
                                  outerColor: Color.fromARGB(255, 14, 141, 26),
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
                                      backgroundColor: const Color(0xff034C5C),
                                      radius: 32,
                                      child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(i.pImage),
                                          radius: 30),
                                    ),
                                  ),
                                ),
                              ]),
                          const SizedBox(height: 20.0),

                          Text(i.pDescription,
                              style: GoogleFonts.ibmPlexSansArabic(
                                  color: Color(0xFF0D1F38),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              maxLines: 2),

                          // Text(
                          //   i.pDescription,
                          //   textAlign: TextAlign.right,
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 2,
                          // ),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ]),
              ),
            ]),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
