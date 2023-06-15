import 'package:flutter/material.dart';
import 'HomeView.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String _selectedLanguage = 'English';

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
                    Color.fromARGB(255, 154, 39, 165),
                    Color.fromARGB(255, 219, 86, 184),
                    Color.fromARGB(255, 172, 84, 216),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Text(
                'New Project',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.translate,
              color: Color.fromARGB(255, 175, 98, 233),
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
                  border: OutlineInputBorder(),
                ),
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
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Logic for uploading video from device
                    },
                    child: Text('Upload from Device'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                      ),
                      minimumSize: Size(
                          150, 50), // Adjust the width and height as needed
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      primary: Color.fromARGB(255, 118, 8, 138),
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
              SizedBox(height: 20),
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
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    // Set focused border color
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 53, 218)),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ), // Set dropdown text color
                dropdownColor: Colors.black, // Set dropdown background color
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // Logic for translating the project
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                      ),
                      minimumSize: Size(
                          150, 50), // Adjust the width and height as needed
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      primary: Color.fromARGB(255, 182, 39, 111),
                    ),
                    child: Text('Translatify It!',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
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
