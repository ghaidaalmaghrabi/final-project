import 'package:final_project/models/explore.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DevelopersListPage extends StatefulWidget {
  const DevelopersListPage({super.key, required this.projectName});
  final String projectName;

  @override
  State<DevelopersListPage> createState() => _DevelopersListPageState();
}

class _DevelopersListPageState extends State<DevelopersListPage> {
  /// Supabase decleration ...
  final supabase = Supabase.instance.client;

  /// List of Projects ...
  List<AddNewProject> projectList = [];

  /// This method to get data from supabase ...

  Future<List<AddNewProject>> getProjects() async {
    final response = await supabase.from('newProject').select('*').eq('pId', widget.projectName).execute();

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

  /// Changing the like icon color and state ...
  bool isLiked = false;

  @override
  void initState() {
    getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مطورين فلاتر'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Placeholder(
              fallbackHeight: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            for (var i in projectList) ...[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 20.0,
                            color: isLiked ? Colors.red : Colors.white,
                          ),
                          Text(
                            i.likes.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Text(
                              i.pName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              i.userName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(Icons.circle, size: 40.0),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
