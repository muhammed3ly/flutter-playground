import 'package:flutter/material.dart';
import 'package:movies_test/widgets/movies_by_genres.dart';
import 'package:movies_test/widgets/now_playing.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.dehaze,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: Text('Roovies'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          NowPlaying(),
          MoviesByGenres(),
        ],
      ),
    );
  }
}
