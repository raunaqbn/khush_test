import 'package:flutter/material.dart';

class ViewProjectPage extends StatelessWidget {
  final String projectTitle;
  final String selectedLanguage;

  ViewProjectPage({
    required this.projectTitle,
    required this.selectedLanguage,
  });

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
                projectTitle,
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
          itemCount: languages.length,
          itemBuilder: (context, index) {
            print("Selected Language: $selectedLanguage");
            print("language index: ${languages[index]}");
            if (languages[index] == selectedLanguage) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: SizedBox(
                    width: 80,
                    height: 48,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        languageImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    languages[index],
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.play_circle_fill_outlined,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      // Handle play button pressed
                    },
                  ),
                ),
              );
            } else {
              return Container(); // Return an empty container for non-selected languages
            }
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
            // Handle add new translation button pressed
          },
          icon: Icon(Icons.add),
          label: Text('Add New Translation'),
          backgroundColor: Colors
              .transparent, // Set the button's background color as transparent
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
