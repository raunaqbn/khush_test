import 'dart:ui';
import 'package:flutter/material.dart';
import 'CreatePage.dart';
import 'ViewProjectPage.dart';

class ImageCardData {
  final String imageUrl;
  final String foregroundText;
  final String subtext;

  ImageCardData({
    required this.imageUrl,
    required this.foregroundText,
    required this.subtext,
  });
}

SingleChildScrollView HomeView(BuildContext context) {
  final List<ImageCardData> imageCards = [
    ImageCardData(
      imageUrl:
          'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/94b451100579611.5ff9a6374307b.jpg',
      foregroundText: "Khush's Project",
      subtext: 'Translation: Multiple Languages',
    ),
    ImageCardData(
      imageUrl: 'https://i.ytimg.com/vi/3YNku5FKWjw/maxresdefault.jpg',
      foregroundText: "Raunaq's Project",
      subtext: 'Translation: English to Japanese',
    ),
    ImageCardData(
      imageUrl:
          'https://pbs.twimg.com/ext_tw_video_thumb/1613570354089181185/pu/img/fp5InRCF8E9qG7nh.jpg',
      foregroundText: 'Project 3',
      subtext: 'Translation: English to Russian',
    ),
  ];

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
                  MaterialPageRoute(builder: (context) => CreatePage()),
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
                  subtext: imageCards[index].subtext,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewProjectPage(
                          projectTitle: imageCards[index].foregroundText,
                        ),
                      ),
                    );
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

Widget buildImageCard({
  required String imageUrl,
  required String foregroundText,
  required String subtext,
  required VoidCallback onTap,
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
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color.fromARGB(255, 27, 3, 36).withOpacity(0.6)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foregroundText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtext,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
