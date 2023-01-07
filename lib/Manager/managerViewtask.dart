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
import 'package:intership/Manager/timedatamnager.dart';
import 'package:intership/Operator/timedata.dart';
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
    // getAssignTask();
    // gerInProgressTask();
    // getCompleteTask();
    getclient();
    gettasklist();
    super.initState();
  }

  List<ClientModel> clientlist = [];
  var mapClientIdName = Map<String, dynamic>();
  getclient() async {
    ////>>>>>>>>>>>>>>>>>> client name  & id
    clientlist = await getClientdata();
    for (ClientModel i in clientlist) {
      mapClientIdName['${i.clientId}'] = '${i.name}';
      // print('${i.clientId} == ${i.name}');
    }
  }

  //??????????????????????????????? client id
  List<TaskModel> noassignedtasklist = [];
  Future<List<TaskModel>> getNOtAssignTask() async {
    noassignedtasklist.clear();
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

  List<TaskModel> finallist = [];
  List<TaskModel> assignedlist = [];
  List<TaskModel> acceptRejectList = [];
  List<TaskModel> clientApprovalPendingList = [];
  List<TaskModel> closedTasksList = [];

  Future<List<TaskModel>> gettasklist() async {
    finallist.clear();
    assignedlist.clear();
    acceptRejectList.clear();
    clientApprovalPendingList.clear();
    closedTasksList.clear();
    setState(() {
      loadingsecond = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response =
        await _session.get('http://164.92.83.169/manager/getTasks');
    print(response);

    for (dynamic i in response['result']) {
      finallist.add(TaskModel.fromJson(i));

      if ((TaskModel.fromJson(i).AssignationStatus == 'Assigned' ||
              TaskModel.fromJson(i).AssignationStatus == 'Reassigned') &&
          (TaskModel.fromJson(i).taskStatus == 'inProgress') &&
          (TaskModel.fromJson(i).managerApproval == 'Pending' ||
              TaskModel.fromJson(i).managerApproval == 'Rejected') &&
          (TaskModel.fromJson(i).clientApproval == 'Pending' ||
              TaskModel.fromJson(i).clientApproval == 'Rejected')) {
        assignedlist.add(TaskModel.fromJson(i));
      }
      if ((TaskModel.fromJson(i).managerApproval == 'Pending' ||
              TaskModel.fromJson(i).managerApproval == 'Rejected') &&
          (TaskModel.fromJson(i).clientApproval == 'Pending' ||
              TaskModel.fromJson(i).clientApproval == 'Rejected') &&
          TaskModel.fromJson(i).taskStatus == 'Completed') {
        acceptRejectList.add(TaskModel.fromJson(i));
      }
      if (TaskModel.fromJson(i).managerApproval == 'Accepted' &&
          (TaskModel.fromJson(i).clientApproval == 'Pending' ||
              TaskModel.fromJson(i).clientApproval == 'Rejected') &&
          TaskModel.fromJson(i).taskStatus == 'Completed') {
        clientApprovalPendingList.add(TaskModel.fromJson(i));
      }
      if (TaskModel.fromJson(i).taskStatus == 'Closed' &&
          TaskModel.fromJson(i).managerApproval == 'Accepted' &&
          TaskModel.fromJson(i).clientApproval == 'Accepted') {
        closedTasksList.add(TaskModel.fromJson(i));
      }
    }
    loadingsecond = false;
    print('cccccccccc');
    print(closedTasksList.length);
    setState(() {});
    return finallist;
  }
  // List<TaskModel> assignedtasklist = [];
  // Future<List<TaskModel>> getAssignTask() async {
  //   // print("// Assigned Tasks");
  //   setState(() {
  //     loadingsecond = true; //make loading true to show progressindicator
  //   });
  //   Session _session = Session();
  //   final response =
  //       await _session.get('http://164.92.83.169/manager/assignedTask');
  //   // print(response);
  //
  //   for (dynamic i in response['result']) {
  //     // print(i);
  //     assignedtasklist.add(TaskModel.fromJson(i));
  //   }
  //   // print(assignedtasklist[0]);
  //
  //   setState(() {
  //     loadingsecond = false;
  //   });
  //   return assignedtasklist;
  // }

  // List<TaskModel> inprogresstask = [];
  // int dowehavedata = 0;
  // Future<List<TaskModel>> gerInProgressTask() async {
  //   // print("// InProgressAssigned Tasks");
  //   setState(() {
  //     loadingthird = true; //make loading true to show progressindicator
  //   });
  //   Session _session = Session();
  //   final response =
  //       await _session.get('http://164.92.83.169/manager/inProgressTask');
  //   // print(response);
  //
  //   for (dynamic i in response['result']) {
  //     // print(i);
  //     inprogresstask.add(TaskModel.fromJson(i));
  //     if ('${TaskModel.fromJson(i).managerApproval}' == 'Completed' &&
  //         '${TaskModel.fromJson(i).clientApproval}' == 'Pending') {
  //       dowehavedata++;
  //     }
  //   }
  //   // print(inprogresstask[0]);
  //   loadingthird = false;
  //   setState(() {});
  //   return inprogresstask;
  // }
  //
  // List<TaskModel> completetask = [];
  // Future<List<TaskModel>> getCompleteTask() async {
  //   // print("// Complete Tasks");
  //   setState(() {
  //     loadingfour = true; //make loading true to show progressindicator
  //   });
  //   Session _session = Session();
  //   final response =
  //       await _session.get('http://164.92.83.169/manager/completedTask');
  //   // print("response $response");
  //
  //   for (dynamic i in response['result']) {
  //     // print("i" + i);
  //     completetask.add(TaskModel.fromJson(i));
  //   }
  //   // if(completetask.length >= 1) print(completetask[0]);
  //   loadingfour = false;
  //   setState(() {});
  //   return completetask;
  // }

  Future<dynamic> RejectRequest(String taskid) async {
    try {
      setState(() {
        loadingfour = true; //make loading true to show progressindicator
      });
      Session _session = Session();
      final data =
          jsonEncode(<String, String>{"Note": "Task Rejected by manager"});
      final response =
          await _session.post('http://$ip/manager/rejectTask/${taskid}', data);
      print(response.toString());
      print('Rejected');

      await getNOtAssignTask();
      await gettasklist();

      setState(() {
        loadingfour = false; //make loading true to show progressindicator
      });
      return response;
    } catch (e) {
      setState(() {
        loadingfour = false; //make loading true to show progressindicator
      });
      print(e.toString());
    }
  }

  Future<dynamic> ApproveRequest(String taskid) async {
    try {
      setState(() {
        loadingfour = true; //make loading true to show progressindicator
      });
      Session _session = Session();
      final data = jsonEncode(<String, String>{"Note": "Task Completed."});
      final response =
          await _session.post('http://$ip/manager/approveTask/${taskid}', data);
      print(response.toString());
      print('Accepted ${taskid}');

      await getNOtAssignTask();
      await gettasklist();

      setState(() {
        loadingfour = false; //make loading true to show progressindicator
      });
      return response;
    } catch (e) {
      await getNOtAssignTask();
      await gettasklist();

      setState(() {
        loadingfour = false; //make loading true to show progressindicator
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // getNOtAssignTask();
    return DefaultTabController(
      length: 5,
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
                  isScrollable: true,
                  indicator: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Not Assigned',
                    ),
                    Tab(
                      text: 'Assigned',
                    ),
                    Tab(
                      text: 'Accept/Reject',
                    ),
                    Tab(
                      text: 'Client Approval Pending',
                    ),
                    Tab(
                      text: 'Closed Tasks',
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
                                child: Text("there is no task "),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                await getNOtAssignTask();
                                await gettasklist();
                              },
                              child: SingleChildScrollView(
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
                                                child: noassignedtasklist[index]
                                                            .AssignationStatus ==
                                                        'Pending'
                                                    ? Container(
                                                        child: ClientContainer(
                                                          Approve: () {},
                                                          Reject: () {},
                                                          who: 'manager',
                                                          fontColor: greyColor,
                                                          backgrondColor:
                                                              greenColor,
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
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AssignTask(
                                                                    taskId:
                                                                        '${noassignedtasklist[index].taskID}',
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          TimeLineDoc: () {},
                                                          AttachDoc: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TimeDataMnager(
                                                                  Taskid:
                                                                      '${noassignedtasklist[index].taskID}',
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          ChangeStatus: () {},
                                                        ),
                                                      )
                                                    : Container(),
                                              );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  loadingsecond
                      ? Center(child: CircularProgressIndicator())
                      : assignedlist.length == 0
                          ? Container(
                              child: Center(
                                child: Text("No data"),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                await getNOtAssignTask();
                                await gettasklist();
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: assignedlist.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: (Container(
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
                                                    '${assignedlist[index].taskName}',
                                                ProjectName:
                                                    '${assignedlist[index].ProjectName}',
                                                taskId:
                                                    '${assignedlist[index].taskID}',
                                                clientId:
                                                    // '${assignedtasklist[index].clientId}',
                                                    '${mapClientIdName[assignedlist[index].clientId]}',
                                                operatorId:
                                                    '${assignedlist[index].operatorId}',
                                                openDate:
                                                    '${assignedlist[index].openDate?.substring(0, 10)}',
                                                taskDescription:
                                                    '${assignedlist[index].taskDescription}',
                                                closeDate:
                                                    '${assignedlist[index].closeDate?.substring(0, 10)}',
                                                clientNote:
                                                    '${assignedlist[index].clientNote}',
                                                managerNote:
                                                    '${assignedlist[index].managerNote}',
                                                AssignationStatus:
                                                    '${assignedlist[index].AssignationStatus}',
                                                priority:
                                                    '${assignedlist[index].priority}',
                                                clientApproval:
                                                    '${assignedlist[index].clientApproval}',
                                                taskStatus:
                                                    '${assignedlist[index].taskStatus}',
                                                managerApproval:
                                                    '${assignedlist[index].managerApproval}',
                                                taskCategory:
                                                    '${assignedlist[index].taskCategory}',
                                                managerId:
                                                    '${assignedlist[index].managerId}',
                                                assignTask: () {
                                                  if (assignedlist[index]
                                                          .taskStatus ==
                                                      'Pending') {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AssignTask(
                                                          taskId:
                                                              '${assignedlist[index].taskID}',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                who: 'manager',
                                                TimeLineDoc: () {},
                                                AttachDoc: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TimeDataMnager(
                                                        Taskid:
                                                            '${assignedlist[index].taskID}',
                                                      ),
                                                    ),
                                                  );
                                                },
                                                ChangeStatus: () {},
                                                Approve: () {},
                                                Reject: () {},
                                              ),
                                            )));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  loadingsecond
                      ? Center(child: CircularProgressIndicator())
                      : acceptRejectList.length == 0
                          ? Center(
                              child: Text("No data"),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                await getNOtAssignTask();
                                await gettasklist();
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: acceptRejectList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: (Container(
                                              child: ClientContainer(
                                                TimeLineDoc: () {},
                                                AttachDoc: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TimeDataMnager(
                                                        Taskid:
                                                            '${acceptRejectList[index].taskID}',
                                                      ),
                                                    ),
                                                  );
                                                },
                                                ChangeStatus: () {},
                                                Approve: () async {
                                                  print("Aprrove");

                                                  await ApproveRequest(
                                                      '${acceptRejectList[index].taskID}');
                                                },
                                                Reject: () async {
                                                  print("Reject");
                                                  print(
                                                    '${acceptRejectList[index].taskStatus}',
                                                  );
                                                  await RejectRequest(
                                                      '${acceptRejectList[index].taskID}');
                                                },
                                                who: 'manager',
                                                fontColor: greyColor,
                                                backgrondColor: yellowColor,
                                                first: greyColor,
                                                second: greenColor,
                                                third: greenColor,
                                                forth: redColor,
                                                fifth: redColor,
                                                sixth: greyColor,
                                                taskName:
                                                    '${acceptRejectList[index].taskName}',
                                                ProjectName:
                                                    '${acceptRejectList[index].ProjectName}',
                                                taskId:
                                                    '${acceptRejectList[index].taskID}',
                                                clientId:
                                                    '${mapClientIdName[acceptRejectList[index].clientId]}',
                                                operatorId:
                                                    '${acceptRejectList[index].operatorId}',
                                                openDate:
                                                    '${acceptRejectList[index].openDate?.substring(0, 10)}',
                                                taskDescription:
                                                    '${acceptRejectList[index].taskDescription}',
                                                closeDate:
                                                    '${acceptRejectList[index].closeDate?.substring(0, 10)}',
                                                clientNote:
                                                    '${acceptRejectList[index].clientNote}',
                                                managerNote:
                                                    '${acceptRejectList[index].managerNote}',
                                                AssignationStatus:
                                                    '${acceptRejectList[index].AssignationStatus}',
                                                priority:
                                                    '${acceptRejectList[index].priority}',
                                                clientApproval:
                                                    '${acceptRejectList[index].clientApproval}',
                                                taskStatus:
                                                    '${acceptRejectList[index].taskStatus}',
                                                managerApproval:
                                                    '${acceptRejectList[index].managerApproval}',
                                                taskCategory:
                                                    '${acceptRejectList[index].taskCategory}',
                                                managerId:
                                                    '${acceptRejectList[index].managerId}',
                                                assignTask: () {
                                                  if (acceptRejectList[index]
                                                          .taskStatus ==
                                                      'Pending') {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AssignTask(
                                                          taskId:
                                                              '${acceptRejectList[index].taskID}',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            )));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  loadingsecond
                      ? Center(child: CircularProgressIndicator())
                      : clientApprovalPendingList.length == 0
                          ? Center(
                              child: Container(
                                child: Text('no data'),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                await getNOtAssignTask();
                                await gettasklist();
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          clientApprovalPendingList.length,
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
                                                '${clientApprovalPendingList[index].taskName}',
                                            ProjectName:
                                                '${clientApprovalPendingList[index].ProjectName}',
                                            taskId:
                                                '${clientApprovalPendingList[index].taskID}',
                                            clientId:
                                                '${mapClientIdName[clientApprovalPendingList[index].clientId]}',
                                            // '${inprogresstask[index].clientId}',
                                            operatorId:
                                                '${clientApprovalPendingList[index].operatorId}',
                                            openDate:
                                                '${clientApprovalPendingList[index].openDate?.substring(0, 10)}',
                                            taskDescription:
                                                '${clientApprovalPendingList[index].taskDescription}',
                                            closeDate:
                                                '${clientApprovalPendingList[index].closeDate?.substring(0, 10)}',
                                            clientNote:
                                                '${clientApprovalPendingList[index].clientNote}',
                                            managerNote:
                                                '${clientApprovalPendingList[index].managerNote}',
                                            AssignationStatus:
                                                '${clientApprovalPendingList[index].AssignationStatus}',
                                            priority:
                                                '${clientApprovalPendingList[index].priority}',
                                            clientApproval:
                                                '${clientApprovalPendingList[index].clientApproval}',
                                            taskStatus:
                                                '${clientApprovalPendingList[index].taskStatus}',
                                            managerApproval:
                                                '${clientApprovalPendingList[index].managerApproval}',
                                            taskCategory:
                                                '${clientApprovalPendingList[index].taskCategory}',
                                            managerId:
                                                '${clientApprovalPendingList[index].managerId}',
                                            TimeLineDoc: () {},
                                            AttachDoc: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TimeDataMnager(
                                                    Taskid:
                                                        '${clientApprovalPendingList[index].taskID}',
                                                  ),
                                                ),
                                              );
                                            },
                                            ChangeStatus: () {},
                                            assignTask: () {
                                              if (clientApprovalPendingList[
                                                          index]
                                                      .taskStatus ==
                                                  'Pending') {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AssignTask(
                                                      taskId:
                                                          '${clientApprovalPendingList[index].taskID}',
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            Approve: () {},
                                            Reject: () {},
                                          )),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  loadingsecond
                      ? Center(child: CircularProgressIndicator())
                      : closedTasksList.length == 0
                          ? Center(
                              child: Container(
                                child: Text('no data'),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                await getNOtAssignTask();
                                await gettasklist();
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: closedTasksList.length,
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
                                                '${closedTasksList[index].taskName}',
                                            ProjectName:
                                                '${closedTasksList[index].ProjectName}',
                                            taskId:
                                                '${closedTasksList[index].taskID}',
                                            clientId:
                                                '${mapClientIdName[closedTasksList[index].clientId]}',
                                            // '${inprogresstask[index].clientId}',
                                            operatorId:
                                                '${closedTasksList[index].operatorId}',
                                            openDate:
                                                '${closedTasksList[index].openDate?.substring(0, 10)}',
                                            taskDescription:
                                                '${closedTasksList[index].taskDescription}',
                                            closeDate:
                                                '${closedTasksList[index].closeDate?.substring(0, 10)}',
                                            clientNote:
                                                '${closedTasksList[index].clientNote}',
                                            managerNote:
                                                '${closedTasksList[index].managerNote}',
                                            AssignationStatus:
                                                '${closedTasksList[index].AssignationStatus}',
                                            priority:
                                                '${closedTasksList[index].priority}',
                                            clientApproval:
                                                '${closedTasksList[index].clientApproval}',
                                            taskStatus:
                                                '${closedTasksList[index].taskStatus}',
                                            managerApproval:
                                                '${closedTasksList[index].managerApproval}',
                                            taskCategory:
                                                '${closedTasksList[index].taskCategory}',
                                            managerId:
                                                '${closedTasksList[index].managerId}',
                                            TimeLineDoc: () {},
                                            AttachDoc: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TimeDataMnager(
                                                    Taskid:
                                                        '${closedTasksList[index].taskID}',
                                                  ),
                                                ),
                                              );
                                            },
                                            ChangeStatus: () {},
                                            assignTask: () {
                                              if (closedTasksList[index]
                                                      .taskStatus ==
                                                  'Pending') {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AssignTask(
                                                      taskId:
                                                          '${closedTasksList[index].taskID}',
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            Approve: () {},
                                            Reject: () {},
                                          )),
                                        );
                                      },
                                    ),
                                  ],
                                ),
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
