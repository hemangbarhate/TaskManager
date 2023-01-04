import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intership/Manager/ApiCall/clientData.dart';
import 'package:intership/Manager/ConatainerHelper/ManagerContainer.dart';
import 'package:intership/Manager/assignTask.dart';
import 'package:intership/Manager/createTask.dart';
import 'package:intership/Manager/managerProfile.dart';
import 'package:intership/Manager/model/TASKMODEL.dart';
import 'package:intership/Manager/model/clientmodel.dart';
import 'package:intership/constant/color.dart';
import 'package:intership/Manager/ConatainerHelper/ClientContainer.dart';
import 'package:intership/Admin/model/session.dart';

import '../constant/ApI.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  bool loadingofirst = false;
  bool loadingsecond = false;
  bool loadingthird = false;
  bool loadingfour = false;
  @override
  void initState() {
    getNOtAssignTask();
    getAssignTask();
    gerInProgressTask();
    getCompleteTask();
    getclient();
    super.initState();
  }

  List<ClientModel> clientlist = [];
  var mapClientIdName = Map<String, dynamic>();
  getclient() async {
    ////>>>>>>>>>>>>>>>>>> client name  & id
    clientlist = await getClientdata();
    for (ClientModel i in clientlist) {
      mapClientIdName['${i.clientId}'] = '${i.name}';
      print('${i.clientId} == ${i.name}');
    }
  }

  //??????????????????????????????? client id
  List<TaskModel> noassignedtasklist = [];
  Future<List<TaskModel>> getNOtAssignTask() async {
    setState(() {
      loadingofirst = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response =
        await _session.get('http://164.92.83.169/manager/notassignedTask');
    // print(response);

    for (dynamic i in response['result']) {
      // print(i);
      noassignedtasklist.add(TaskModel.fromJson(i));
    }
    // print(noassignedtasklist[0]);
    loadingofirst = false;
    setState(() {});
    return noassignedtasklist;
  }

  List<TaskModel> assignedtasklist = [];
  Future<List<TaskModel>> getAssignTask() async {
    // print("// Assigned Tasks");
    setState(() {
      loadingsecond = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response =
        await _session.get('http://164.92.83.169/manager/assignedTask');
    // print(response);

    for (dynamic i in response['result']) {
      // print(i);
      assignedtasklist.add(TaskModel.fromJson(i));
    }
    // print(assignedtasklist[0]);

    setState(() {
      loadingsecond = false;
    });
    return assignedtasklist;
  }

  List<TaskModel> inprogresstask = [];
  Future<List<TaskModel>> gerInProgressTask() async {
    // print("// InProgressAssigned Tasks");
    setState(() {
      loadingthird = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response =
        await _session.get('http://164.92.83.169/manager/inProgressTask');
    // print(response);

    for (dynamic i in response['result']) {
      // print(i);
      inprogresstask.add(TaskModel.fromJson(i));
    }
    // print(inprogresstask[0]);
    loadingthird = false;
    setState(() {});
    return inprogresstask;
  }

  List<TaskModel> completetask = [];
  Future<List<TaskModel>> getCompleteTask() async {
    // print("// Complete Tasks");
    setState(() {
      loadingfour = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response =
        await _session.get('http://164.92.83.169/manager/completedTask');
    // print("response $response");

    for (dynamic i in response['result']) {
      // print("i" + i);
      completetask.add(TaskModel.fromJson(i));
    }
    // if(completetask.length >= 1) print(completetask[0]);
    loadingfour = false;
    setState(() {});
    return completetask;
  }

  @override
  Widget build(BuildContext context) {
    // getNOtAssignTask();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title: const Center(
            child: Text(
              "Tasks",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: IconButton(
                  icon: Image.asset("assets/images/bigmouth_icon.png"),
                  iconSize: 70,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              );
            },
            // assets/images/
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Container(
                  height: 25,
                  child: CircleAvatar(
                      child: Image.asset("assets/images/download.png")),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width - 2,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Reque..',
                    ),
                    Tab(
                      text: 'Assig..',
                    ),
                    Tab(
                      text: 'InProg..',
                    ),
                    Tab(
                      text: 'Compl..',
                    )
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  loadingofirst
                      ? Center(child: CircularProgressIndicator())
                      : noassignedtasklist.length == 0
                          ? Container(
                              child: Center(
                                child: Text("No data"),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: noassignedtasklist.length,
                                    itemBuilder: (context, index) {
                                      return noassignedtasklist[index]
                                                  .priority ==
                                              'null'
                                          ? Container()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: ClientContainer(
                                                  who: 'manager',
                                                  fontColor: greyColor,
                                                  backgrondColor: greenColor,
                                                  first: yellowColor,
                                                  second: blackColor,
                                                  third: greenColor,
                                                  forth: redColor,
                                                  fifth: redColor,
                                                  sixth: yellowColor,
                                                  taskName:
                                                      '${noassignedtasklist[index].taskName}',
                                                  ProjectName:
                                                      '${noassignedtasklist[index].ProjectName}',
                                                  taskId:
                                                      '${noassignedtasklist[index].taskID}',
                                                  clientId:
                                                      // '${noassignedtasklist[index].clientId}',
                                                      '${mapClientIdName[noassignedtasklist[index].clientId]}',
                                                  operatorId: '',
                                                  openDate:
                                                      '${noassignedtasklist[index].openDate?.substring(0, 10)}',
                                                  taskDescription:
                                                      '${noassignedtasklist[index].taskDescription}',
                                                  closeDate:
                                                      '${noassignedtasklist[index].closeDate?.substring(0, 10)}',
                                                  clientNote:
                                                      '${noassignedtasklist[index].clientNote}',
                                                  managerNote: '',
                                                  AssignationStatus: '',
                                                  priority: '',
                                                  clientApproval: '',
                                                  taskStatus:
                                                      '${noassignedtasklist[index].taskStatus}',
                                                  managerApproval: '',
                                                  taskCategory: '',
                                                  managerId: '',
                                                  assignTask: () {
                                                    if (noassignedtasklist[
                                                                index]
                                                            .taskStatus ==
                                                        'Pending') {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AssignTask(
                                                            taskId:
                                                                '${noassignedtasklist[index].taskID}',
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }, TimeLineDoc: () {  }, AttachDoc: () {  },ChangeStatus: () {  },
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ),
                  loadingsecond
                      ? Center(child: CircularProgressIndicator())
                      : assignedtasklist.length == 0
                          ? Container(
                              child: Center(
                                child: Text("No data"),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: assignedtasklist.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: ClientContainer(
                                            fontColor: greyColor,
                                            backgrondColor: orangeColor,
                                            first: greyColor,
                                            second: greenColor,
                                            third: greenColor,
                                            forth: redColor,
                                            fifth: redColor,
                                            sixth: greyColor,
                                            taskName:
                                                '${assignedtasklist[index].taskName}',
                                            ProjectName:
                                                '${assignedtasklist[index].ProjectName}',
                                            taskId:
                                                '${assignedtasklist[index].taskID}',
                                            clientId:
                                                // '${assignedtasklist[index].clientId}',
                                                '${mapClientIdName[assignedtasklist[index].clientId]}',
                                            operatorId:
                                                '${assignedtasklist[index].operatorId}',
                                            openDate:
                                                '${assignedtasklist[index].openDate?.substring(0, 10)}',
                                            taskDescription:
                                                '${assignedtasklist[index].taskDescription}',
                                            closeDate:
                                                '${assignedtasklist[index].closeDate?.substring(0, 10)}',
                                            clientNote:
                                                '${assignedtasklist[index].clientNote}',
                                            managerNote:
                                                '${assignedtasklist[index].managerNote}',
                                            AssignationStatus:
                                                '${assignedtasklist[index].AssignationStatus}',
                                            priority:
                                                '${assignedtasklist[index].priority}',
                                            clientApproval:
                                                '${assignedtasklist[index].clientApproval}',
                                            taskStatus:
                                                '${assignedtasklist[index].taskStatus}',
                                            managerApproval:
                                                '${assignedtasklist[index].managerApproval}',
                                            taskCategory:
                                                '${assignedtasklist[index].taskCategory}',
                                            managerId:
                                                '${assignedtasklist[index].managerId}',
                                            assignTask: () {
                                              if (assignedtasklist[index]
                                                      .taskStatus ==
                                                  'Pending') {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AssignTask(
                                                      taskId:
                                                          '${assignedtasklist[index].taskID}',
                                                    ),
                                                  ),
                                                );
                                              }
                                            }, who: 'manager', TimeLineDoc: () {  }, AttachDoc: () {  },ChangeStatus: () {  },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                  loadingthird
                      ? Center(child: CircularProgressIndicator())
                      : inprogresstask.length == 0
                          ? Container(
                              child: Center(
                                child: Text("No data"),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: inprogresstask.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: ClientContainer(
                                            who: 'manager',
                                            fontColor: yellowColor,
                                            backgrondColor: blueColor,
                                            first: greyColor,
                                            second: greenColor,
                                            third: greenColor,
                                            forth: redColor,
                                            fifth: redColor,
                                            sixth: greyColor,
                                            taskName:
                                                '${inprogresstask[index].taskName}',
                                            ProjectName:
                                                '${inprogresstask[index].ProjectName}',
                                            taskId:
                                                '${inprogresstask[index].taskID}',
                                            clientId:
                                                '${mapClientIdName[inprogresstask[index].clientId]}',
                                            // '${inprogresstask[index].clientId}',
                                            operatorId:
                                                '${inprogresstask[index].operatorId}',
                                            openDate:
                                                '${inprogresstask[index].openDate?.substring(0, 10)}',
                                            taskDescription:
                                                '${inprogresstask[index].taskDescription}',
                                            closeDate:
                                                '${inprogresstask[index].closeDate?.substring(0, 10)}',
                                            clientNote:
                                                '${inprogresstask[index].clientNote}',
                                            managerNote:
                                                '${inprogresstask[index].managerNote}',
                                            AssignationStatus:
                                                '${inprogresstask[index].AssignationStatus}',
                                            priority:
                                                '${inprogresstask[index].priority}',
                                            clientApproval:
                                                '${inprogresstask[index].clientApproval}',
                                            taskStatus:
                                                '${inprogresstask[index].taskStatus}',
                                            managerApproval:
                                                '${inprogresstask[index].managerApproval}',
                                            taskCategory:
                                                '${inprogresstask[index].taskCategory}',
                                            managerId:
                                                '${inprogresstask[index].managerId}',
                                            TimeLineDoc: () {  }, AttachDoc: () {  },ChangeStatus: () {  },
                                            assignTask: () {
                                              if (inprogresstask[index]
                                                      .taskStatus ==
                                                  'Pending') {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AssignTask(
                                                      taskId:
                                                          '${inprogresstask[index].taskID}',
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                  loadingfour
                      ? Center(child: CircularProgressIndicator())
                      : completetask.length == 0
                          ? Container(
                              child: Center(
                                child: Text("No data"),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: completetask.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: ClientContainer(
                                            TimeLineDoc: () {  }, AttachDoc: () {  },ChangeStatus: () {  },
                                            who: 'manager',
                                            fontColor: yellowColor,
                                            backgrondColor: blueColor,
                                            first: greyColor,
                                            second: greenColor,
                                            third: greenColor,
                                            forth: redColor,
                                            fifth: redColor,
                                            sixth: greyColor,
                                            taskName:
                                                '${completetask[index].taskName}',
                                            ProjectName:
                                                '${completetask[index].ProjectName}',
                                            taskId:
                                                '${completetask[index].taskID}',
                                            clientId:
                                                '${mapClientIdName[completetask[index].clientId]}',
                                            // '${completetask[index].clientId}',
                                            operatorId:
                                                '${completetask[index].operatorId}',
                                            openDate:
                                                '${completetask[index].openDate?.substring(0, 10)}',
                                            taskDescription:
                                                '${completetask[index].taskDescription}',
                                            closeDate:
                                                '${completetask[index].closeDate?.substring(0, 10)}',
                                            clientNote:
                                                '${completetask[index].clientNote}',
                                            managerNote:
                                                '${completetask[index].managerNote}',
                                            AssignationStatus:
                                                '${completetask[index].AssignationStatus}',
                                            priority:
                                                '${completetask[index].priority}',
                                            clientApproval:
                                                '${completetask[index].clientApproval}',
                                            taskStatus:
                                                '${completetask[index].taskStatus}',
                                            managerApproval:
                                                '${completetask[index].managerApproval}',
                                            taskCategory:
                                                '${completetask[index].taskCategory}',
                                            managerId:
                                                '${completetask[index].managerId}',
                                            assignTask: () {
                                              if (completetask[index]
                                                      .taskStatus ==
                                                  'Pending') {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AssignTask(
                                                      taskId:
                                                          '${completetask[index].taskID}',
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                ],
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // foregroundColor: Colors.blueAccent,
          backgroundColor: yellowColor.withOpacity(0.9),
          onPressed: () {
            // getData().then((response) {
            //     if (response['success']) {
            //       print("The request was successful. Do something with the data here");
            //       print(response);
            //     } else {
            //       print("// There was an error. Display the error message to the user.");
            //       print(response['error']);
            //     }
            //
            // });

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CreateTask()));
          },
          child: Icon(
            Icons.add,
            color: greyColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
