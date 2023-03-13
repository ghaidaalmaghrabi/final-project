import 'package:final_project/models/explore.dart';
import 'package:final_project/pages/project_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
      // appBar: AppBar(
      //   title: Text(widget.projectName),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  width: 800,
                  child: LottieBuilder.asset(
                    'assets/animation/loading-45.json',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 85,
                  left: 135,
                  child: Center(
                    child: Text(
                      widget.projectName,
                      style: GoogleFonts.sono(
                        color: const Color.fromARGB(255, 8, 27, 66),
                        fontSize: 28,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            for (var i in projectList) ...[
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectDetails(pName: i.pName)));
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xffECEFF1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 20.0,
                        color: Color.fromARGB(255, 8, 27, 66),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                i.pName,
                                style: GoogleFonts.ibmPlexSansArabic(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: const Color.fromARGB(255, 8, 27, 66),
                                ),
                              ),
                              Text(
                                i.userName,
                                style: GoogleFonts.ibmPlexSansArabic(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
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








// import 'package:final_project/models/explore.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class DevelopersListPage extends StatefulWidget {
//   const DevelopersListPage({super.key, required this.projectName});
//   final String projectName;

//   @override
//   State<DevelopersListPage> createState() => _DevelopersListPageState();
// }

// class _DevelopersListPageState extends State<DevelopersListPage> {
//   /// Supabase decleration ...
//   final supabase = Supabase.instance.client;

//   /// List of Projects ...
//   List<AddNewProject> projectList = [];

//   /// This method to get data from supabase ...

//   Future<List<AddNewProject>> getProjects() async {
//     final response = await supabase
//         .from('newProject')
//         .select('*')
//         .eq('pId', widget.projectName)
//         .execute();

//     List<AddNewProject> newList = [];

//     for (var project in response.data) {
//       final projects = AddNewProject.fromJson(project);
//       newList.add(projects);
//     }
//     setState(() {
//       projectList = newList;
//     });
//     return newList;
//   }

//   /// Changing the like icon color and state ...
//   bool isLiked = false;

//   @override
//   void initState() {
//     getProjects();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.projectName),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: ListView(
//           children: [
//             const Placeholder(
//               fallbackHeight: 200,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             for (var i in projectList) ...[
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           isLiked = !isLiked;
//                         });
//                       },
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.favorite_border,
//                             size: 20.0,
//                             color: isLiked ? Colors.red : Colors.white,
//                           ),
//                           Text(
//                             i.postLike.toString(),
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Column(
//                           children: [
//                             Text(
//                               i.pName,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               i.userName,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         const Icon(Icons.circle, size: 40.0),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
