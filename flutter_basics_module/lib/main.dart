import 'package:flutter/material.dart';
import './resultWidget.dart';
import './quizWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      "QuestionText": "what's your favourite color?",
      "Answers": [
        {
          "text": "Red",
          "score": 3,
        },
        {
          "text": "Green",
          "score": 5,
        },
        {
          "text": "Black",
          "score": 10,
        },
        {
          "text": "Blue",
          "score": 10,
        },
      ]
    },
    {
      "QuestionText": "what's your favourite animal?",
      "Answers": [
        {
          "text": "Tiger",
          "score": 7,
        },
        {
          "text": "Lion",
          "score": 10,
        },
        {
          "text": "Dog",
          "score": 3,
        },
      ]
    },
  ];
  var _questionIndex = 0, _score = 0;

  void _answerQuestion(int s) {
    _score += s;
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: (_questionIndex < _questions.length)
            ? quizWidget(fn: _answerQuestion, qa: _questions[_questionIndex])
            : resultWidget(_score, _resetQuiz),
      ),
    );
  }
}
