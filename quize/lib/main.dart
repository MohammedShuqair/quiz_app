import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quize/controller/question_provider.dart';
import 'package:quize/screens/home_page.dart';
import 'package:quize/shared/colors.dart';

import 'controller/database/database_helper.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await DatabaseHelper().createDatabase();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) =>QuestionProvider()..createDatabase(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: AppColor.primary as MaterialColor
      ),
      home: const HomePage(),
    );
  }
}
