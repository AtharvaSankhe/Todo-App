import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/Model/task.dart';
import 'package:todo/firebase/curd.dart';

class TaskController extends GetxController {
  RxList<Task> tasks = <Task>[].obs;

  @override
  void onInit() async{
    // tasks.bindStream(Crud().getAllTask());
    tasks.value = await Crud().getAllTask() ;
    super.onInit();
  }

  addTask(title,description){
    String time = DateTime.now().toString();
    Task task = Task(taskName: title,description: description,time: time );
    tasks.add(task);
    Crud().postTask(title: title,description: description,time: time);
  }

  deleteTask(index){
    Crud().deleteTask(time: tasks[index].time);
    tasks.removeAt(index);
  }

  updateTask(index,title,description){
    tasks[index].taskName = title;
    tasks[index].description = description;
    Crud().updateTask(task: tasks[index]);
  }


  // @override
  // void onInit() {
  //   try {
  //     Hive.registerAdapter(TaskAdapter());
  //   } catch (e) {
  //     print(e);
  //   }
  //   getTask();
  //
  //   super.onInit();
  // }

  // addTask(taskName, description) {
  //   Task task = Task(taskName: taskName, description: description);
  //   tasks.add(task);
  //   print(tasks.value);
  //   var box = Hive.box('mytask');
  //   box.put('allTask', tasks.toList());
  //   print('hello bro');
  // }

  // deleteTask(index) async{
  //   tasks.removeAt(index);
  //   var box = await Hive.openBox('mytask');
  //   box.put('allTask', tasks);
  // }
  // Future getTask() async {
    // Box box;
    // try {
    //   // box = Hive.box('mytask');
    // } catch (error) {
    //   // box = await Hive.openBox('mytask');
    // }
    //
    // var tds = box.get('allTask');
    // print("TODOS $tds");
    // if (tds != null) tasks.value = tds;
  // }

  // getTask() {
  //   // print('hello bhai kya haal chal 0');
  //   // var box = Hive.box('mytask');
  //   // if(box.get('allTask')==null){
  //   //   tasks.add(Task(taskName: 'do coding', description: 'padhai kar padhai chutiye'));
  //   //   tasks.add(Task(taskName: 'do coding', description: 'padhai kar padhai chutiye'));
  //   // print('hello bhai kya haal chal 1');
  //   // }
  //   // else{
  //   //   tasks.value = box.get('allTask');
  //   // print('hello bhai kya haal chal 2');
  //   // }
  //   // print('hello bhai kya haal chal 3');
  // }
}
