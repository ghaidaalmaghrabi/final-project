import 'dart:developer';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/models/explore.dart';
import 'package:final_project/pages/project_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/ct_textfield_title.dart';
import '../components/user_info_title.dart';
import '../components/user_title.dart';
import 'edit_profile_info.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({
    super.key,
  });

  @override
  _DeveloperPageState createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  bool uploadState = true;
  List<AddNewProject> projectList = [];
  List<UserInfo> info = [];

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

  /// This method is used to get projects from supabase ...
  Future<List<AddNewProject>> getProjects() async {
    final response = await supabase.from('newProject').select().eq('userName', userName()).execute();

    List<AddNewProject> newList = [];

    for (var project in response.data) {
      final projects = AddNewProject.fromJson(project);
      newList.add(projects);
    }
    setState(() {
      projectList = newList;
    });
    return newList;
  }

  getVideo() {
    return supabase.storage.from('demo-vid').getPublicUrl('videos/vid');
  }

  /// THIS METHOD IS USED TO GET USER INFORMATION ...
  Future<List<UserInfo>> getUserInfo() async {
    final response = await supabase.from('userInfo').select().eq('usrId', userName()).execute();

    List<UserInfo> newList = [];

    for (var info in response.data) {
      final userInfo = UserInfo.fromJson(info);
      newList.add(userInfo);
    }
    setState(() {
      info = newList;
    });
    return newList;
  }

  @override
  void initState() {
    getUserInfo();

    getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return const EditPersonalInfo();
              },
              clipBehavior: Clip.hardEdge,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/images/user-avatar.png',
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/LogoName.png', height: 50),
        actions: [Image.asset('assets/images/LogoPic.png', width: 50, height: 50), const SizedBox(width: 10)],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                ),
                width: double.infinity,
                child: Stack(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 1000,
                      width: 500,
                      child: LottieBuilder.asset(
                        'assets/animation/holographic-gradient.json',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Column(children: <Widget>[
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      uploadState = false;
                                    });
                                    var pickedFile = await FilePicker.platform.pickFiles(allowMultiple: false);
                                    if (pickedFile != null) {
                                      final file = File(pickedFile.files.first.path ?? '');
                                      await supabase.storage
                                          .from('pdf-file')
                                          .upload(pickedFile.files.first.name, file)
                                          .then((value) {
                                        print(value);
                                        setState(() {
                                          uploadState = true;
                                        });
                                      }).onError((error, stackTrace) {
                                        log(error.toString());
                                        setState(() {
                                          uploadState = true;
                                          AwesomeDialog(
                                            context: context,
                                            animType: AnimType.leftSlide,
                                            headerAnimationLoop: false,
                                            dialogType: DialogType.success,
                                            showCloseIcon: true,
                                            title: 'تم تحميل السيرة الذاتية بنجاح',
                                            btnOkOnPress: () {
                                              debugPrint('OnClcik');
                                            },
                                            btnOkIcon: Icons.check_circle,
                                            onDismissCallback: (type) {
                                              debugPrint('Dialog Dissmiss from callback $type');
                                            },
                                          ).show();
                                        });
                                      });
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/resume.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(
                                        'رفع السيرة الذاتية',
                                        style: GoogleFonts.ibmPlexSansArabic(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                UserNameTitle(userName()),
                                const SizedBox(
                                  width: 12,
                                ),
                                const AvatarGlow(
                                  endRadius: 50,
                                  shape: BoxShape.circle,
                                  duration: Duration(milliseconds: 2000),
                                  repeat: true,
                                  animate: true,
                                  repeatPauseDuration: Duration(milliseconds: 200),
                                  curve: Curves.fastOutSlowIn,
                                  showTwoGlows: true,
                                  glowColor: Colors.red,
                                  startDelay: Duration(milliseconds: 1000),
                                  child: CircleAvatar(
                                      backgroundImage: AssetImage('assets/images/profilepic.webp'), radius: 40.0),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () => launchUrl(Uri.parse('https://www.linkedin.com/in/rhf-alharbi/')),
                                          child: Text(
                                            'linkedin.com/rhf-alharbi.com',
                                            style: GoogleFonts.ibmPlexSansArabic(
                                              fontSize: 12,
                                              decoration: TextDecoration.underline,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Image.asset('assets/images/linkedin.png', width: 16, height: 16),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () => launchUrl(Uri.parse('https://github.com/rhfhr')),
                                          child: Text(
                                            'github.com/rhfhr.com',
                                            style: GoogleFonts.ibmPlexSansArabic(
                                              fontSize: 12,
                                              decoration: TextDecoration.underline,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Image.asset('assets/images/github-logo.png', width: 16, height: 16),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        UserInfoTitle(userEmail()),
                                        const SizedBox(width: 12),
                                        Image.asset(
                                          'assets/images/email.png',
                                          width: 16,
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    // Container(
                                    //   color: Colors.blueGrey.shade300,
                                    //   width: 120,
                                    //   height: 1,
                                    // ),
                                    // const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const UserInfoTitle('0532132170'),
                                        const SizedBox(width: 12),
                                        Image.asset(
                                          'assets/images/phone-call.png',
                                          width: 16,
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(),
                                Column(),
                              ],
                            ),
                          ],
                        ),
                      ]),
                    ),
                    //
                    Positioned(
                      top: 160,
                      left: 15,
                      child: Container(
                        height: 1000,
                        width: 400,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              'المشاريع',
                              style: GoogleFonts.notoSansArabic(
                                  color: const Color.fromARGB(255, 67, 77, 77),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          //const CTTextFieldTittle('المشاريع'),
                          Column(children: [
                            for (var i in projectList) ...[
                              InkWell(
                                onTap: () {
                                  log(i.pName);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProjectDetails(
                                        pName: i.pName,
                                      ),
                                    ),
                                  );
                                },
                                child: ProjectCard(desc: i.pName),
                              ),
                            ],
                          ]),
                          uploadState ? const Text('') : const CircularProgressIndicator(),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

// ignore: prefer-single-widget-per-file
class ProjectCard extends StatefulWidget {
  final String desc;
  const ProjectCard({
    super.key,
    required this.desc,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffF2F2F2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.arrow_back_ios,
                size: 14,
                color: Colors.blueGrey,
              ),
              // Row(children: const [

              //   SizedBox(
              //     width: 4,
              //   ),
              //   Text(
              //     '',
              //     style: TextStyle(color: Color.fromARGB(255, 79, 78, 78)),
              //   ),
              // ]),
              CTTextFieldTittle(widget.desc),
              const AvatarGlow(
                endRadius: 40,
                shape: BoxShape.circle,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                animate: true,
                repeatPauseDuration: Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                showTwoGlows: true,
                glowColor: Colors.blue,
                startDelay: Duration(milliseconds: 1000),
                child: CircleAvatar(backgroundImage: AssetImage('assets/images/flutter-pic.webp'), radius: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class UserProject {
//   final String name;
//   final String likes;
//   final String views;
//   UserProject({
//     required this.likes,
//     required this.views,
//     required this.name,
//   });
//   static List<UserProject> userProjects = [
//     UserProject(
//       likes: '1234',
//       name: 'متجر الكتروني',
//       views: '5555',
//     ),
//     UserProject(
//       likes: '5755',
//       name: 'تطبيق توصيل',
//       views: '585',
//     ),
//   ];
// }