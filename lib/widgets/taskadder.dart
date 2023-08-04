import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/taskController.dart';
import 'package:todo/utilities/constants.dart';

class TaskAdder extends StatefulWidget {
  bool add ;
  int index;
  TaskAdder({Key? key,this.add=true,this.index=0}) : super(key: key);

  @override
  State<TaskAdder> createState() => _TaskAdderState();
}

class _TaskAdderState extends State<TaskAdder> {
  TaskController taskController = Get.find();
  TextEditingController tasknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    if(!widget.add){
      tasknameController.text = taskController.tasks[widget.index].taskName;
      descriptionController.text = taskController.tasks[widget.index].description;
    }

    super.initState();
  }

  @override
  void dispose() {
    tasknameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Constants.kbgColor,
      ),
      child: Column(
          children: [
            TextField(
              controller: tasknameController,
              onChanged: (value){
                setState(() {
                });
              },
              decoration: InputDecoration(
                  hintText: 'Enter Task ',
                  labelText: 'Enter Task',
                  suffixIcon: tasknameController.text.isNotEmpty ? IconButton(
                    icon: Icon(
                      Icons.clear, color: Constants.ktileColor, size: 15,),
                    onPressed: (){
                      tasknameController.clear();
                    },
                  ):null ,
              ),

            ),
            TextField(
              controller: descriptionController,
              onChanged: (value){
                setState(() {

                });
              },
              decoration: InputDecoration(
                  hintText: 'Enter task description',
                  labelText: 'Enter task description',
                suffixIcon: descriptionController.text.isNotEmpty ? IconButton(
                  icon: Icon(
                    Icons.clear, color: Constants.ktileColor, size: 15,),
                  onPressed: (){
                    descriptionController.clear();
                  },
                ):null ,
              ),
            ),
            const SizedBox(height: 25,),
            GestureDetector(
              onTap: () {
                if(widget.add){
                taskController.addTask(tasknameController.text, descriptionController.text);
                }else{
                  taskController.updateTask(widget.index, tasknameController.text, descriptionController.text);
                }

                Get.back();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Constants.ktileColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(widget.add?"ADD TASK":"UPDATE TASK",
                  style: TextStyle(color: Constants.kbgColor),),
              ),
            )


          ],
        ),
    );
  }
}
