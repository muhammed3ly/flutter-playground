import 'package:flutter/material.dart';

class resultWidget extends StatelessWidget {
  final int score;
  final Function fn;
  resultWidget(this.score, this.fn);

  String get resultPhrase {
    var resultText = "You did it!";
    if (score <= 8) {
      resultText = "You are awesome and innocent!";
    } else if (score <= 13) {
      resultText = "Pretty likeable!";
    } else {
      resultText = "You are PERFECT!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          FlatButton(
            child: Text(
              "Restart Quiz",
            ),
            textColor: Colors.blue,
            onPressed: fn,
          )
        ],
      ),
    );
  }
}
