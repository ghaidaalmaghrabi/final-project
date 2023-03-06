import 'dart:async';
import 'dart:io';

import 'package:final_project/models/explore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';

class AddNewProject extends StatefulWidget {
  const AddNewProject({super.key});

  @override
  _AddNewProjectState createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
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
    final response = await supabase.storage.from('demo-vid').uploadBinary('videos/$fileName', bytes);
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
        title: const Text('أضف مشروع جديد'),
        actions: const [
          Icon(Icons.close),
          SizedBox(
            width: 14,
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'الاسم',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'الوصف',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: projectLinkController,
            decoration: const InputDecoration(
              hintText: 'رابط مشروع قيت هب',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          DropdownButton<String>(
            items: <String>['Flutter', 'Swift', 'UI / UX'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            value: _selectedOption,
            hint: const Text('Select an option'),
            onChanged: (newValue) {
              setState(() {
                _selectedOption = newValue!;
              });
              print(newValue);
            },
            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: pickVideo,
            child: const Text('تحميل مقطع الفيديو'),
          ),
          ElevatedButton(
            onPressed: () async {
              print(_selectedOption);
              final project = AddNewProject(
                pId: _selectedOption,
                pName: nameController.text,
                pDescription: descriptionController.text,
                gitHubLink: projectLinkController.text,
              );
              final response = await supabase.from('newProject').insert(
                [
                  project.toJson(),
                ],
              );

              await uploadVideoToSupabase();
            },
            child: const Text('اضف المشروع'),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
