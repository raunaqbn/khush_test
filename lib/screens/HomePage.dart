import 'dart:ui';
import 'package:flutter/material.dart';
import 'HomeView.dart';
import 'Baagdu.dart';

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
    Widget page;
// Select page based on the index
    switch (_selectedIndex) {
      case 0:
        page = HomeView(context);
        break;
      case 1:
        page = Baagdu(context);
        break;
      case 2:
        page = HomeView(context);
        break;
      default:
        page = HomeView(context);
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: TopAppBar(),
      body: page,
      bottomNavigationBar: bottomNavBar(),
    );
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

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
      // on item selected function
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color.fromARGB(255, 128, 119, 119),
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
    );
  }
}
