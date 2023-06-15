import 'dart:ui';
import 'package:flutter/material.dart';
import 'CreatePage.dart';

SingleChildScrollView HomeView(BuildContext context) {
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
          // Image Card
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: buildImageCard(
              imageUrl:
                  'https://pbs.twimg.com/card_img/1667082619136413697/FBEP-LaW?format=jpg&name=large',
              foregroundText: 'Project 1',
              subtext: 'Translation: English to Spanish',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: buildImageCard(
              imageUrl:
                  'https://i0.wp.com/hubermanlab.com/wp-content/uploads/2023/04/Episode-Card-122-Noam-Sobel.jpg?fit=1080%2C608&ssl=1',
              foregroundText: 'Project 2',
              subtext: 'Translation: English to Japanese',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: buildImageCard(
              imageUrl:
                  'https://i.ytimg.com/vi/dl2fnWIlDZg/hqdefault.jpg?sqp=-oaymwEjCPYBEIoBSFryq4qpAxUIARUAAAAAGAElAADIQj0AgKJDeAE=&rs=AOn4CLBSbvPShsaMns7-sDgk74GBAsUqsw',
              foregroundText: 'Project 3',
              subtext: 'Translation: English to Russian',
            ),
          ),
          // Add more image cards here
        ],
      ),
    ),
  );
}

Widget buildImageCard(
    {required String imageUrl,
    required String foregroundText,
    required String subtext}) {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
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
  );
}
