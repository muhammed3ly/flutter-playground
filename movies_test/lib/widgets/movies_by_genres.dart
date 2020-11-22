import 'package:flutter/material.dart';
import 'package:movies_test/widgets/movies_list.dart';

class MoviesByGenres extends StatefulWidget {
  @override
  _MoviesByGenresState createState() => _MoviesByGenresState();
}

class _MoviesByGenresState extends State<MoviesByGenres>
    with TickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      height: isLandscape
          ? MediaQuery.of(context).size.height * 0.8
          : MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          bottom: TabBar(
            controller: controller,
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Action',
              ),
              Tab(
                text: 'Romance',
              ),
              Tab(
                text: 'Comedy',
              ),
              Tab(
                text: 'aaaaa',
              ),
              Tab(
                text: 'bbbbbb',
              ),
              Tab(
                text: 'cccc',
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            MoviesList(),
            Container(
              color: Colors.red,
              width: 100,
            ),
            Container(
              color: Colors.green,
              width: 100,
            ),
            Container(
              color: Colors.green,
              width: 100,
            ),
            Container(
              color: Colors.green,
              width: 100,
            ),
            Container(
              color: Colors.green,
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
