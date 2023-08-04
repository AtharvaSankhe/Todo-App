import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// part 'task.g.dart';

// @HiveType(typeId: 1)
class Task {
  // @HiveField(0)
  String taskName;

  // @HiveField(1)
  String description;

  // @HiveField(2)
  bool isChecked;

  // @HiveField(3)
  final String time ;

  Task(
      {required this.taskName,
      required this.description,
      this.isChecked = false,
         required this.time
      });

  toJson() {
    return {
      "title": taskName,
      "description": description,
      "isChecked": isChecked,
    };
  }

  factory Task.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    final data = document.data()!;
    return Task(taskName: data['title'], description: data["description"], isChecked: data["isChecked"], time: data["time"]);
  }
}
