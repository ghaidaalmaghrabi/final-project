import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeveloperProjectsPage extends StatefulWidget {
  const DeveloperProjectsPage({super.key});

  @override
  State<DeveloperProjectsPage> createState() => _DeveloperProjectsPageState();
}

class _DeveloperProjectsPageState extends State<DeveloperProjectsPage> {
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

  /// This function used to pick a file ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff123A46),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () async {
                          setState(() {
                            uploadState = false;
                          });
                          var pickedFile = await FilePicker.platform.pickFiles(allowMultiple: false);
                          if (pickedFile != null) {
                            final file = File(pickedFile.files.first.path ?? ''); // corrected line
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
                        child: const Icon(Icons.list_alt)),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(userName(), style: const TextStyle(fontSize: 28)),
                            Row(
                              children: [Text(userEmail()), const Icon(Icons.alternate_email)],
                            ),
                            Row(
                              children: const [Text('053*******'), Icon(Icons.phone)],
                            ),
                            Row(
                              children: const [Text('linkedin.com'), Icon(Icons.close)],
                            ),
                            Row(
                              children: const [Text('github.com'), Icon(Icons.close)],
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.account_circle,
                          size: 70,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'المشاريع',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                Column(
                  children: [
                    for (final project in UserProject.userProjects) ProjectCard(userProject: project),
                  ],
                ),
                uploadState ? const Text('done') : const CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file
class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.userProject,
  });
  final UserProject userProject;
  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite),
              Text(widget.userProject.likes),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.visibility),
              Text(widget.userProject.views),
            ],
          ),
          Text(widget.userProject.name),
        ],
      ),
    );
  }
}

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
