import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quize/controller/question_provider.dart';
import 'package:quize/shared/colors.dart';

import '../shared/components.dart';

class ResultBody extends StatelessWidget {
  const ResultBody({
    super.key,
    required this.title,
    required this.imagePath,
    required this.result,
    required this.description,
  });

  final String title;
  final String imagePath;
  final String result;
  final String description;

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
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 30,
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10,),
                isPortrait?
                Image.asset(imagePath,)
                    :Expanded(child: Image.asset(imagePath,))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isPortrait ? 30 : 20,
                  vertical: isPortrait ? 20 : 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Score : $result',
                    style: const TextStyle(fontSize: 22, color: Colors.green,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 20,),
                  Consumer<QuestionProvider>(
                    builder: (context,model,child) {
                      return PrimaryButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: "Back to home",
                      );
                    }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
