// // ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';




// class PageFile extends StatefulWidget {
//   @override
//   _PageFileState createState() => _PageFileState();
// }

// class _PageFileState extends State<PageFile> {
//   File? _pickedFile;
//   VideoPlayerController? _videoPlayerController;

//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['mp4', 'mov', 'avi'], 
//     );

//     if (result != null) {
//       setState(() {
//         _pickedFile = File(result.files.single.path!);
//         _videoPlayerController = VideoPlayerController.file(_pickedFile!);
//         _videoPlayerController!.initialize();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _videoPlayerController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('File Picker Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: _pickFile,
//               child: Text('Pick a Video'),
//             ),
//             SizedBox(height: 20),
//             if (_videoPlayerController != null)
//               AspectRatio(
//                 aspectRatio: _videoPlayerController!.value.aspectRatio,
//                 child: VideoPlayer(_videoPlayerController!),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
