import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intership/Client/home_client.dart';
import 'package:intership/Client/viewclienttask.dart';
import 'package:intership/constant/ApI.dart';
import 'package:intl/intl.dart';

import '../Admin/model/projectnamemodel.dart';
import '../Admin/model/projectnamemodel.dart';
import '../Admin/model/session.dart';
import '../constant/color.dart';

TextEditingController opendate = TextEditingController();
TextEditingController closedate = TextEditingController();

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  bool loading = false;
  int select = 0;
  TextEditingController TaskName = TextEditingController();
  TextEditingController Projectidcontroller = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController ClientNote = TextEditingController();
  @override
  void initState() {
    opendate.text = ""; //set the initial value of text field
    closedate.text = "";
    getactiveProjectName();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Future<dynamic> createTask(String projectname, taskname, taskdesc, opendate,
      closedate, clientnote) async {
    try {
      Session _session = Session();
      final data = jsonEncode(<String, String>{
        "projectId": projectname,
        "taskName": taskname,
        "taskDescription": taskdesc,
        "openDate": opendate,
        "closeDate": closedate,
        "clientNote": clientnote
      });
      final response = await _session.post(createtask, data);
      print(response.toString());
      print('task create funcn successfully');
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  List<ProjectName> activeProject = [];
  Future<List<ProjectName>> getactiveProjectName() async {
    activeProject.clear();

    Session _session = Session();
    final response = await _session.get('$ip/client/getProjects');
    print(response);

    for (dynamic i in response['data']) {
      activeProject.add(ProjectName.fromJson(i));
    }
    setState(() {
      activeProject;
    });
    return activeProject;
  }

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
              // TextFormField(
              //   style: TextStyle(color: Colors.black),
              //   controller: ProjectName,
              //   decoration: const InputDecoration(
              //     icon: Icon(
              //       Icons.create_new_folder,
              //       color: Colors.black,
              //     ),
              //     hintText: 'Enter Project Name',
              //     hintStyle: TextStyle(color: Colors.black),
              //     labelText: 'ProjectName',
              //     labelStyle: TextStyle(color: Colors.black),
              //     border: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black)),
              //   ),
              //   validator: (value) {
              //     if (value != null && value.length < 1) {
              //       return 'This field cant be null';
              //     }
              //     return null;
              //   },
              // ),
              Container(
                child: Text(""
                    "Select ProjectName"),
              ),
              const SizedBox(
                height: 10,
              ),
              loading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: blueColor.withOpacity(0.6),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Scrollbar(
                          // scrollController != null,
                          isAlwaysShown: true, //always show scrollbar
                          thickness: 10, //width of scrollbar
                          radius:
                              Radius.circular(20), //corner radius of scrollbar
                          scrollbarOrientation: ScrollbarOrientation.right,
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              // controller: ScrollController(),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: activeProject.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      select = index;
                                      Projectidcontroller.text =
                                          activeProject[index].projectId;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: select == index
                                            ? Colors.grey.withOpacity(0.6)
                                            : whiteColor.withOpacity(1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        // height: 50,

                                        child: ListTile(
                                          leading: false
                                              ? Image.asset(
                                                  "assets/images/download.png")
                                              : CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    '$ip/client/getProjectIcon/${activeProject[index].projectId}',
                                                  ),
                                                ),
                                          title: Text(
                                              "${activeProject[index].projectName}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
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
                maxLines: 3,
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
                controller: ClientNote,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.note,
                    color: Colors.black,
                  ),
                  hintText: 'Urgent/Medium/Low',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Note',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (value) {
                  if (value != null && value.length < 3) {
                    return 'Enter Low/Medium/Urgent';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: opendate,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  hintText: 'Start Date',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'OpenDate',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      opendate.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
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
                controller: closedate,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  hintText: 'Completion Date',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'CloseDate',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      closedate.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
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
                      onPressed: () async {
                        final isValidForm = _formKey.currentState!.validate();
                        if (isValidForm) {
                          var response = await createTask(
                                  Projectidcontroller.text.toString(),
                                  TaskName.text.toString(),
                                  Description.text.toString(),
                                  opendate.text.toString(),
                                  closedate.text.toString(),
                                  ClientNote.text.toString())
                              .catchError((err) {});
                          if (response["success"] == true) {
                            setState(() {
                              opendate.text = "";
                              closedate.text = "";
                              Projectidcontroller.text = "";
                              Description.text = "";
                              ClientNote.text = "";
                              Projectidcontroller.text = '';
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const home_client()));
                            });
                            final snackBar = SnackBar(
                              content: Text(response['data']),
                              backgroundColor: (Colors.black12),
                              action: SnackBarAction(
                                label: 'dismiss',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          } else {
                            return;
                          }
                        }
                      },
                      child: Text('Create Task'))),
            ],
          ),
        ),
      ),
    );
  }
}
