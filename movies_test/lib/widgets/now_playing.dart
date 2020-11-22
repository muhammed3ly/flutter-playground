import 'package:flutter/material.dart';
import 'package:movies_test/helpers/dummy_data.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageIndicatorContainer(
        length: 5,
        indicatorColor: Theme.of(context).textTheme.headline6.color,
        indicatorSelectorColor: Theme.of(context).accentColor,
        indicatorSpace: 8.0,
        shape: IndicatorShape.circle(size: 5),
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.network(
                    DummyData.nowPlaying[index]['poster_url'],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(1),
                        Theme.of(context).primaryColor.withOpacity(0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.0, 0.9],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 50,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      DummyData.nowPlaying[index]['movie_name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
