import 'package:flutter/material.dart';
import 'package:movies_test/widgets/movies_list_item.dart';

class MoviesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      // height: isLandscape
      //     ? MediaQuery.of(context).size.height * 0.8 - 48
      //     : MediaQuery.of(context).size.height * 0.4 - 48,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        itemExtent: MediaQuery.of(context).size.width * 0.3,
        scrollDirection: Axis.horizontal,
        children: [
          MoviesListItem(),
          MoviesListItem(),
          MoviesListItem(),
          MoviesListItem(),
        ],
      ),
    );
  }
}
