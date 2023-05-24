import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quize/controller/question_provider.dart';
import 'package:quize/model/question.dart';
import 'package:quize/shared/colors.dart';
import 'package:quize/shared/components.dart';
import 'package:quize/widgets/result_body.dart';

import '../widgets/less_five.dart';

class StartQuiz extends StatefulWidget {
  const StartQuiz({
    Key? key,
  }) : super(key: key);

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz App'),
      ),
      body: Consumer<QuestionProvider>(
        builder: (context, model, child) {
          List<Question>? questions = model.questions;
          if (questions == null || questions.length < 5) {
            return const LessFive();
          } else if (model.showResult) {
            int score = model.calculateGrade().round();
            if (score >= 75) {
              return ResultBody(
                title: 'Congratulations!',
                imagePath: 'images/result.jpg',
                result: '${score ~/ 10} / 10',
                description: 'You are superstar!',
              );
            } else if (score >= 50) {
              return ResultBody(
                title: 'Congratulations!',
                imagePath: 'images/result.jpg',
                result: '${score ~/ 10} / 10',
                description: 'Keep up the good work!',
              );
            } else {
              return ResultBody(
                title: 'Oops!',
                imagePath: 'images/fail.png',
                result: '${score ~/ 10} / 10',
                description: 'Sorry, better luck next time!',
              );
            }
          } else {
            return PageView.builder(
              controller: _controller,
              itemCount: questions.length,
              itemBuilder: (BuildContext context, int qIndex) {
                Question q = questions[qIndex];
                return Center(
                  child: ListView(
                    primary: true,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: [
                      HeaderWidget(
                        qIndex: qIndex,
                        questionCount: questions.length,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      QuestionTitle(q: q),
                      AnswerList(
                        controller: _controller,
                        model: model,
                        qIndex: qIndex,
                        answers: q.answers,
                        isLast: qIndex == questions.length - 1,
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.qIndex,
    required this.questionCount,
  });

  final int questionCount;
  final int qIndex;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Question ${qIndex + 1} ',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: AppColor.primary),
          children: [
            TextSpan(
              text: '/ $questionCount',
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColor.icon,
                  fontWeight: FontWeight.w400),
            )
          ]),
    );
  }
}

class QuestionTitle extends StatelessWidget {
  const QuestionTitle({
    super.key,
    required this.q,
  });

  final Question q;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        q.title,
        style: const TextStyle(
          fontSize: 22,
          color: AppColor.background,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AnswerList extends StatelessWidget {
  const AnswerList({
    super.key,
    required this.model,
    required this.qIndex,
    required this.answers,
    required this.controller,
    required this.isLast,
  });

  final QuestionProvider model;
  final int qIndex;
  final List<String> answers;
  final PageController controller;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: answers.length,
      itemBuilder: (_, index) {
        String answer = answers[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: InkWell(
            splashColor: AppColor.primary.withOpacity(0.2),
            onTap: () {
              model.setAnswer(qIndex, index);
              isLast
                  ? model.setShowResult(true)
                  : controller.animateToPage(qIndex + 1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut);
            },
            child: AnswerItem(
              answer: answer,
              isSelected: model.answersIndex[qIndex] == index,
            ),
          ),
        );
      },
    );
  }
}

class AnswerItem extends StatelessWidget {
  const AnswerItem({
    super.key,
    required this.answer,
    required this.isSelected,
  });

  final String answer;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: isSelected ?? false ? AppColor.primary.withOpacity(0.3) : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.primary)),
      child: Text(
        answer,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
