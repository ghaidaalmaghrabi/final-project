import 'package:final_project/pages/add_new_project_page.dart';
import 'package:flutter/material.dart';

class DeveloperProjectsPage extends StatelessWidget {
  const DeveloperProjectsPage({super.key});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.list_alt),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'مايا القرشي ',
                              style: TextStyle(fontSize: 28),
                            ),
                            Row(
                              children: const [Text('email.com'), Icon(Icons.alternate_email)],
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
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddNewProjectPage(),
                          ),
                        );
                      },
                      child: const Icon(Icons.add_circle_outline),
                    ),
                    const Text(
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
