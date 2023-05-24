import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quize/controller/question_provider.dart';
import 'package:quize/screens/start_quiz.dart';
import 'package:quize/shared/colors.dart';

import '../model/user.dart';
import '../screens/create_quiz.dart';

class HomeDrawer extends StatelessWidget {
  final User user;

  const HomeDrawer({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 25,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 30,
                backgroundColor: AppColor.background,
                child: Text(
                  user.name[0],
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              accountName: Text(
                user.name,
              ),
              accountEmail: Text(
                user.mail,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Create Quiz'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CreateQuiz()));
              },
            ),
            Consumer<QuestionProvider>(builder: (context, model, child) {
              return ListTile(
                leading: Icon(Icons.quiz),
                title: Text('Start Quiz'),
                onTap: () {
                  model.answersIndex = List.generate(
                      model.questions?.length ?? 0, (index) => null);
                  model.setShowResult(false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const StartQuiz()));
                },
              );
            }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app_outlined),
              title: const Text('Exit'),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
