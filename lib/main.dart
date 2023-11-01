import 'package:kutuphaneapp/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:kutuphaneapp/pages/login_page.dart';

class MyAppTheme {
  static ThemeData myTheme = ThemeData(
    primaryColor: Color.fromARGB(255, 179, 179, 68),
    backgroundColor: Color.fromARGB(255, 249, 248, 245),
    fontFamily: 'AlbertusNova',
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontFamily: 'AlbertusNova', color: Color(0x854700), fontSize: 17.0),
      headline1: TextStyle(
        fontFamily: 'AlbertusNova',
        color: Color.fromARGB(255, 84, 112, 8),
        fontSize: 24.0,
      ),
      // Other text styles can be defined here.
    ),
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyAppTheme.myTheme,
      home: KutuphaneApp(),
    );
  }
}

class KutuphaneApp extends StatelessWidget {
  const KutuphaneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPageScreen(),
    );
  }
}
