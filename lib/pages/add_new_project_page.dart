import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoSelectorWidget extends StatefulWidget {
  @override
  _VideoSelectorWidgetState createState() => _VideoSelectorWidgetState();
}

class _VideoSelectorWidgetState extends State<VideoSelectorWidget> {
  File? _selectedVideo;
  VideoPlayerController? _controller;

  Future<void> pickVideo() async {
    final selected = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (selected != null) {
      setState(() {
        _selectedVideo = File(selected.path);
        _controller = VideoPlayerController.file(_selectedVideo!);
        _controller!.initialize().then(() {
              setState(() {});
            } as FutureOr Function(void value));
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        ElevatedButton(
          onPressed: pickVideo,
          child: const Text('Select Video'),
        ),
        if (_controller != null && _controller!.value.isInitialized)
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
      ],
    );
  }
}
