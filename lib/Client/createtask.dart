import 'package:flutter/material.dart';


TextEditingController TaskName = TextEditingController();
TextEditingController ProjectName = TextEditingController();
TextEditingController Description = TextEditingController();
TextEditingController ClientNote = TextEditingController();

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: greyColor.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
              "Create Task",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
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
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: ProjectName,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.create_new_folder,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Project Name',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'ProjectName',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (value) {
                  if (value != null && value.length < 1) {
                    return 'This field cant be null';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: TaskName,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.task,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Task Name',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'TaskName',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (value) {
                  if (value != null && value.length < 1) {
                    return 'This field cant be null';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: Description,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.description,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Description',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (value) {
                  if (value != null && value.length < 1) {
                    return 'This field cant be null';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: ProjectName,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.link,
                    color: Colors.black,
                  ),
                  hintText: 'Project Name',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Project Name',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (value) {
                  if (value != null && value.length < 1) {
                    return 'This field cant be null';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: ClientNote,
                maxLines: 4,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.note,
                    color: Colors.black,
                  ),
                  hintText: 'Note',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Note',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (value) {
                  if (value != null && value.length < 1) {
                    return 'This field cant be null';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {}, child: Text('Create Task'))),
            ],
          ),
        ),
      ),
    );
  }
}
