import 'dart:convert';
import 'dart:io';
import 'dart:developer';
// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/Manager/ApiCall/clientData.dart';
import 'package:intership/Manager/ConatainerHelper/ManagerContainer.dart';
import 'package:intership/Manager/managerProfile.dart';
import 'package:intership/Manager/model/TASKMODEL.dart';
import 'package:intership/Manager/model/clientmodel.dart';
import 'package:intership/Operator/ContainerHelper/AssignedContainer.dart';
import 'package:intership/Operator/ContainerHelper/ReassignedContainer.dart';
import 'package:intership/Operator/attachdata.dart';
import 'package:intership/Operator/operatorHome.dart';
import 'package:intership/Operator/operatorProfile.dart';
import 'package:intership/Operator/timedata.dart';
import 'package:intership/constant/ApI.dart';
import 'package:intership/constant/color.dart';
import 'package:intership/Manager/ConatainerHelper/ClientContainer.dart';

class OperatorVIewTasks extends StatefulWidget {
  const OperatorVIewTasks({Key? key}) : super(key: key);

  @override
  _OperatorVIewTasksState createState() => _OperatorVIewTasksState();
}

class _OperatorVIewTasksState extends State<OperatorVIewTasks> {
  bool loading = false;
  List<TaskModel> assignedtask = [];

  List<ClientModel> clientlist = [];
  var mapClientIdName = Map<String, dynamic>();
  getclient() async {
    ////>>>>>>>>>>>>>>>>>> client name  & id
    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    clientlist = await getClientdata();
    for (ClientModel i in clientlist) {
      mapClientIdName['${i.clientId}'] = '${i.name}';
      loading = false;
      setState(() {});
      // print('${i.clientId} == ${i.name}');
    }
  }

  List<TaskModel> assignedtask1 = [];
  List<TaskModel> managerApprovalPending = [];
  List<TaskModel> clientApprovalPending = [];
  List<TaskModel> closedTask = [];

  var mapMangerName = Map<String, dynamic>();
  getManagerName(String s) async {
    Session _session = Session();
    final response = await _session.get('http://$ip/operator/getManager/$s');
    // print("Response $response");
    mapMangerName[s] = response['manager']['name'];
  }
  var mapClientName = Map<String, dynamic>();
  getClientName(String s) async {
    Session _session = Session();
    final response = await _session.get('http://$ip/operator/getClient/$s');
    print("Response $response");
    mapClientName[s] = response['client']['name'];
  }

  Future<List<TaskModel>> gerInProgressTask() async {
    assignedtask.clear();
    managerApprovalPending.clear();
    clientApprovalPending.clear();
    closedTask.clear();

    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response = await _session.get(operatortaskByOperatorId);
    // print(response);
    for (dynamic i in response['result']) {
      // if (TaskModel.fromJson(i).taskStatus == 'inProgress') {
      //   //   print(i);
      //   assignedtask.add(TaskModel.fromJson(i));
      // }
      assignedtask.add(TaskModel.fromJson(i));
      if ((TaskModel.fromJson(i).AssignationStatus == 'Assigned' ||
              TaskModel.fromJson(i).AssignationStatus == 'Reassigned') &&
          TaskModel.fromJson(i).taskStatus == 'inProgress' &&
          (TaskModel.fromJson(i).managerApproval == 'Pending' ||
              TaskModel.fromJson(i).managerApproval == 'Rejected') &&
          (TaskModel.fromJson(i).clientApproval == 'Pending' ||
              TaskModel.fromJson(i).clientApproval == 'Rejected')) {
        assignedtask1.add(TaskModel.fromJson(i));
        await getManagerName("${TaskModel.fromJson(i).managerId}");
        await getClientName("${TaskModel.fromJson(i).clientId}");
      }
      if (TaskModel.fromJson(i).taskStatus == 'Completed' &&
          (TaskModel.fromJson(i).managerApproval == 'Pending' ||
              TaskModel.fromJson(i).managerApproval == 'Rejected') &&
          (TaskModel.fromJson(i).clientApproval == 'Pending' ||
              TaskModel.fromJson(i).clientApproval == 'Rejected')) {
        managerApprovalPending.add(TaskModel.fromJson(i));
        await getManagerName("${TaskModel.fromJson(i).managerId}");
        await getClientName("${TaskModel.fromJson(i).clientId}");
      }
      if (TaskModel.fromJson(i).taskStatus == 'Completed' &&
          TaskModel.fromJson(i).managerApproval == 'Accepted' &&
          (TaskModel.fromJson(i).clientApproval == 'Pending' ||
              TaskModel.fromJson(i).clientApproval == 'Rejected')) {
        clientApprovalPending.add(TaskModel.fromJson(i));
        await getManagerName("${TaskModel.fromJson(i).managerId}");
        await getClientName("${TaskModel.fromJson(i).clientId}");
      }
      if (TaskModel.fromJson(i).taskStatus == 'Closed' &&
          TaskModel.fromJson(i).managerApproval == 'Accepted' &&
          TaskModel.fromJson(i).clientApproval == 'Accepted') {
        closedTask.add(TaskModel.fromJson(i));
        await  getManagerName("${TaskModel.fromJson(i).managerId}");
        await getClientName("${TaskModel.fromJson(i).clientId}");
      }
    }
    // print('aaaaaa');
    // print(assignedtask.length);
    // for (var i in assignedtask) {
    //   print("${i.taskDescription} == ${i.taskStatus}");
    // }
    loading = false;
    setState(() {});
    return assignedtask;
  }

