import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/style.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/pages/edit_profile_page.dart';
import 'package:final_project/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Image.asset('assets/images/codetech-logo.png',
              width: 150, height: 150),
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfilePage(),
                    ),
                  );
                },
                child: const Icon(Icons.edit, size: 25),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                InkWell(
                    onTap: () async {
                      setState(() {
                        uploadState = false;
                      });
                      var pickedFile = await FilePicker.platform
                          .pickFiles(allowMultiple: false);
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
                    child: const Icon(Icons.upload_file_outlined)),
                Row(children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(userName(), style: const TextStyle(fontSize: 28)),
                    Row(children: [
                      Text(userEmail()),
                      const Icon(Icons.alternate_email),
                    ]),
                    Row(children: const [
                      Text('053*******'),
                      Icon(Icons.phone)
                    ]),
                    Row(children: [
                      const Text('linkedin.com'),
                      Image.asset('assets/images/linkedin.png',
                          width: 20, height: 20)
                    ]),
                    Row(children: [
                      const Text('github.com'),
                      Image.asset('assets/images/github-logo.png',
                          width: 20, height: 20)
                    ])
                  ]),
                ]),
              ]),
              const SizedBox(height: 32),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('المشاريع', style: TextStyle(fontSize: 28))
                  ]),
              uploadState
                  ? const Text('done')
                  : const CircularProgressIndicator()
            ]),
          ),
          Expanded(
              child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 32),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.grey[50]),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                                onTap: () {},
                                child: Text('Forgot Password ?',
                                    style:
                                        TextStyle(color: Colors.blue[900])))),
                        const SizedBox(height: 20),
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                                height: 46,
                                width: 160,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Login',
                                        style: TextStyle(fontSize: 18))))),
                        const SizedBox(height: 12),
                        const Align(
                            alignment: Alignment.center,
                            child: Text('OR',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54))),
                        const SizedBox(height: 18),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _loginSocialMediaBtn(
                                  FontAwesomeIcons.facebookF, facebookColor),
                              const SizedBox(width: 16),
                              _loginSocialMediaBtn(
                                  FontAwesomeIcons.google, googleColor),
                              const SizedBox(width: 16),
                              _loginSocialMediaBtn(
                                  FontAwesomeIcons.twitter, twitterColor)
                            ])
                      ]))))
        ]),
        backgroundColor: Color.fromARGB(255, 228, 229, 238));
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
          shadowColor: Colors.black,
          color: bgColor,
          child: InkWell(
            splashColor: Colors.white12,
            onTap: () {},
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _inputTextField(hintText, bool obscuretext) {
    return Container(
      height: 56,
      padding: const EdgeInsets.fromLTRB(16, 3, 16, 6),
      margin: const EdgeInsets.all(8),
      decoration: raisedDecoration,
      child: Center(
        child: TextField(
          obscureText: obscuretext,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.black38,
              )),
        ),
      ),
    );
  }

  _labelText(title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}









// import 'dart:developer';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:final_project/pages/edit_profile_page.dart';
// import 'package:final_project/pages/settings.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class DeveloperProjectsPage extends StatefulWidget {
//   const DeveloperProjectsPage({super.key});

//   @override
//   State<DeveloperProjectsPage> createState() => _DeveloperProjectsPageState();
// }

// class _DeveloperProjectsPageState extends State<DeveloperProjectsPage> {
//   bool uploadState = true;

//   /// SUPABASE DECLARATION ...
//   final supabase = Supabase.instance.client;

//   /// This method is used to get the user name from the user metadata in Supabase.
//   String userName() {
//     final userMetadata = supabase.auth.currentUser?.userMetadata;
//     final name = userMetadata?['data']['name'];

//     if (name != null) {
//       log(name.toString());
//       return name.toString();
//     } else {
//       log('Name not found in user metadata.');
//       return '';
//     }
//   }

//   String userEmail() {
//     final response = supabase.auth.currentUser?.email;
//     return response.toString();
//   }

//   /// This function used to pick a file ...

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const SettingsPage(),
//               ),
//             );
//           },
//           child: const Icon(Icons.list, color: Colors.grey),
//         ),
//         automaticallyImplyLeading: false,
//         title: Image.asset('assets/images/LogoName.png', height: 50),
//         actions: [
//           Image.asset('assets/images/LogoPic.png', width: 50, height: 50),
//           const SizedBox(width: 10),
//         ],
//         backgroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const EditProfilePage(),
//                       ),
//                     );
//                   },
//                   child: const Icon(Icons.edit, size: 25),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                         onTap: () async {
//                           setState(() {
//                             uploadState = false;
//                           });
//                           var pickedFile = await FilePicker.platform
//                               .pickFiles(allowMultiple: false);
//                           if (pickedFile != null) {
//                             final file = File(pickedFile.files.first.path ??
//                                 ''); // corrected line
//                             await supabase.storage
//                                 .from('pdf-file')
//                                 .upload(pickedFile.files.first.name, file)
//                                 .then((value) {
//                               print(value);
//                               setState(() {
//                                 uploadState = true;
//                               });
//                             }).onError((error, stackTrace) {
//                               log(error.toString());
//                               setState(() {
//                                 uploadState = true;
//                               });
//                             });
//                           }
//                         },
//                         child: const Icon(Icons.upload_file_outlined)),
//                     Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(userName(),
//                                 style: const TextStyle(fontSize: 28)),
//                             Row(
//                               children: [
//                                 Text(userEmail()),
//                                 const Icon(Icons.alternate_email)
//                               ],
//                             ),
//                             Row(
//                               children: const [
//                                 Text('053*******'),
//                                 Icon(Icons.phone)
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text('linkedin.com'),
//                                 Image.asset('assets/images/linkedin.png',
//                                     width: 20, height: 20),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text('github.com'),
//                                 Image.asset('assets/images/github-logo.png',
//                                     width: 20, height: 20),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(width: 8),
//                         const Icon(
//                           Icons.account_circle,
//                           size: 70,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 32),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       'المشاريع',
//                       style: TextStyle(fontSize: 28),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     for (final project in UserProject.userProjects)
//                       ProjectCard(userProject: project),
//                   ],
//                 ),
//                 uploadState
//                     ? const Text('done')
//                     : const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ignore: prefer-single-widget-per-file
// class ProjectCard extends StatefulWidget {
//   const ProjectCard({
//     super.key,
//     required this.userProject,
//   });
//   final UserProject userProject;
//   @override
//   State<ProjectCard> createState() => _ProjectCardState();
// }

// class _ProjectCardState extends State<ProjectCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.favorite),
//               Text(widget.userProject.likes),
//             ],
//           ),
//           Row(
//             children: [
//               const Icon(Icons.visibility),
//               Text(widget.userProject.views),
//             ],
//           ),
//           Text(widget.userProject.name),
//         ],
//       ),
//     );
//   }
// }

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
