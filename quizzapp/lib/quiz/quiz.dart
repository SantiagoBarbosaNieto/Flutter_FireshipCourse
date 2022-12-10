import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp/quiz/quiz_state.dart';
import 'package:quizzapp/services/firestore.dart';
import 'package:quizzapp/shared/loading.dart';
import 'package:quizzapp/shared/progress_bar.dart';

import '../services/models.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key, required this.quizId}) : super(key: key);

  final String quizId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          var state = Provider.of<QuizState>(context);
          if (!snapshot.hasData || snapshot.hasError) {
            return const Loader();
          } else {
            var quiz = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: ProgressBar(
                  value: state.progress,
                  height: 8,
                ),
                leading: IconButton(
                  icon: const Icon(FontAwesomeIcons.xmark),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (int index) =>
                    state.progress = (index / (quiz.questions.length + 1)),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    //Start page
                    return StartPage(quiz: quiz);
                  } else if (index == quiz.questions.length + 1) {
                    //End of the quiz, congrats
                    return CongratsPage(quiz: quiz);
                  } else {
                    return QuestionPage(question: quiz.questions[index - 1]);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            quiz.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          const Divider(),
          Expanded(child: Text(quiz.description)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                  onPressed: state.nextPage,
                  icon: const Icon(Icons.poll),
                  label: const Text("Start quiz!"))
            ],
          )
        ],
      ),
    );
  }
}

class CongratsPage extends StatelessWidget {
  const CongratsPage({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Congrats! You completed the ${quiz.title} quiz',
          textAlign: TextAlign.center,
        ),
        const Divider(),
        Image.asset('assets/congrats.gif'),
        const Divider(),
        ElevatedButton.icon(
          style: TextButton.styleFrom(backgroundColor: Colors.green),
          icon: const Icon(FontAwesomeIcons.check),
          label: const Text("Mark Complete!"),
          onPressed: () {
            FirestoreService().updateUserReport(quiz);
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/',
              (route) => false,
            );
          },
        )
      ]),
    );
  }
}

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key, required this.question}) : super(key: key);

  final Question question;
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.text),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((opt) {
              return Container(
                height: 90,
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.black26,
                child: InkWell(
                  onTap: () {
                    state.selected = opt;
                    _bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          state.selected == opt
                              ? FontAwesomeIcons.circleCheck
                              : FontAwesomeIcons.circle,
                          size: 30,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              opt.value,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

_bottomSheet(BuildContext context, Option opt, QuizState state) {
  bool correct = opt.correct;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 250,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(correct ? 'Good Job!' : 'Wrong'),
            Text(
              opt.detail,
              style: const TextStyle(fontSize: 18, color: Colors.white54),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: correct ? Colors.green : Colors.red),
              child: Text(
                correct ? 'Onward!' : 'Try Again',
                style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context);
                if (correct) {
                  state.nextPage();
                }
              },
            )
          ],
        ),
      );
    },
  );
}