  Future<dynamic> UpdateStatus(String taskid) async {
    try {
      setState(() {
        loading = true; //make loading true to show progressindicator
      });

      Session _session = Session();
      final data = jsonEncode(<String, String>{'name': taskid});
      final response = await _session.post(
          'http://$ip/operator/changeTaskStatus/${taskid}', data);
      print(response.toString());
      print('status updated successfully');
      loading = false;

      await gerInProgressTask();

      setState(() {});
      return response;
    } catch (e) {
      print(e.toString());
    }
    loading = false;
    setState(() {
      //make loading true to show progressindicator
    });
  }

  // http://164.92.83.169/operator/getTimeline/1a19cd55-bc76-420f-b506-d078c248bd79
  @override
  void initState() {
    gerInProgressTask();
    // getclient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // gerInProgressTask();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: greyColor.withOpacity(0.1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title: const Center(
              child: Text(
            "Tasks",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          )),
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
                    // Assigned Task
                    // Waiting for Manager Approval
                    // Waiting for Client Approval
                    // Closed Task
                    Tab(
                      text: 'Assigned Tasks',
                    ),
                    Tab(
                      text: 'Manager Approval Pending',
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
                  RefreshIndicator(
                    onRefresh: () async {
                      await gerInProgressTask();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          loading
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 80.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SpinKitDoubleBounce(
                                          color: blackColor.withOpacity(1),
                                          size: 50.0,
                                        ),
                                        Text("Loading....")
                                      ],
                                    ),
                                  ),
                                )
                              : assignedtask1.isEmpty
                                  ? Container(
                                      height: 100,
                                      child: const Center(
                                        child:
                                            Text("Tasks aren't Assigned yet"),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: assignedtask1.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: OpeartorContainer(
                                                    clientName: '${mapClientName[assignedtask1[index].clientId]}',
                                                    managerName: '${mapMangerName[assignedtask1[index].managerId]}',
                                                    Approve: () {},
                                                    Reject: () {},
                                                    TimeLineDoc: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TimeData(
                                                            Taskid:
                                                                '${assignedtask1[index].taskID}',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    AttachDoc: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AttachData(
                                                            Taskid:
                                                                '${assignedtask1[index].taskID}',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    ChangeStatus: () {
                                                      // print('object');

                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                "Really ?"),
                                                            content: const Text(
                                                                "Are sure about completed task ?"),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "No"),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  UpdateStatus(
                                                                    '${assignedtask1[index].taskID}',
                                                                  );

                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const home_operator()));
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "Yes"),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    who: 'operator1',
                                                    fontColor: greyColor,
                                                    backgrondColor: greenColor,
                                                    first: yellowColor,
                                                    second: blackColor,
                                                    third: greyColor,
                                                    forth: redColor,
                                                    fifth: redColor,
                                                    sixth: yellowColor,
                                                    taskName:
                                                        '${assignedtask1[index].taskName}',
                                                    ProjectName:
                                                        '${assignedtask1[index].ProjectName}',
                                                    taskId:
                                                        '${assignedtask1[index].taskID}',
                                                    clientId:
                                                        '${assignedtask1[index].clientId}',
                                                    // '${mapClientIdName[assignedtask[index].clientId]}',
                                                    operatorId: '',
                                                    openDate:
                                                        '${assignedtask1[index].openDate?.substring(0, 10)}',
                                                    taskDescription:
                                                        '${assignedtask1[index].taskDescription}',
                                                    closeDate:
                                                        '${assignedtask1[index].closeDate?.substring(0, 10)}',
                                                    clientNote:
                                                        '${assignedtask1[index].clientNote}',
                                                    managerNote:
                                                        '${assignedtask1[index].managerNote}',
                                                    AssignationStatus: '',
                                                    priority:
                                                        '${assignedtask1[index].priority}',
                                                    clientApproval: '',
                                                    taskStatus:
                                                        '${assignedtask1[index].taskStatus}',
                                                    managerApproval: '',
                                                    taskCategory: '',
                                                    managerId: '',
                                                    assignTask: () {
                                                      if (assignedtask1[index]
                                                              .taskStatus ==
                                                          'Pending') {}
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      await gerInProgressTask();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          loading
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 80.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SpinKitDoubleBounce(
                                          color: blackColor.withOpacity(1),
                                          size: 50.0,
                                        ),
                                        Text("Loading....")
                                      ],
                                    ),
                                  ),
                                )
                              : managerApprovalPending.isEmpty
                                  ? Container(
                                      height: 100,
                                      child: const Center(
                                        child: Text(
                                            "There are no tasks waiting for \n manager approval"),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                managerApprovalPending.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: OpeartorContainer(
                                                    clientName: '${mapClientName[managerApprovalPending[index].clientId]}',
                                                    managerName: '${mapMangerName[managerApprovalPending[index].managerId]}',
                                                    Approve: () {},
                                                    Reject: () {},
                                                    TimeLineDoc: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TimeData(
                                                            Taskid:
                                                                '${managerApprovalPending[index].taskID}',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    AttachDoc: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AttachData(
                                                            Taskid:
                                                                '${managerApprovalPending[index].taskID}',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    ChangeStatus: () {},
                                                    who: 'operator',
                                                    fontColor: greyColor,
                                                    backgrondColor: greenColor,
                                                    first: yellowColor,
                                                    second: blackColor,
                                                    third: greyColor,
                                                    forth: redColor,
                                                    fifth: redColor,
                                                    sixth: yellowColor,
                                                    taskName:
                                                        '${managerApprovalPending[index].taskName}',
                                                    ProjectName:
                                                        '${managerApprovalPending[index].ProjectName}',
                                                    taskId:
                                                        '${managerApprovalPending[index].taskID}',
                                                    clientId:
                                                        '${managerApprovalPending[index].clientId}',
                                                    // '${mapClientIdName[assignedtask[index].clientId]}',
                                                    operatorId: '',
                                                    openDate:
                                                        '${managerApprovalPending[index].openDate?.substring(0, 10)}',
                                                    taskDescription:
                                                        '${managerApprovalPending[index].taskDescription}',
                                                    closeDate:
                                                        '${managerApprovalPending[index].closeDate?.substring(0, 10)}',
                                                    clientNote:
                                                        '${managerApprovalPending[index].clientNote}',
                                                    managerNote:
                                                        '${managerApprovalPending[index].managerNote}',
                                                    AssignationStatus: '',
                                                    priority:
                                                        '${managerApprovalPending[index].priority}',
                                                    clientApproval: '',
                                                    taskStatus:
                                                        '${managerApprovalPending[index].taskStatus}',
                                                    managerApproval: '',
                                                    taskCategory: '',
                                                    managerId: '',
                                                    assignTask: () {
                                                      if (managerApprovalPending[
                                                                  index]
                                                              .taskStatus ==
                                                          'Pending') {}
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      await gerInProgressTask();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          loading
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 80.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SpinKitDoubleBounce(
                                          color: blackColor.withOpacity(1),
                                          size: 50.0,
                                        ),
                                        Text("Loading....")
                                      ],
                                    ),
                                  ),
                                )
                              : clientApprovalPending.isEmpty
                                  ? Container(
                                      height: 100,
                                      child: const Center(
                                        child: Text(
                                            "There are no tasks waiting for \n client approval"),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                clientApprovalPending.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: OpeartorContainer(
                                                    Approve: () {},
                                                    Reject: () {},
                                                    TimeLineDoc: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TimeData(
                                                            Taskid:
                                                                '${clientApprovalPending[index].taskID}',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    AttachDoc: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AttachData(
                                                            Taskid:
                                                                '${clientApprovalPending[index].taskID}',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    ChangeStatus: () {},
                                                    who: 'operator',
                                                    fontColor: greyColor,
                                                    backgrondColor: greenColor,
                                                    first: yellowColor,
                                                    second: blackColor,
                                                    third: greyColor,
                                                    forth: redColor,
                                                    fifth: redColor,
                                                    sixth: yellowColor,
                                                    taskName:
                                                        '${clientApprovalPending[index].taskName}',
                                                    ProjectName:
                                                        '${clientApprovalPending[index].ProjectName}',
                                                    taskId:
                                                        '${clientApprovalPending[index].taskID}',
                                                    clientId:
                                                        '${clientApprovalPending[index].clientId}',
                                                    // '${mapClientIdName[assignedtask[index].clientId]}',
                                                    operatorId: '',
                                                    openDate:
                                                        '${clientApprovalPending[index].openDate?.substring(0, 10)}',
                                                    taskDescription:
                                                        '${clientApprovalPending[index].taskDescription}',
                                                    closeDate:
                                                        '${clientApprovalPending[index].closeDate?.substring(0, 10)}',
                                                    clientNote:
                                                        '${clientApprovalPending[index].clientNote}',
                                                    managerNote:
                                                        '${clientApprovalPending[index].managerNote}',
                                                    AssignationStatus: '',
                                                    priority:
                                                        '${clientApprovalPending[index].priority}',
                                                    clientApproval: '',
                                                    taskStatus:
                                                        '${clientApprovalPending[index].taskStatus}',
                                                    managerApproval: '',
                                                    taskCategory: '',
                                                    managerId: '',
                                                    assignTask: () {
                                                      if (clientApprovalPending[
                                                                  index]
                                                              .taskStatus ==
                                                          'Pending') {}
                                                    },
                                                    clientName: '${mapClientName[clientApprovalPending[index].clientId]}',
                                                    managerName: '${mapMangerName[clientApprovalPending[index].managerId]}',
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      await gerInProgressTask();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          loading
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 80.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SpinKitDoubleBounce(
                                          color: blackColor.withOpacity(1),
                                          size: 50.0,
                                        ),
                                        Text("Loading....")
                                      ],
                                    ),
                                  ),
                                )
                              : closedTask.isEmpty
                                  ? Container(
                                      height: 100,
                                      child: const Center(
                                        child:
                                            Text("Tasks aren't Assigned yet"),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: closedTask.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: OpeartorContainer(
                                                    clientName: '${mapClientName[closedTask[index].clientId]}',
                                                    managerName: '${mapMangerName[closedTask[index].managerId]}',
                                                    Approve: () {},
                                                    Reject: () {},
                                                    TimeLineDoc: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TimeData(
                                                            Taskid:
                                                                '${closedTask[index].taskID}',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    AttachDoc: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AttachData(
                                                            Taskid:
                                                                '${closedTask[index].taskID}',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    ChangeStatus: () {},
                                                    who: 'operator',
                                                    fontColor: greyColor,
                                                    backgrondColor: greenColor,
                                                    first: yellowColor,
                                                    second: blackColor,
                                                    third: greyColor,
                                                    forth: redColor,
                                                    fifth: redColor,
                                                    sixth: yellowColor,
                                                    taskName:
                                                        '${closedTask[index].taskName}',
                                                    ProjectName:
                                                        '${closedTask[index].ProjectName}',
                                                    taskId:
                                                        '${closedTask[index].taskID}',
                                                    clientId:
                                                        '${closedTask[index].clientId}',
                                                    // '${mapClientIdName[assignedtask[index].clientId]}',
                                                    operatorId: '',
                                                    openDate:
                                                        '${closedTask[index].openDate?.substring(0, 10)}',
                                                    taskDescription:
                                                        '${closedTask[index].taskDescription}',
                                                    closeDate:
                                                        '${closedTask[index].closeDate?.substring(0, 10)}',
                                                    clientNote:
                                                        '${closedTask[index].clientNote}',
                                                    managerNote:
                                                        '${closedTask[index].managerNote}',
                                                    AssignationStatus: '',
                                                    priority:
                                                        '${closedTask[index].priority}',
                                                    clientApproval: '',
                                                    taskStatus:
                                                        '${closedTask[index].taskStatus}',
                                                    managerApproval: '',
                                                    taskCategory: '',
                                                    managerId: '',
                                                    assignTask: () {
                                                      if (closedTask[index]
                                                              .taskStatus ==
                                                          'Pending') {}
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                          const SizedBox(
                            height: 30,
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
        // body: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   // child: SingleChildScrollView(
        //   // children:  [
        //   child:
        // ),
      ),
    );
  }
}
