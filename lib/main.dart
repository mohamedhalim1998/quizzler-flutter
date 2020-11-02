import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';
import 'package:quizzler/question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuestionBank questionBank = QuestionBank();
  List<Widget> answers = [];

  void addRightAnswer() {
    answers.add(Icon(Icons.check, color: Colors.green));
  }

  void addWrongAnswer() {
    answers.add(Icon(Icons.close, color: Colors.red));
  }

  void showAlert() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Finished",
      desc: "The quiz has finished",
      buttons: [
        DialogButton(
          child: Text(
            "Again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (questionBank.getQuestionAnswer()) {
                    addRightAnswer();
                  } else {
                    addWrongAnswer();
                  }
                  if (!questionBank.moveToNext()) {
                    questionBank.reset();
                    answers = [];
                    showAlert();
                  }

                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (!questionBank.getQuestionAnswer()) {
                    addRightAnswer();
                  } else {
                    addWrongAnswer();
                  }
                  if (!questionBank.moveToNext()) {
                    questionBank.reset();
                    answers = [];
                    showAlert();

                    return;
                  }
                });
              },
            ),
          ),
        ),
        Row(
          children: answers,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
