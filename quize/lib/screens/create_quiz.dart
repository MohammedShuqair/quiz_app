import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quize/model/question.dart';
import 'package:quize/screens/add_question.dart';
import 'package:quize/shared/colors.dart';

import '../controller/database/database_helper.dart';
import '../controller/question_provider.dart';
import '../shared/components.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
   List<Question>? questions;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait=MediaQuery.of(context).orientation==Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Quiz'),
      ),
      body: Consumer<QuestionProvider>(

        builder:(context,model,child){

          questions=model.questions;
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            shrinkWrap: true,
            children: [
              PrimaryButton(
                padding: const EdgeInsets.symmetric(vertical: 20),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddQuestion()));
                },
                title: "+  Add new question",
              ),
              isPortrait?
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  Question q = questions![index];
                  return QuestionCard(
                    deleteQuestion: () {
                      showAlertDialog(context,q.id);
                    },
                    title: q.title,
                    answers: q.answers,
                    correctIndex: q.correctIndex,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                  height: 10,
                ),
                itemCount: questions?.length??0,
              ):GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  Question q = questions![index];
                  return QuestionCard(
                    deleteQuestion: () {
                      showAlertDialog(context,q.id);
                    },
                    title: q.title,
                    answers: q.answers,
                    correctIndex: q.correctIndex,
                  );
                },
                itemCount: questions?.length??0,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,

                ) ,
              )
            ],
          );
        } ,
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.deleteQuestion,
    required this.title,
    required this.answers,
    required this.correctIndex,
  });

  final VoidCallback deleteQuestion;
  final String title;
  final List<String> answers;
  final int correctIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.lightBackground),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    title,
                    style: const TextStyle(fontSize: 22),
                  )),
                  IconButton(
                    onPressed: deleteQuestion,
                    icon: const Icon(
                      Icons.delete,
                      color: AppColor.icon,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return AnswerWidget(
                    answer: answers[index],
                    isCorrect: index == correctIndex,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                  height: 10,
                ),
                itemCount: answers.length,
              )
            ],
          )
        ],
      ),
    );
  }
}

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({
    super.key,
    required this.answer,
    required this.isCorrect,
  });

  final String answer;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    Color background = isCorrect ? AppColor.correct : AppColor.background;
    Color textColor = isCorrect ? AppColor.background : AppColor.darkBackground;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(15.0)),
      child: Text(
        answer,
        style: TextStyle(color: textColor, fontSize: 20),
      ),
    );
  }
}
