import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

// import 'package:hive_flutter/adapters.dart';
import 'package:todo/controller/taskController.dart';
import 'package:todo/firebase/curd.dart';
import 'package:todo/firebase/emailauth.dart';
import 'package:todo/screens/verification/otp.dart';
import 'package:todo/utilities/constants.dart';
import 'package:todo/widgets/taskadder.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskController taskController = Get.put(TaskController());

  // final _box = Hive.box('mytask');

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.kbgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // taskController.tasks.bindStream(Crud().getAllTask());
          Get.bottomSheet(TaskAdder(),
              backgroundColor: Colors.transparent, elevation: 10);
        },
        backgroundColor: Constants.ktileColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Constants.ktileColor,
        centerTitle: true,
        elevation: 0,
        title: const Text('TO DO'),
        actions: [
          IconButton(
            onPressed: () {
              Auth().signOut();
              // Get.to(()=>const OTP());
            },
            icon: Icon(
              Icons.logout,
              size: 20,
              color: Constants.kbgColor,
            ),
          )
        ],
        leading: GestureDetector(
          onTap: () {},
          child: Obx(
            ()=> CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              child: taskController.profileUrl.value == null || taskController.profileUrl.value == ''
                  ? const Image(
                      image: AssetImage(
                        'assets/login/profile.png',
                      ),
                      height: 40,
                      width: 40,
                    )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                        image: NetworkImage(
                          taskController.profileUrl.value
                        ),
                        height: 40,
                        width: 40,
                        filterQuality: FilterQuality.low,
                      ),
                  ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => Container(
            height: height,
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 15,
              ),
              itemCount: taskController.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          // taskController.deleteTask(index);
                          Get.bottomSheet(
                              TaskAdder(
                                add: false,
                                index: index,
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 10);
                        },
                        icon: Icons.edit,
                        backgroundColor: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(10),
                      )
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          taskController.deleteTask(index);
                        },
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      )
                    ],
                  ),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: taskController.tasks[index].isChecked
                          ? Constants.ktileColor.withOpacity(0.75)
                          : Constants.ktileColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: taskController.tasks[index].isChecked,
                            activeColor: Constants.kbgColor,
                            fillColor:
                                MaterialStateProperty.all(Constants.kbgColor),
                            checkColor: Constants.ktileColor,
                            onChanged: (bool? value) {
                              setState(() {
                                taskController.tasks[index].isChecked = value!;
                                Crud().updateTask(
                                    task: taskController.tasks[index]);
                              });
                            }),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width * 0.50,
                              child: Text(
                                taskController.tasks[index].taskName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.kbgColor,
                                  decoration:
                                      taskController.tasks[index].isChecked
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.50,
                              child: Text(
                                taskController.tasks[index].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Constants.kbgColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
