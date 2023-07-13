import 'dart:ui';
import 'package:flutter/material.dart';
import 'HomeView.dart';
import 'ProfilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[];

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
              child: buildPage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavBarLayout() {
    Widget page = buildPage();
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

  Widget buildPage() {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = HomeView(context);
        break;
      case 1:
        page = HomeView(context);
        break;
      case 2:
        page = ProfilePage();
        break;
      default:
        page = HomeView(context);
    }
    return page;
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
