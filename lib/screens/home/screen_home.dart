import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_db/provider/search_provider.dart';
import 'package:student_db/screens/home/widgets/add_student.dart';
import 'package:student_db/screens/home/widgets/list_student.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchProvider>(context, listen: false).getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Student Database',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            backgroundColor: Colors.green,
            label: const Text('Add new Student'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddStudent(),
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Consumer(
            builder:
                (BuildContext context, SearchProvider value, Widget? child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          )),
                      onChanged: (value) =>
                          Provider.of<SearchProvider>(context, listen: false)
                              .runFilter(value),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListStudent(
                      controller: searchController,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
