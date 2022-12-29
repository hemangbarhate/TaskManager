import 'package:flutter/material.dart';

class CreateTasks extends StatefulWidget {
  const CreateTasks({Key? key}) : super(key: key);

  @override
  _CreateTasksState createState() => _CreateTasksState();
}

class _CreateTasksState extends State<CreateTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.grey[200],
        shadowColor: Colors.white,
        title: const Center(
            child: Text(
              "Create Tasks",
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.black),
            )),
        elevation: 0.0,
        leading: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
                icon: Image.asset("assets/images/bigmouth_icon.png"),
                iconSize: 70,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
          );
        }),
      ),

    );
  }
}
