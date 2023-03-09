import 'dart:developer';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/models/explore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/user_info_title.dart';
import '../components/user_title.dart';

class ProjectDetails extends StatefulWidget {
  final String pName;
  const ProjectDetails({
    super.key,
    required this.pName,
  });

  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  bool uploadState = true;
  List<AddNewProject> projectList = [];

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
    final response = await supabase.from('newProject').select().eq('pName', widget.pName).execute();

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

  @override
  void initState() {
    getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25,
            color: Colors.blueGrey,
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
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                decoration: const BoxDecoration(
                  color: Color(0xffA7D3D6),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                ),
                width: double.infinity,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LottieBuilder.asset('assets/animation/green-waves.json'),
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
                                            onTap: () =>
                                                launchUrl(Uri.parse('https://www.linkedin.com/in/rhf-alharbi/')),
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
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 14, top: 14, right: 14),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 228, 235, 238),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                height: 1000,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  ),
                  child: Column(
                    children: [
                      for (var i in projectList) ...[
                        ProjectCard(
                          projectName: i.pName,
                          projectDescription: i.pDescription,
                          githubLink: i.gitHubLink,
                        ),
                      ],
                      uploadState ? const Text(' ') : const CircularProgressIndicator(),
                    ],
                  ),
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

//
// ignore: prefer-single-widget-per-file
class ProjectCard extends StatefulWidget {
  final String projectName;
  final String projectDescription;
  final String githubLink;

  const ProjectCard({
    super.key,
    required this.projectName,
    required this.projectDescription,
    required this.githubLink,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(widget.projectName),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
            ),
            child: Text(widget.projectDescription),
          ),
          const SizedBox(height: 16),
          const Text('ديمو'),
          const Placeholder(
            fallbackHeight: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(widget.githubLink),
              const Icon(Icons.close),
            ],
          ),
        ],
      ),
    );
  }
}
