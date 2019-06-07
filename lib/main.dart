import 'package:flutter/material.dart';
import 'package:qrreader/src/pages/home_page.dart';
import 'package:qrreader/src/pages/maps_page.dart';
import 'package:qrreader/src/pages/directions_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QrReader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'maps': (BuildContext context) => MapsPage(),
        'directions': (BuildContext context) => DirectionsPage(),
      },
      theme:ThemeData(
        primaryColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
