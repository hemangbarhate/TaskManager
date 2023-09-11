import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intership/Admin/model/projectnamemodel.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/Manager/ApiCall/clientData.dart';
import 'package:intership/Manager/managerHome.dart';
import 'package:intership/Manager/model/clientmodel.dart';
import 'package:intl/intl.dart';
import '../constant/ApI.dart';
import '../constant/color.dart';

TextEditingController TaskName = TextEditingController();
TextEditingController Projectidcontroller = TextEditingController();
TextEditingController Description = TextEditingController();
TextEditingController ClientNote = TextEditingController();
TextEditingController opendate = TextEditingController();
TextEditingController closedate = TextEditingController();

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  // "ProjectName" : "Project Name 1",
  // "clientId" : "3c3646b1-9a69-4da2-b5f7-e80628543c60",
  // "taskName" : "Task 2",
  // "taskDescription" : "Task Description more.",
  // "openDate" : "2022-10-10",
  // "closeDate" : "2023-10-10",
  // "clientNote" : "Task Created."
  bool loading = false;
  int select = 1;
  int selectnew = 0;
  Future<dynamic> createTask(String ProjectName, clientId, taskName,
      taskDescription, openDate, closeDate, clientNote) async {
    try {
      Session _session = Session();
      final data = jsonEncode(<String, String>{
        "projectId": ProjectName,
        "clientId": clientId,
        "taskName": taskName,
        "taskDescription": taskDescription,
        "openDate": openDate,
        "closeDate": closeDate,
        "clientNote": clientNote
      });
      final response = await _session.post('$ip/manager/createTask', data);
      log(response.toString());
      log('qwerty ${response.toString()}');
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  List<ClientModel> clientlist = [];
  getclient() async {
    ////>>>>>>>>>>>>>>>>>> client name  & id
    setState(() {
      loading = true;
    });
    clientlist = await getClientdata();
    log('${clientlist.length}');
    setState(() {
      loading = false;
    });
  }

  List<ProjectName> activeProject = [];
  Future<List<ProjectName>> getactiveProjectName() async {
    activeProject.clear();

    Session _session = Session();
    final response = await _session.get('$ip/manager/getProjects');
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
  void initState() {
    getclient();
    getactiveProjectName();
    super.initState();
  }

  TextEditingController TaskName = TextEditingController();
  TextEditingController Projectidcontroller = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController ClientNote = TextEditingController();
  TextEditingController opendate = TextEditingController();
  TextEditingController closedate = TextEditingController();
  String clientId = "not";

  @override
  final _formKey = GlobalKey<FormState>();
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
                  // height: 10,
                  ),
              Container(
                child: const Text(""
                    "Select Client"),
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
                          scrollbarOrientation: ScrollbarOrientation.left,
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: clientlist.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      select = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: select == index
                                            ? Colors.grey.withOpacity(0.6)
                                            : whiteColor.withOpacity(1),
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                                    '$ip/manager/getClientProfilePic/${clientlist[index].clientId}',
                                                  ),
                                                ),
                                          title:
                                              Text("${clientlist[index].name}"),
                                          subtitle: Text(
                                              "${clientlist[index].email}"),
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
              SizedBox(
                height: 25,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: TaskName,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.task,
                    color: Colors.black,
                  ),
                  hintText: 'Enter task name',
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
              // TextFormField(
              //   style: TextStyle(color: Colors.black),
              //   controller: ProjectName,
              //   decoration: const InputDecoration(
              //     icon: Icon(
              //       Icons.work,
              //       color: Colors.black,
              //     ),
              //     hintText: 'Enter project name',
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
                                      selectnew = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: selectnew == index
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
                controller: ClientNote,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.description,
                    color: Colors.black,
                  ),
                  hintText: 'Add Client note',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Client note',
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
                maxLines: 4,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.description,
                    color: Colors.black,
                  ),
                  hintText: 'Task Description',
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
                height: 25,
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
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        final isValidForm = _formKey.currentState!.validate();
                        if (isValidForm) {
                          print("client name  : ${clientlist[select].name}");
                          createTask(
                              activeProject[selectnew].projectId,
                              clientlist[select].clientId,
                              TaskName.text,
                              Description.text,
                              opendate.text,
                              closedate.text,
                              ClientNote.text);
                          // ProjectName, clientId, taskName,
                          // taskDescription, openDate, closeDate, clientNote)
                          final snackBar = SnackBar(
                            content: Text("Please Refresh the page "),
                            backgroundColor: (Colors.black12),
                            action: SnackBarAction(
                              label: 'dismiss',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Projectidcontroller.clear();
                          select = 1;
                          TaskName.clear();
                          Description.clear();
                          opendate.clear();
                          closedate.clear();
                          ClientNote.clear();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const home_manager(),
                              ),
                              (route) => false);
                          // setState(() {});
                        } else {
                          print(clientId);
                          final snackBar = SnackBar(
                            content: Text("Please select client name"),
                            backgroundColor: (Colors.black12),
                            action: SnackBarAction(
                              label: 'dismiss',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('Create Task'))),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
