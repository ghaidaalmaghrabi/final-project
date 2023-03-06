import 'dart:async';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:final_project/models/explore.dart';
import 'package:final_project/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';

import '../components/animated_textfield.dart';
import '../components/ct_elevatedButton.dart';
import '../components/ct_textfield_title.dart';

class AddNewProjectPage extends StatefulWidget {
  const AddNewProjectPage({super.key});

  @override
  _AddNewProjectPageState createState() => _AddNewProjectPageState();
}

class _AddNewProjectPageState extends State<AddNewProjectPage> {
  /// SUPABASE DECLARATION ...
  final supabase = Supabase.instance.client;

  /// DROPDOWN MENU FIRST OPTION ...
  String _selectedOption = 'Flutter';

  /// TEXTFIELD CONTROLLERS ...
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final projectLinkController = TextEditingController();

  /// PICK VIDEO FUNCTION ...
  File? _selectedVideo;
  VideoPlayerController? _controller;

  Future<void> pickVideo() async {
    final selected = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (selected != null) {
      setState(() {
        _selectedVideo = File(selected.path);
        _controller = VideoPlayerController.file(_selectedVideo!);
        _controller!.initialize().then((_) {
          setState(() {});
        });
      });
    }
  }

  /// UPLOAD VIDEO TO SUPABASE FUNCTION ...
  ///

  Future<void> uploadVideoToSupabase() async {
    if (_selectedVideo == null) {
      return;
    }

    final fileName = _selectedVideo!.path.split('/').last;
    final bytes = await _selectedVideo!.readAsBytes();

    final response = await supabase.storage
        .from('demo-vid')
        .uploadBinary('videos/$fileName', bytes);

  }

  ///
  /// DISPOSE CONTROLLERS ...

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    nameController.dispose();
    descriptionController.dispose();
    projectLinkController.dispose();
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
                builder: (context) => const SettingsPage(),
              ),
            );
          },
          child: const Icon(Icons.menu, color: Colors.grey),
        ),
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/LogoName.png', height: 50),
        actions: [
          Image.asset('assets/images/LogoPic.png', width: 50, height: 50),
          const SizedBox(width: 10),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: <String>['Flutter', 'Swift', 'UI / UX']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        value: _selectedOption,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedOption = newValue!;
                          });
                          print(newValue);
                        },
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        isExpanded: true,
                        buttonStyleData: ButtonStyleData(
                          height: 40,
                          width: 200,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(14)),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            iconDisabledColor: Colors.grey,
                            iconEnabledColor: Colors.red,
                            iconSize: 20),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          padding: null,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14)),
                          elevation: 8,
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                              thickness: MaterialStateProperty.all<double>(6),
                              radius: const Radius.circular(40)),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14)),
                      ),
                    ),
                  ),
                  const CTTextFieldTittle('نوع المشروع'),
                ],
              ),
              const CTTextFieldTittle('الإسم'),
              const SizedBox(
                width: 400,
                child: AnimatedTextField(label: '.. اسم المشروع', suffix: null),
              ),
              const CTTextFieldTittle('الوصف'),
              const SizedBox(
                width: 400,
                height: 200,
                child: AnimatedTextField(label: '.. وصف المشروع', suffix: null),
              ),
              const CTTextFieldTittle(' Git Hub رابط المشروع على'),
              const SizedBox(
                width: 400,
                child: AnimatedTextField(
                  label: '.. Git Hub رابط ',
                  suffix: null,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 160,
                      child: MyButton(
                        title: 'تحميل مقطع الفيديو',
                        onTap: pickVideo,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 160,
                      child: MyButton(
                        title: 'اضف المشروع',
                        onTap: () async {
                          print(_selectedOption);
                          final project = AddNewProject(
                            pId: _selectedOption,
                            pName: nameController.text,
                            pDescription: descriptionController.text,
                            gitHubLink: projectLinkController.text,
                          );
                          final response =
                              await supabase.from('newProject').insert(
                            [
                              project.toJson(),
                            ],
                          );

                          await uploadVideoToSupabase();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   child: ElevatedButton(
              //     onPressed: pickVideo,
              //     child: const Text('تحميل مقطع الفيديو'),
              //   ),
              // ),

              // ElevatedButton(
              //   onPressed: () async {
              //     print(_selectedOption);
              //     final project = AddNewProject(
              //       pId: _selectedOption,
              //       pName: nameController.text,
              //       pDescription: descriptionController.text,
              //       gitHubLink: projectLinkController.text,
              //     );
              //     final response = await supabase.from('newProject').insert(
              //       [
              //         project.toJson(),
              //       ],
              //     );

              //     await uploadVideoToSupabase();
              //   },
              //   child: const Text('اضف المشروع'),
              // ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
