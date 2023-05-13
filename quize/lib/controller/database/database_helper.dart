import 'package:quize/model/question.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance=DatabaseHelper._();
  DatabaseHelper._();
  factory DatabaseHelper(){
    return _instance;
  }
  Database? database;
  Future<void> createDatabase() async{
   await openDatabase(
      //المتغير داتابيز ينشأ بقيمة فارغة وتظرا لأنه قبل الأويت فأنه ينشأ قبل أي متغير بعده
      'todonew2.db',
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
     await openDatabase('todonew2.db');
      print('database is null');
    }
    await database!.transaction((txn) async {
      await txn
          .rawInsert(
          'INSERT INTO questions(title, first, second, third,fourth,correct) VALUES("$title","$first","$second","$third","$fourth","$correct")')
          .catchError((onError) {
        print('Error in inserting New Record ${onError.toString()}');
      });
    });
  }
  Future<List<Question>> getDataFromDatabase() async {
    //هيك الالميثود تعتي هترجع البيانات على شكل لستة من نوع ماب
    if(database!=null){
      List<Map<String,dynamic>> temp=await database!.rawQuery('SELECT * FROM questions');
      List<Question> questions=temp.map((e) => Question.fromMap(e)).toList();
      return questions ;
    }else{
      return [];
    }

  }
}