import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MoviesListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://siahkaiyinghome.files.wordpress.com/2018/11/the-conjuring-2-735x400.jpg?w=577&h=314',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Movie Name Movie Name',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '7.0',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    RatingBar(
                      itemSize: 8.0,
                      initialRating: 7 / 2,
                      minRating: 1.0,
                      ignoreGestures: true,
                      allowHalfRating: true,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2),
                      itemBuilder: (context, _) {
                        return Icon(
                          Icons.star,
                          color: Theme.of(context).accentColor,
                        );
                      },
                      onRatingUpdate: null,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
