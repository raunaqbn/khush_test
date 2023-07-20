import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'HomeView.dart';
import 'ProfilePage.dart';
import 'CreatePage.dart';
import 'ViewProjectPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<ImageCardData> imageCards = [
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

  @override
  void initState() {
    super.initState();
    _loadImageCards();
    getImageCards().then((cards) {
      setState(() {
        imageCards = cards;
      });
    });
  }

  Future<void> saveImageCards(List<ImageCardData> imageCards) async {
    final preferences = await SharedPreferences.getInstance();
    final imageCardList =
        imageCards.map((card) => json.encode(card.toJson())).toList();
    await preferences.setStringList('imageCards', imageCardList);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Show sidebar for widescreen devices
          return buildSidebarLayout();
        } else {
          // Show bottom navigation bar for smaller mobile devices
          return buildBottomNavBarLayout();
        }
      },
    );
  }

  String _selectedLanguage = 'English';

  Widget buildSidebarLayout() {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: TopAppBar(),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            child: NavigationRail(
              backgroundColor: Color.fromARGB(255, 15, 14, 14),
              selectedIconTheme: IconThemeData(color: Colors.white),
              unselectedIconTheme: IconThemeData(color: Colors.grey),
              selectedLabelTextStyle: TextStyle(color: Colors.white),
              unselectedLabelTextStyle: TextStyle(color: Colors.grey),
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home_rounded),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.newspaper_outlined),
                  label: Text('Feed'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('Profile'),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Container(
              color: Colors.black,
              child: buildPage(context, _selectedLanguage),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavBarLayout() {
    Widget page = buildPage(context, _selectedLanguage);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: TopAppBar(),
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        // on item selected function
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 128, 119, 119),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined),
            label: "Feed",
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }

  Widget buildPage(BuildContext context, String selectedLanguage) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = HomeView(
          selectedLanguage: selectedLanguage,
          imageCards: imageCards,
          onAddImageCard: _addImageCard,
          onDeleteImageCard: _deleteImageCard, // Pass the delete function here
        );
        break;
      case 1:
        page = HomeView(
          selectedLanguage: selectedLanguage,
          imageCards: imageCards,
          onAddImageCard: _addImageCard,
          onDeleteImageCard: _deleteImageCard, // Pass the delete function here
        );
        break;
      case 2:
        page = ProfilePage();
        break;
      default:
        page = HomeView(
          selectedLanguage: selectedLanguage,
          imageCards: imageCards,
          onAddImageCard: _addImageCard,
          onDeleteImageCard: _deleteImageCard, // Pass the delete function here
        );
    }
    return page;
  }

  void _addImageCard(ImageCardData newImageCard) {
    // Provide a default image if imageURL is not specified
    print(newImageCard.imageUrl);
    if (newImageCard.imageUrl.isEmpty) {
      newImageCard.imageUrl =
          '/Users/khushnaidu/internship/development/khush_basics/namer_app/assets/placeholder_image.png'; // Update with your placeholder image asset path
    }
    setState(() {
      imageCards.add(newImageCard);
    });
    saveImageCards(imageCards); // Save image cards after adding a new card
  }

  void _deleteImageCard(ImageCardData cardToDelete) {
    setState(() {
      imageCards.remove(cardToDelete);
    });
    saveImageCards(imageCards); // Save the updated list to SharedPreferences
  }

  Future<List<ImageCardData>> getImageCards() async {
    final preferences = await SharedPreferences.getInstance();
    final imageCardList = preferences.getStringList('imageCards');
    if (imageCardList != null) {
      return imageCardList
          .map((cardJson) => ImageCardData.fromJson(json.decode(cardJson)))
          .toList();
    }
    return []; // Return an empty list if no image cards are found
  }

  // Function to load the image cards when the user logs in
  Future<void> _loadImageCards() async {
    List<ImageCardData> loadedCards = await getImageCards();
    print('Loaded cards: $loadedCards');
    setState(() {
      imageCards = loadedCards;
    });
  }

  AppBar TopAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        IconButton(onPressed: () {}, icon: Icon(Icons.help_outline)),
        IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
      ],
    );
  }
}
