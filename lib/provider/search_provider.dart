import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:student_db/db/functions/db_functions.dart';
import 'package:student_db/db/model/data_model.dart';

class SearchProvider with ChangeNotifier {
  final List<StudentModel> studentList = DbFuctionProvider.studentList;

  List<StudentModel> foundStudent = [];
  Future<void> getAllStudents() async {
    final students = await DbFuctionProvider().getAllStudents();
    foundStudent = students;
    // foundStudent = students;

    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    List<StudentModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = studentList;
    } else {
      results = studentList
          .where(
            (user) => user.name.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
      log('success');
    }

    foundStudent = results;
    notifyListeners();
  }
}
