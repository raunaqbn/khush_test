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
  final List<ImageCardData> imageCards;
  final Function(ImageCardData) onAddImageCard;

  const CreatePage({
    Key? key,
    required this.imageCards,
    required this.onAddImageCard,
  }) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final Image placeholderImage = Image.asset('assets/placeholder_image.jpg');

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => _selectedFilePath = path);
  }

  String _selectedLanguage = 'English';
  String? _selectedFilePath;
  File? pickedFile;

  Future<String?> pickImageFromGallery() async {
    try {
      final String? result =
          await _channel.invokeMethod('pickImageFromGallery');
      return result;
    } on PlatformException catch (e) {
      // Handle any error that occurred during the method call
      print('Error: ${e.message}');
      return null;
    }
  }

  Future<String?> pickVideoFromGallery() async {
    try {
      final String? result =
          await _channel.invokeMethod('pickVideoFromGallery');
      return result;
    } on PlatformException catch (e) {
      // Handle any error that occurred during the method call
      print('Error: ${e.message}');
      return null;
    }
  }

  getVideo(ImageSource source) async {
    final video = await ImagePicker().pickVideo(source: source);
    if (video == null) return;
    final videoTemporary = File(video.path);

    setState(() => pickedFile = videoTemporary);
  }

  getIOSVideo(ImageSource source) async {
    final ImagePickerPlatform _picker = ImagePickerPlatform.instance;
    final video = await _picker.pickVideo(source: source);
    if (video == null) return;
    final videoTemporary = File(video.path);

    if (Platform.isIOS) {
      Future.microtask(() {
        setState(() => pickedFile = videoTemporary);
      });
    } else {
      setState(() => pickedFile = videoTemporary);
    }
  }

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
                      primary: Color.fromARGB(255, 0, 0, 0),
                      onPrimary: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      pickVideoFromGallery();
                    },
                    child: Text('Upload from Gallery'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 0, 0),
                      onPrimary: Colors.white,
                    ),
                  ),
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
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _languages.map((language) {
                  return FilterChip(
                    label: Text(language),
                    selected: _selectedLanguage == language,
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedLanguage = language;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Create a new ImageCardData object with the provided information
                      final newImageCard = ImageCardData(
                        imageUrl:
                            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhEsqFp9ZuQeiWzbc-Sb0qCQZ9ijs144xF2dJqmiBYzEdt0E0ty2mZ_MilBakb0pCtOnNZdJbIvxPyN3Mf5VlwZe5dIsjAVLNHEYswicEZqliJ2jbKU-k_fncGx_PDuYNas4JnECjxohJCrTPoeb6TtAiM_rxWhwSM9GbOSPVEMQAYySHhjg4aSg19Tw9GI/w396-h223/Translatify%20Project%20Card.png', // placeholder image URL
                        foregroundText: _projectName ?? '',
                        subtext: _selectedLanguage,
                      );

                      // Call the onAddImageCard function to add the new image card
                      widget.onAddImageCard(newImageCard);

                      // Navigate back to the HomeView page
                      Navigator.pop(context);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Translatify!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
