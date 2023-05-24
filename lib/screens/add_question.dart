import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quize/controller/question_provider.dart';
import 'package:quize/shared/colors.dart';

import '../shared/components.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  List<String> items = ['A', 'B', 'C', 'D'];
  late String _selectedItem;
  late AnswerField first;
  late AnswerField second;
  late AnswerField third;
  late AnswerField fourth;

  late TextEditingController questionController;

  late TextEditingController firstController;
  late TextEditingController secondController;
  late TextEditingController thirdController;
  late TextEditingController fourthController;

  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    _selectedItem = items[0];
    questionController = TextEditingController();
    firstController = TextEditingController();
    secondController = TextEditingController();
    thirdController = TextEditingController();
    fourthController = TextEditingController();

    first = AnswerField(
      onSubmitted: (String) {},
      leading: 'A',
      hint: 'First Answer',
      background: Colors.orange,
      controller: firstController,
    );
    second = AnswerField(
      onSubmitted: (String) {},
      leading: 'B',
      hint: 'Second Answer',
      background: Colors.green,
      controller: secondController,
    );
    third = AnswerField(
      onSubmitted: (String) {},
      leading: 'C',
      hint: 'Third Answer',
      background: Colors.grey,
      controller: thirdController,
    );
    fourth = AnswerField(
      textInputAction: TextInputAction.done,
      onSubmitted: (String) {},
      leading: 'D',
      hint: 'Fourth Answer',
      background: Colors.pink,
      controller: fourthController,
    );
    super.initState();
  }

  @override
  void dispose() {
    questionController.dispose();
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();

    super.dispose();
  }

  int chatToInt(String char) {
    switch (char) {
      case "A":
        {
          return 0;
        }
      case "B":
        {
          return 1;
        }
      case "C":
        {
          return 2;
        }
      case "D":
        {
          return 3;
        }
    }
    return 0;
  }

  void reset() {
    questionController.clear();
    firstController.clear();
    secondController.clear();
    thirdController.clear();
    fourthController.clear();
    _selectedItem = items[0];
    setState(() {
      // key.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add new question'),
      ),
      body: Form(
        key: key,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: CustomTextField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'question should not be empty';
                  }
                  return null;
                },
                onSubmitted: (text) {},
                hint: 'Question',
                isQuestion: true,
                controller: questionController,
              ),
            ),
            isPortrait
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      first,
                      const SizedBox(
                        height: 10,
                      ),
                      second,
                      const SizedBox(
                        height: 10,
                      ),
                      third,
                      const SizedBox(
                        height: 10,
                      ),
                      fourth,
                    ],
                  )
                : GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 80),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      first,
                      second,
                      third,
                      fourth,
                    ],
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Select the correct answer',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: DropdownButton(
                      isExpanded: true,
                      value: _selectedItem,
                      items: items
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(color: Colors.cyan),
                                ),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedItem = newValue ?? '';
                        });
                      }),
                )
              ],
            ),
            PrimaryButton(
              padding: const EdgeInsets.only(top: 30),
              onTap: () async {
                if (key.currentState != null && key.currentState!.validate()) {
                  await Provider.of<QuestionProvider>(context, listen: false)
                      .insertToDataBase(
                    title: questionController.text,
                    first: firstController.text,
                    second: secondController.text,
                    third: thirdController.text,
                    fourth: fourthController.text,
                    correct: chatToInt(_selectedItem),
                  );
                  reset();
                }
              },
              title: "Add question",
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerField extends StatelessWidget {
  const AnswerField({
    super.key,
    required this.onSubmitted,
    required this.leading,
    required this.hint,
    required this.background,
    required this.controller,
    this.textInputAction,
  });

  final Function(String)? onSubmitted;
  final String leading;
  final String hint;
  final Color background;
  final TextEditingController controller;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: background,
          child: Text(
            leading,
            style: const TextStyle(color: AppColor.background, fontSize: 22),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: CustomTextField(
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'answer should not be  empty';
              }
              return null;
            },
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            hint: hint,
            controller: controller,
          ),
        )
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onSubmitted,
    required this.hint,
    this.isQuestion,
    required this.controller,
    this.validator,
    this.textInputAction,
  });

  final Function(String)? onSubmitted;
  final String hint;
  final bool? isQuestion;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: validator,
      maxLines: null,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: isQuestion ?? false
              ? const Icon(
                  Icons.question_mark,
                )
              : null),
    );
  }
}
