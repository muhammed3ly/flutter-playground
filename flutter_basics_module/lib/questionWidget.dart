import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String _questiontext;

  QuestionWidget(this._questiontext);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(_questiontext, 
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
