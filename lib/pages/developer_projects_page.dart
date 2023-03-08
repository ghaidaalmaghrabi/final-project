import 'package:avatar_glow/avatar_glow.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:final_project/pages/project_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/ct_textfield_title.dart';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/title.dart';
import '../components/user_title.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({
    super.key,
  });

  @override
  _DeveloperPageState createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  bool uploadState = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Image.asset('assets/images/codetech-logo.png', width: 150, height: 150),
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                },
                child: const Icon(Icons.edit, size: 25),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                InkWell(
                    onTap: () async {
                      setState(() {
                        uploadState = false;
                      });
                      var pickedFile = await FilePicker.platform.pickFiles(allowMultiple: false);
                      if (pickedFile != null) {
                        final file = File(pickedFile.files.first.path ?? '');
                        await supabase.storage.from('pdf-file').upload(pickedFile.files.first.name, file).then((value) {
                          print(value);
                          setState(() {
                            uploadState = true;
                          });
                        }).onError((error, stackTrace) {
                          log(error.toString());
                          setState(() {
                            uploadState = true;
                          });
                        });
                      }
                    },
                    child: const Icon(Icons.upload_file_outlined)),
                Row(children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(userName(), style: const TextStyle(fontSize: 28)),
                    Row(children: [Text(userEmail()), const Icon(Icons.alternate_email)]),
                    Row(children: const [Text('053*******'), Icon(Icons.phone)]),
                    Row(children: [
                      const Text('linkedin.com'),
                      Image.asset('assets/images/linkedin.png', width: 20, height: 20)
                    ]),
                    Row(children: [
                      const Text('github.com'),
                      Image.asset('assets/images/github-logo.png', width: 20, height: 20)
                    ]),
                  ]),
                ]),
              ]),
              const SizedBox(height: 32),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text('المشاريع', style: TextStyle(fontSize: 28))]),
              uploadState ? const Text('done') : const CircularProgressIndicator()
            ]),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
              width: double.infinity,
              margin: const EdgeInsets.only(top: 32),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    _labelText('Email:'),
                    _inputTextField('example@email.com', false),
                    const SizedBox(height: 16),
                    _labelText('Password:'),
                    _inputTextField('******', true),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {}, child: Text('Forgot Password ?', style: TextStyle(color: Colors.blue[900]))),
                    ),
                    const SizedBox(height: 20),
                    Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 46,
                            width: 160,
                            child: ElevatedButton(
                                onPressed: () {}, child: const Text('Login', style: TextStyle(fontSize: 18))))),
                    const SizedBox(height: 12),
                    const Align(
                        alignment: Alignment.center,
                        child: Text('OR',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54))),
                    const SizedBox(height: 18),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _loginSocialMediaBtn(FontAwesomeIcons.facebookF, facebookColor),
                          const SizedBox(width: 16),
                          _loginSocialMediaBtn(FontAwesomeIcons.google, googleColor),
                          const SizedBox(width: 16),
                          _loginSocialMediaBtn(FontAwesomeIcons.twitter, twitterColor),
                        ],),
                  ],
                ),
              ),
            ),
          ),
        ]),
        backgroundColor: const Color.fromARGB(255, 228, 229, 238));
    // ignore: dead_code
    appBar:
    AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfilePage(),
            ),
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
    );
    body:
    Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      width: double.infinity,
      margin: const EdgeInsets.only(top: 32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(children: <Widget>[
                Stack(
                  children: [
                    LottieBuilder.asset(
                      'assets/animation/square.json',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      });
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(
                                    'assets/images/resume.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                              MyTitle(userName()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      UserTitle(userEmail()),
                                      const SizedBox(width: 12),
                                      Image.asset(
                                        'assets/images/email.png',
                                        width: 20,
                                        height: 20,
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
                                      const UserTitle('053*******'),
                                      const SizedBox(width: 12),
                                      Image.asset(
                                        'assets/images/phone-call.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                color: Colors.blueGrey.shade300,
                                width: 1,
                                height: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const UserTitle('linkedin.com'),
                                      const SizedBox(width: 12),
                                      Image.asset('assets/images/linkedin.png', width: 20, height: 20),
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
                                      const UserTitle('github.com'),
                                      const SizedBox(width: 12),
                                      Image.asset('assets/images/github-logo.png', width: 20, height: 20),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Container(
                            color: Colors.blueGrey.shade300,
                            width: 300,
                            height: 1,
                          ),
                          const SizedBox(height: 12),
                          const SizedBox(height: 32),
                          uploadState ? const Text('done') : const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ),
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
        actions: [
          Image.asset('assets/images/LogoPic.png', width: 50, height: 50),
          const SizedBox(width: 10)
        ],
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
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                ),
                width: double.infinity,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
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
                                      var pickedFile = await FilePicker.platform
                                          .pickFiles(allowMultiple: false);
                                      if (pickedFile != null) {
                                        final file = File(
                                            pickedFile.files.first.path ?? '');
                                        await supabase.storage
                                            .from('pdf-file')
                                            .upload(pickedFile.files.first.name,
                                                file)
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
                                              title:
                                                  'تم تحميل السيرة الذاتية بنجاح',
                                              btnOkOnPress: () {
                                                debugPrint('OnClcik');
                                              },
                                              btnOkIcon: Icons.check_circle,
                                              onDismissCallback: (type) {
                                                debugPrint(
                                                    'Dialog Dissmiss from callback $type');
                                              },
                                            ).show();
                                          });
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/resume.png',
                                            width: 30,
                                            height: 30,
                                          ),
                                          Text(
                                            'رفع السيرة الذاتية',
                                            style:
                                                GoogleFonts.ibmPlexSansArabic(
                                                    fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                MyTitle(userName()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        UserTitle(userEmail()),
                                        const SizedBox(width: 12),
                                        Image.asset(
                                          'assets/images/email.png',
                                          width: 20,
                                          height: 20,
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
                                        const UserTitle('053*******'),
                                        const SizedBox(width: 12),
                                        Image.asset(
                                          'assets/images/phone-call.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Colors.blueGrey.shade300,
                                  width: 1,
                                  height: 50,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const UserTitle('linkedin.com'),
                                        const SizedBox(width: 12),
                                        Image.asset(
                                            'assets/images/linkedin.png',
                                            width: 20,
                                            height: 20),
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
                                        const UserTitle('github.com'),
                                        const SizedBox(width: 12),
                                        Image.asset(
                                            'assets/images/github-logo.png',
                                            width: 20,
                                            height: 20),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Container(
                              color: Colors.blueGrey.shade300,
                              width: 300,
                              height: 1,
                            ),
                            const SizedBox(height: 12),
                            const SizedBox(height: 32),
                            uploadState
                                ? const Text('done')
                                : const CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 228, 238, 233),
    )
  }

  _createAccountLink() {
    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.only(bottom: 16),
      height: 60,
      child: Center(
        child: Text(
          'Don\'t have account ? Sign Up Now',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: facebookColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  //button to login in using scial media,
  _loginSocialMediaBtn(IconData icon, Color bgColor) {
    return SizedBox.fromSize(
      size: const Size(54, 54), //button width and height
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
            elevation: 16,
            color: bgColor,
            shadowColor: Colors.black,
            child: InkWell(
                splashColor: Colors.white12,
                onTap: () {},
                child: Center(child: Icon(icon, color: Colors.white, size: 24)))),
          elevation: 16,
          shadowColor: Colors.black,
          color: bgColor,
      backgroundColor: Colors.white,
          child: InkWell(
            splashColor: Colors.white12,
            onTap: () {},
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

  _labelText(title) {
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
              Row(children: [
                const Icon(
                  Icons.favorite,
                  size: 20,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  widget.userProject.likes,
                  style: const TextStyle(color: Color.fromARGB(255, 79, 78, 78)),
                ),
              ]),
              // Row(children: [
              //   const Icon(Icons.visibility),
              //   Text(widget.userProject.views)
              // ]),
              CTTextFieldTittle(widget.userProject.name),
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
                child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/flutter-pic.webp'),
                    radius: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/////22222222

class UserProject {
  final String name;
  final String likes;
  final String views;
  UserProject({
    required this.likes,
    required this.views,
    required this.name,
  });
  static List<UserProject> userProjects = [
    UserProject(
      likes: '1234',
      name: 'متجر الكتروني',
      views: '5555',
    ),
    UserProject(
      likes: '5755',
      name: 'تطبيق توصيل',
      views: '585',
    ),
  ];
}
