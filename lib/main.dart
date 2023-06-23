import 'package:flutter/material.dart';
import 'package:namer_app/screens/SignInPage.dart';
import 'package:namer_app/screens/SignUpPage.dart';
import 'package:namer_app/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Widget initialPage;

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          initialPage = HomePage();
        } else {
          initialPage = SignInPage();
        }

        return MaterialApp(
          title: 'Translatify',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => initialPage,
            '/signin': (context) => SignInPage(),
            '/signup': (context) => SignUpPage(),
            '/home': (context) => HomePage(),
          },
        );
      },
    );
  }
}
