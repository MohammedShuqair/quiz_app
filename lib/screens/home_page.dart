import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quize/model/user.dart';
import 'package:quize/screens/start_quiz.dart';
import 'package:quize/widgets/home_drawer.dart';

import '../controller/question_provider.dart';
import '../shared/components.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Quiz app"),
      ),
      drawer: HomeDrawer(
          user: User(
        name: 'Mohammed Naser Abu Shuqair',
        id: '20192617',
        mail: 'eng.mohammed.shuqair@gmail.com',
      )),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Center(
      child: SizedBox(
        width: isPortrait ? sw * 0.8 : null,
        height: isPortrait ? null : 0.7 * sh,
        child: ListView(
          scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
          shrinkWrap: true,
          children: [
            Image.asset('images/quiz.png'),
            Consumer<QuestionProvider>(builder: (context, model, child) {
              return PrimaryButton(
                padding: EdgeInsets.symmetric(
                    horizontal: isPortrait ? 30 : 20,
                    vertical: isPortrait ? 20 : 30),
                onTap: () {
                  model.answersIndex = List.generate(
                      model.questions?.length ?? 0, (index) => null);
                  model.setShowResult(false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const StartQuiz()));
                },
                title: "Lets Start!",
              );
            }
            )
          ],
        ),
      ),
    );
  }
}
