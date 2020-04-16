import 'package:flutter/material.dart';
import './questionWidget.dart';
import './answerWidget.dart';

class quizWidget extends StatelessWidget {
  final Map<String, Object> qa;
  final Function fn;
  quizWidget({
    @required this.fn,
    @required this.qa,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        QuestionWidget(qa['QuestionText']),
        ...(qa['Answers'] as List<Map<String, Object>>).map((answer) {
          return AnswerWidget(() => fn(answer["score"]), answer["text"]);
        }).toList()
      ],
    );
  }
}
