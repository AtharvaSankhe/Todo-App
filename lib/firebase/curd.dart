import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/Model/task.dart';

class Crud {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  createCollection(
      {required String email, required String name, String? image}) async {
    _firebaseFirestore.collection('users').doc(currentUser!.uid).set(
        {'email': email, 'name': name, 'imagePath': image});
  }


  postTask({required String title , String? description , required String time}) {
    _firebaseFirestore.collection('users').doc(currentUser!.uid).collection(
        'allTask').doc(time).set({
      'title':title , 'description':description,'isChecked': false, 'time':time
    });
  }

  Future<List<Task>> getAllTask() async{
    final snapshot = await _firebaseFirestore.collection("users").doc(currentUser!.uid).collection('allTask').get();
    final allTasks = snapshot.docs.map((e) => Task.fromSnapshot(e)).toList();
    return allTasks ;
  }

  deleteTask({required String time }) async{
    await _firebaseFirestore.collection('users').doc(currentUser!.uid).collection('allTask').doc(time).delete();
    debugPrint("Deleted Task$time");
  }

  // updateTask
  updateTask({required Task task}) async{
    await _firebaseFirestore.collection('users').doc(currentUser!.uid).collection('allTask').doc(task.time).update(task.toJson());
  }

  Future<String> getProfile() async{
    String profileUrl='' ;
    try {
      DocumentSnapshot userInfo = await _firebaseFirestore.collection("users").doc(currentUser!.uid).get();
      if (userInfo.exists) {
        //syntax to get a specific element from schemas
        Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;
        profileUrl = data['imagePath'];
      }
    } catch (e) {
      // Handle error
    }

    return profileUrl;
    // return currentUser!.photoURL! ;
  }

}