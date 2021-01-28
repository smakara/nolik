import 'package:flutter/foundation.dart';
import 'package:nolik/models/dog.dart';
import 'package:nolik/models/toy.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

import 'package:nolik/models/student.dart';




class MyDatabase {










 static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    final directory = await getDatabasesPath();
    String path = join(directory, "student.db");

    //deleteDatabase(path);

    return await openDatabase(
      path,
      version: 2,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        debugPrint('Database OnUpgrade');
      },

      onCreate: (Database db, int version) async {
        debugPrint('Database OnCreate');
        await db
            .execute('CREATE TABLE student (id INTEGER PRIMARY KEY, username TEXT,name TEXT,surname TEXT,password TEXT,mark INTEGER,quiz TEXT)');
      },
    );
  }
  Future<void> insertDog(Dog dog) async {
    final db = await database;
    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'dog',
      dog.toMap(),
    );
  }

  Future<void> add(Student student) async {
    var dbClient = await database;
    await dbClient.insert('student', student.toMap());
    ;
  }


 Future<int> login (String username, String password) async {
   final db = await database;
   List<Map> maps=await db.query(
      'student' ,
       where: "username = ? AND password = ?",
       whereArgs: [username, password],
       limit: 1
   );

   return maps.length ;
 }


 Future<void> deleteDog(int id) async {
   final db = await database;
   await db.delete(
     'dog',
     where: "id = ?",
     whereArgs: [id],
   );
 }

  Future<List<Student>> getStudents() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query('student');
    List<Student> students = [];
    if (maps.length > 0) {


      return List.generate(maps.length, (i) {
        return Student(
          // this.id,
          // this.username,
          // this.name,
          // this.surname,
          // this.password,
          // this.mark,
          // this.quiz

          id : maps[i]['id'],
            username : maps[i]['username'],
            name : maps[i]['name'],
        surname : maps[i]['surname'],
        password : maps[i]['password'],
        mark : maps[i]['mark'],
        quiz : maps[i]['quiz'],

        );
      });





    }
    return students;
  }

 Future<List<Dog>> dogs() async {
   final db = await database;

   //get dogs and join onto toys table
   final List<Map<String, dynamic>> dogMaps = await db.query('dog');
   //get all toys
   final List<Map<String, dynamic>> toyMaps = await db.query('toy');
   //generate list of toys to use in our dog list
   final toyList = List.generate(toyMaps.length, (i) {
     return Toy(
       id: toyMaps[i]['id'],
       toyType: toyMaps[i]['toytype'],
       dogId: toyMaps[i]['dogid'],
     );
   });
   //return list of dogs with their associated toys
   return List.generate(dogMaps.length, (i) {
     return Dog(
       id: dogMaps[i]['id'],
       name: dogMaps[i]['name'],
       age: dogMaps[i]['age'],
       toys: toyList.where((toy) => toy.dogId == dogMaps[i]['id']).toList(),
     );
   });
 }

  Future<int> delete(int id) async {
    var dbClient = await database;
    return await dbClient.delete(
      'student',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Student student) async {
    var dbClient = await database;
    return await dbClient.update(
      'student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

 Future<int> updateQuiz(Student student) async {
   var dbClient = await database;
   return await dbClient.update(
     'student',
     student.toMap(),

   );





 }

  Future close() async {
    var dbClient = await database;
    dbClient.close();
  }






  Future<void> updateDog(Dog dog) async {
    final db = await database;
    await db.update(
      'dog',
      dog.toMap(),
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> insertToy(Toy toy, Dog dog) async {
    debugPrint(toy.toString());

    final db = await database;

    await db.insert(
      'toy',
      {
        'id': toy.id,
        'toytype': toy.toyType,
        'dogid': toy.dogId,
      },
    );
  }



  Future<void> cleanDatabase() async {
   try{
     final db = await database;
     await db.transaction((txn) async {
       var batch = txn.batch();
       batch.delete('student');

       await batch.commit();
     });
   } catch(error){
     throw Exception('DbBase.cleanDatabase: ' + error.toString());
   }
 }
}
