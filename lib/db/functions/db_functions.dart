import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_db/db/model/data_model.dart';

class DbFuctionProvider with ChangeNotifier {
  // ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
  static List<StudentModel> studentList = [];

  Future<void> addStudent(StudentModel value) async {
    final studentDatabase = await Hive.openBox<StudentModel>('student_db');
    await studentDatabase.put(value.id, value);
    studentList.add(value);
    notifyListeners();
  }

  Future<List<StudentModel>> getAllStudents() async {
    final studentDatabase = await Hive.openBox<StudentModel>('student_db');
    studentList.clear();
    studentList.addAll(studentDatabase.values);
    return studentList;
  }

  Future<void> deleteStudent(String id) async {
    log('called db');
    final studentDatabase = await Hive.openBox<StudentModel>('student_db');
    await studentDatabase.delete(id);
    getAllStudents();
    notifyListeners();
  }

  Future<void> editList(int id, StudentModel value) async {
    final studentDatabase = await Hive.openBox<StudentModel>('student_db');
    await studentDatabase.putAt(id, value);
    getAllStudents();
    notifyListeners();
  }
}
