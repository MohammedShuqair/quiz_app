import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../model/question.dart';

class QuestionProvider extends ChangeNotifier{
  Database? database;
  List<Question>? questions=[];
  List<int?> answersIndex=[];
  bool showResult=false;
  void setShowResult(bool value){
    showResult=value;
    notifyListeners();
  }
  void setAnswerIndex(List<int?> list){
    answersIndex=list;
  }

  double calculateGrade() {
    if (questions == null || questions!.isEmpty || answersIndex.isEmpty) {
      return 0.0;
    }

    int totalQuestions = questions?.length??0;
    int totalCorrect = 0;

    for (int i = 0; i < totalQuestions; i++) {
      Question question = questions![i];
      int? userAnswer = answersIndex[i];

      if (userAnswer != null && userAnswer == question.correctIndex) {
        totalCorrect++;
      }
    }

    return (totalCorrect / totalQuestions) * 100.0;
  }
  void setAnswer(int index,int value){
    answersIndex[index]=value;
    notifyListeners();
  }
  Future<void> createDatabase() async{
    await openDatabase(
      //المتغير داتابيز ينشأ بقيمة فارغة وتظرا لأنه قبل الأويت فأنه ينشأ قبل أي متغير بعده
        'quiz.db',
        version: 1,
        onCreate: (database, version) {
          //id integer
          //title String
          //answer1 String
          //answer2 String
          //answer3 String
          //answer4 String
          //correct int

          print('Database Created');

          database
              .execute(
              'CREATE TABLE questions ( id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, first TEXT, second TEXT, third TEXT, fourth TEXT, correct INTEGER )')
              .then((value) {
            print('Table Created');
          }).catchError((onError) {
            print('Error in creation${onError.toString()}');
          });
        },
        onOpen: (database){
          this.database=database;
          getDataFromDatabase();
        }
    );
  }
  Future<void> insertToDataBase({
    required String title,
    required String first,
    required String second,
    required String third,
    required String fourth,
    required int correct,

  }) async{
    if(database==null){
      // database =await openDatabase('path');
    }else {
      await database!.transaction((txn) async {
      await txn
          .rawInsert(
          'INSERT INTO questions(title, first, second, third,fourth,correct) VALUES("$title","$first","$second","$third","$fourth","$correct")')
          .catchError((onError) {
        print('Error in inserting New Record ${onError.toString()}');
      });
      getDataFromDatabase();
    });
    }
  }

  deleteFromDatabase(int id)async{
   await database?.rawDelete('DELETE FROM questions WHERE id=$id');
   getDataFromDatabase();
  }
  Future<void> getDataFromDatabase() async {
    // database ??= await openDatabase('path');

      List<Map<String,dynamic>> temp=await database!.rawQuery('SELECT * FROM questions');
      questions=temp.map((e) => Question.fromMap(e)).toList();
      notifyListeners();
  }
  @override
  void dispose() {
    answersIndex=[];
    super.dispose();
  }
}