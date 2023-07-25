import 'package:flutter/material.dart';
import 'package:namer_app/screens/ImageCardData.dart';
import 'CreatePage.dart';
import 'ViewProjectPage.dart';
import 'HomePage.dart';

class HomeView extends StatelessWidget {
  final List<ImageCardData> imageCards;
  final Function(ImageCardData) onAddImageCard;
  final Function(ImageCardData) onDeleteImageCard;
  final List<String>
      selectedLanguages; // New property to hold selected languages

  HomeView({
    required this.imageCards,
    required this.onAddImageCard,
    required this.onDeleteImageCard,
    required this.selectedLanguages,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePage(
                        imageCards: imageCards,
                        onAddImageCard: onAddImageCard,
                        selectedLanguages: selectedLanguages,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 10, 28, 78)!,
                        Color.fromARGB(255, 28, 11, 82)!,
                        Color.fromARGB(255, 56, 30, 119)!,
                        Color.fromARGB(255, 0, 34, 158)!,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Create New Project",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 18.0),
              child: Text(
                'Current Projects',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: imageCards.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: buildImageCard(
                    imageUrl: imageCards[index].imageUrl,
                    foregroundText: imageCards[index].foregroundText,
                    selectedLanguages: imageCards[index]
                        .selectedLanguages, // Pass selectedLanguages as a list
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewProjectPage(
                            projectTitle: imageCards[index].foregroundText,
                            selectedLanguages: imageCards[index]
                                .selectedLanguages, // Pass selectedLanguages as a list
                          ),
                        ),
                      );
                    },
                    onDelete: () {
                      onDeleteImageCard(imageCards[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

// Define buildImageCard function outside the HomeView class
  Widget buildImageCard({
    required String imageUrl,
    required String foregroundText,
    required List<String> selectedLanguages, // Corrected parameter type
    required VoidCallback onTap,
    required VoidCallback onDelete,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(imageUrl),
              height: 200,
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () {},
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foregroundText,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedLanguages.join(
                        ', '), // Display selected languages as a comma-separated string
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.white,
                onPressed: onDelete, // Call the onDelete callback when pressed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
