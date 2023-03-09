import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:final_project/models/explore.dart';
import 'package:final_project/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';

import '../components/animated_textfield.dart';
import '../components/ct_elevatedButton.dart';
import '../components/ct_textfield_title.dart';
import '../components/upload_vid_button.dart';

class AddNewProjectPage extends StatefulWidget {
  const AddNewProjectPage({super.key});

  @override
  _AddNewProjectPageState createState() => _AddNewProjectPageState();
}

class _AddNewProjectPageState extends State<AddNewProjectPage> {
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
          AwesomeDialog(
            context: context,
            animType: AnimType.leftSlide,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            showCloseIcon: true,
            title: 'تم تحميل الفيديو بنجاح',
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
  }

  /// UPLOAD VIDEO TO SUPABASE FUNCTION ...

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
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _selectedOption,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedOption = newValue!;
                          });
                          print(newValue);
                        },
                        style: const TextStyle(
                            color: Colors.blueGrey,
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
                            iconEnabledColor: Colors.grey,
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
              SizedBox(
                width: 400,
                child: AnimatedTextField(
                  label: '.. اسم المشروع',
                  suffix: null,
                  xController: nameController,
                ),
              ),
              const CTTextFieldTittle('الوصف'),
              SizedBox(
                width: 400,
                height: 200,
                child: AnimatedTextField(
                  label: '.. وصف المشروع',
                  suffix: null,
                  xController: descriptionController,
                ),
              ),
              const CTTextFieldTittle(' Git Hub رابط المشروع على'),
              SizedBox(
                width: 400,
                child: AnimatedTextField(
                  label: '.. Git Hub رابط ',
                  suffix: null,
                  xController: projectLinkController,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/4144/4144765.png',
                      height: 45,
                    ),
                    const SizedBox(
                      width: 190,
                    ),

                    // const JumpingDots(
                    //   color: Colors.blueGrey,
                    //   radius: 10,
                    // ),
                    SizedBox(
                      width: 160,
                      height: 40,
                      child: UploadVidButton(
                          title: 'تحميل مقطع الفيديو', onTap: pickVideo),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: SizedBox(
                  height: 40,
                  child: MyButton(
                    title: 'اضف المشروع',
                    onTap: () async {
                      print(_selectedOption);
                      final project = AddNewProject(
                        pId: _selectedOption,
                        pName: nameController.text,
                        pDescription: descriptionController.text,
                        gitHubLink: projectLinkController.text,
                        userName: userName(),
                      );
                      final response = await supabase
                          .from('newProject')
                          .insert([project.toJson()]);
                      await uploadVideoToSupabase();
                    },
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
