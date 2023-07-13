import 'dart:io';
import 'package:flutter/material.dart';
import 'HomeView.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_ios/image_picker_ios.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

final MethodChannel _channel = const MethodChannel('image_picker_channel');

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => _selectedFilePath = path);
  }

  String _selectedLanguage = 'English';
  String? _selectedFilePath;
  File? pickedFile;

  // Future<String?> pickImageFromGallery() async {
  //   try {
  //     final String? result =
  //         await _channel.invokeMethod('pickImageFromGallery');
  //     return result;
  //   } on PlatformException catch (e) {
  //     // Handle any error that occurred during the method call
  //     print('Error: ${e.message}');
  //     return null;
  //   }
  // }

  // Future<String?> pickVideoFromGallery() async {
  //   try {
  //     final String? result =
  //         await _channel.invokeMethod('pickVideoFromGallery');
  //     return result;
  //   } on PlatformException catch (e) {
  //     // Handle any error that occurred during the method call
  //     print('Error: ${e.message}');
  //     return null;
  //   }
  // }

  // getVideo(ImageSource source) async {
  //   final video = await ImagePicker().pickVideo(source: source);
  //   if (video == null) return;
  //   final videoTemporary = File(video.path);

  //   setState(() => pickedFile = videoTemporary);
  // }

  // getIOSVideo(ImageSource source) async {
  //   // final video = await ImagePicker().pickVideo(source: source);
  //   final ImagePickerPlatform _picker = ImagePickerPlatform.instance;
  //   final video = await _picker.pickVideo(source: source);
  //   if (video == null) return;
  //   final videoTemporary = File(video.path);

  //   if (Platform.isIOS) {
  //     Future.microtask(() {
  //       setState(() => pickedFile = videoTemporary);
  //     });
  //   } else {
  //     setState(() => pickedFile = videoTemporary);
  //   }
  // }

  // getVideo(ImageSource source) async {
  //   final video = await ImagePicker().pickVideo(source: source);
  //   if (video == null) return;
  //   final videoTemporary = File(video.path);

  //   setState(() => pickedFile = videoTemporary);
  // }

  // getIOSVideo(ImageSource source) async {
  //   // final video = await ImagePicker().pickVideo(source: source);
  //   final ImagePickerPlatform _picker = ImagePickerPlatform.instance;
  //   final video = await _picker.pickVideo(source: source);
  //   if (video == null) return;
  //   final videoTemporary = File(video.path);

  //   if (Platform.isIOS) {
  //     Future.microtask(() {
  //       setState(() => pickedFile = videoTemporary);
  //     });
  //   } else {
  //     setState(() => pickedFile = videoTemporary);
  //   }
  // }

  // late File _video;
  // final picker = ImagePicker();
  // late VideoPlayerController _videoPlayerController;

  // _pickVideo() async {
  //   final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     final path = pickedFile.path!;
  //     WidgetsBinding.instance?.addPostFrameCallback((_) {
  //       _initializeVideoPlayer(path);
  //     });
  //   }
  // }

  // // Function to initialize the VideoPlayerController
  // void _initializeVideoPlayer(String path) {
  //   setState(() {
  //     _videoPlayerController = VideoPlayerController.file(File(path));
  //   });

  //   _videoPlayerController!.initialize().then((_) {
  //     setState(() {
  //       _videoPlayerController!.play();
  //     });
  //   });
  // }

  String? _projectName;
  bool _englishSelected = true;
  bool _spanishSelected = false;
  bool _frenchSelected = false;
  bool _germanSelected = false;
  bool _japaneseSelected = false;
  bool _chineseSelected = false;

  List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Japanese',
    'Chinese',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        toolbarHeight: 70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Row(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Color.fromARGB(255, 240, 221, 242),
                    Color.fromARGB(255, 252, 252, 252),
                    Color.fromARGB(255, 239, 217, 250),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Text(
                'New Project',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.translate,
              color: Colors.white,
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 10, 28, 78),
                Color.fromARGB(255, 28, 11, 82),
                Color.fromARGB(255, 56, 30, 119),
                Color.fromARGB(255, 0, 34, 158),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove the shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                style: TextStyle(color: Colors.white), // Set text color
                decoration: InputDecoration(
                  hintText: 'Enter project name',
                  hintStyle:
                      TextStyle(color: Colors.grey), // Set hint text color
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color.fromARGB(
                            255, 201, 201, 201)), // Set border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color.fromARGB(
                            255, 201, 201, 201)), // Set enabled border color
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _projectName = value;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Enter Video URL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                style: TextStyle(color: Colors.white), // Set text color
                decoration: InputDecoration(
                  hintText: 'Enter video URL',
                  hintStyle:
                      TextStyle(color: Colors.grey), // Set hint text color
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 201, 201, 201),
                    ), // Set border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 201, 201, 201),
                    ), // Set enabled border color
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (Platform.isIOS) {
                        getIOSVideo(ImageSource.gallery);
                      } else {
                        getVideo(ImageSource.gallery);
                      }
                    },
                    child: Text('Upload from Device'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            25), // Adjust the radius as needed
                      ),
                      minimumSize: Size(
                          150, 50), // Adjust the width and height as needed
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      primary: Color.fromARGB(255, 56, 30, 119),
                      onPrimary: Colors.white,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'No file selected',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ), // Replace with actual file name if selected
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Select Language',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 13),
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                    _englishSelected = newValue == 'English';
                    _spanishSelected = newValue == 'Spanish';
                    _frenchSelected = newValue == 'French';
                    _germanSelected = newValue == 'German';
                    _japaneseSelected = newValue == 'Japanese';
                    _chineseSelected = newValue == 'Chinese';
                  });
                },
                items: _languages.map((language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(
                      language,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 201, 201, 201),
                    ), // Set border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 201, 201, 201),
                    ), // Set enabled border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 201, 201, 201),
                    ), // Set focused border color
                  ),
                ),
                style: TextStyle(
                  color: const Color.fromARGB(255, 201, 201, 201),
                  fontSize: 15,
                ), // Set dropdown text color
                dropdownColor: Colors.black, // Set dropdown background color
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 10, 28, 78),
                          Color.fromARGB(255, 28, 11, 82),
                          Color.fromARGB(255, 56, 30, 119),
                          Color.fromARGB(255, 0, 34, 158),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // On press, navigate to a Homeview but update the current projects and show progress of translating the project
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              25), // Adjust the radius as needed
                        ),
                        minimumSize: Size(
                            150, 50), // Adjust the width and height as needed
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        primary: Colors
                            .transparent, // Set the button's background color as transparent
                        onPrimary: Colors
                            .white, // Set the button's text color as white
                      ),
                      child: Text(
                        'Translatify It!',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
