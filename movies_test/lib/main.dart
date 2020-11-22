import 'package:flutter/material.dart';
import 'package:movies_test/helpers/constants.dart';
import 'package:movies_test/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roovies',
      theme: ThemeData(
        primarySwatch: Constants.primarySwatch,
        accentColor: Constants.accentColor,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        scaffoldBackgroundColor: Constants.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
