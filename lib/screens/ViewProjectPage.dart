import 'package:flutter/material.dart';
import 'package:namer_app/screens/HomePage.dart';
import 'package:namer_app/screens/ImageCardData.dart';
import 'package:namer_app/screens/VideoPlayerPage.dart';

class ViewProjectPage extends StatefulWidget {
  final String projectTitle;
  final ImageCardData imageCardData;

  ViewProjectPage({
    required this.projectTitle,
    required this.imageCardData,
  });

  @override
  State<ViewProjectPage> createState() => _ViewProjectPageState();
}

class _ViewProjectPageState extends State<ViewProjectPage> {
  final List<String> languages = [
    'English',
    'Spanish',
    'Hindi',
    'French',
    'German',
  ];

  final List<String> languageImages = [
    'https://4kwallpapers.com/images/wallpapers/british-flag-union-5000x2500-9445.jpg',
    'https://www.motosha.com/files/preview/1280x711/2186-spanish-flag.jpg?size=large%20850w',
    'https://wallpapers.com/images/featured/ppog2bywedaxxa6j.jpg',
    'https://images.alphacoders.com/958/95873.jpg',
    'https://img2.goodfon.com/wallpaper/big/a/2c/germaniya-flag-germany-flag.jpg',
  ];

  List<String> _selectedLanguages = [];

  @override
  void initState() {
    super.initState();
    // Add the initially selected languages from the ImageCardData to the list of selected languages
    _selectedLanguages.addAll(widget.imageCardData.selectedLanguages);
  }

  void _addSelectedLanguage(String language) {
    setState(() {
      // Add the selected language to the list of selected languages
      widget.imageCardData.selectedLanguages.add(language);
    });
  }

  void _removeSelectedLanguage(String language) {
    setState(() {
      // Remove the selected language from the list of selected languages
      widget.imageCardData.selectedLanguages.remove(language);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                widget.projectTitle,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
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
      body: Container(
        height: 400, // Set a fixed height for the container
        child: ListView.builder(
          itemCount: _selectedLanguages.length,
          itemBuilder: (context, index) {
            final selectedLanguage = _selectedLanguages[index];
            final languageIndex = languages.indexOf(selectedLanguage);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: SizedBox(
                  width: 80,
                  height: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      languageImages[languageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  selectedLanguage,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.play_circle_fill_outlined,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () {
                    // Handle play button pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(
                          videoUrl:
                              'https://assets.mixkit.co/videos/preview/mixkit-young-man-missing-a-bowling-shot-49117-large.mp4',
                        ),
                      ),
                    );
                  },
                ),
                onLongPress: () {
                  _removeSelectedLanguage(selectedLanguage);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
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
        child: FloatingActionButton.extended(
          onPressed: () {
            _showAddTranslationDialog();
          },
          icon: Icon(Icons.add),
          label: Text('Add New Translation'),
          backgroundColor: Colors.transparent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showAddTranslationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select a New Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children: languages.map((language) {
                return ListTile(
                  title: Text(language),
                  onTap: () {
                    _addSelectedLanguage(language);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
