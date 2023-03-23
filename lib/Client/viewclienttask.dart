import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intership/Client/viewlinks.dart';

import '../Admin/model/session.dart';
import '../Manager/model/TASKMODEL.dart';
import '../constant/ApI.dart';
import '../constant/color.dart';
import 'package:intership/Client/model/custom.dart';

import 'model/custom2.dart';
import 'model/customwithnotes.dart';

TextEditingController linkcontroller = TextEditingController();
TextEditingController docnamecontroller = TextEditingController();
TextEditingController clientnotecontroller = TextEditingController();

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  bool loading = false;
  bool loadingfour = false;
  @override
  void initState() {
    gettasklist();
    super.initState();
  }

  var mapOperatorName = Map<String, dynamic>();
  getOperatorName(String s) async {
    Session _session = Session();
    final response = await _session.get('$ip/client/getOperator/$s');
    // print(response);
    mapOperatorName[s] = response['operator']['name'];
  }

  var mapManagerName = Map<String, dynamic>();
  getmanagerName(String s) async {
    Session _session = Session();
    final response = await _session.get('$ip/client/getManager/$s');
    // print("ResponseNAME ${response['manager']['name']}");
    mapManagerName[s] = response['manager']['name'];
  }

  var forthbuttontest;
  List<TaskModel> tasklist = [];
  List<TaskModel> inProgress = [];
  List<TaskModel> createdTasks = [];
  List<TaskModel> assignedTasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> acceptRejectTasks = [];
  List<TaskModel> closedtasks = [];
  Future<List<TaskModel>> gettasklist() async {
    tasklist.clear();
    createdTasks.clear();
    assignedTasks.clear();
    completedTasks.clear();
    acceptRejectTasks.clear();
    closedtasks.clear();
    inProgress.clear();

    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response = await _session.get(getcreatedtask);
    // print(response);

    for (dynamic i in response['result']) {
      print("i : $i");

      // await getOperatorName('${TaskModel.fromJson(i).operatorId}');
      // await getmanagerName('${TaskModel.fromJson(i).managerId}');

      tasklist.add(TaskModel.fromJson(i));
      if (TaskModel.fromJson(i).AssignationStatus == 'Pending') {
        createdTasks.add(TaskModel.fromJson(i));
      }
      if ((TaskModel.fromJson(i).AssignationStatus == 'Assigned' ||
                  TaskModel.fromJson(i).AssignationStatus == 'Reassinged') &&
              (TaskModel.fromJson(i).taskStatus == 'Pending') &&
              (TaskModel.fromJson(i).managerApproval == 'Pending' ||
                  TaskModel.fromJson(i).managerApproval == 'Rejected') &&
              (TaskModel.fromJson(i).clientApproval == 'Pending' ||
                  TaskModel.fromJson(i).clientApproval ==
                      'Rejected') //clientApproval
          ) {
        print("bnbvnbzxczxvcnbzxvcnz");
        assignedTasks.add(TaskModel.fromJson(i));
        await getOperatorName('${TaskModel.fromJson(i).operatorId}');
        await getmanagerName('${TaskModel.fromJson(i).managerId}');
      }
      if ((TaskModel.fromJson(i).AssignationStatus == 'Assigned' ||
                  TaskModel.fromJson(i).AssignationStatus == 'Reassinged') &&
              (TaskModel.fromJson(i).taskStatus == 'inProgress') &&
              (TaskModel.fromJson(i).managerApproval == 'Pending' ||
                  TaskModel.fromJson(i).managerApproval == 'Rejected') &&
              (TaskModel.fromJson(i).clientApproval == 'Pending' ||
                  TaskModel.fromJson(i).clientApproval ==
                      'Rejected') //clientApproval
          ) {
        inProgress.add(TaskModel.fromJson(i));
        await getOperatorName('${TaskModel.fromJson(i).operatorId}');
        await getmanagerName('${TaskModel.fromJson(i).managerId}');
      }

      if (TaskModel.fromJson(i).taskStatus == 'Completed' &&
          (TaskModel.fromJson(i).managerApproval == 'Pending' ||
              TaskModel.fromJson(i).managerApproval == 'Rejected') &&
          (TaskModel.fromJson(i).clientApproval == 'Pending' ||
              TaskModel.fromJson(i).clientApproval == 'Rejected')) {
        completedTasks.add(TaskModel.fromJson(i));
        await getOperatorName('${TaskModel.fromJson(i).operatorId}');
        await getmanagerName('${TaskModel.fromJson(i).managerId}');
      }

      if (TaskModel.fromJson(i).managerApproval == 'Accepted' &&
          (TaskModel.fromJson(i).clientApproval == 'Pending' ||
              TaskModel.fromJson(i).clientApproval == 'Rejected') &&
          TaskModel.fromJson(i).taskStatus == 'Completed') {
        acceptRejectTasks.add(TaskModel.fromJson(i));
        await getOperatorName('${TaskModel.fromJson(i).operatorId}');
        await getmanagerName('${TaskModel.fromJson(i).managerId}');
      }

      if (TaskModel.fromJson(i).managerApproval == 'Accepted' &&
          TaskModel.fromJson(i).clientApproval == 'Accepted' &&
          TaskModel.fromJson(i).taskStatus == 'Closed') {
        closedtasks.add(TaskModel.fromJson(i));
        await getOperatorName('${TaskModel.fromJson(i).operatorId}');
        await getmanagerName('${TaskModel.fromJson(i).managerId}');
      }
    }

    // print(acceptRejectTasks.length);
    setState(() {
      loading = false;
    });
    return tasklist;
  }

  Future<dynamic> addAttachments(String docName, drivelink, taskid) async {
    try {
      List<Map<String, String>> encodelist = [
        {'documentName': docName, 'driveLink': drivelink}
      ];
      Session _session = Session();
      final data = jsonEncode(
          <String, List<Map<String, String>>>{'documentsList': encodelist});
      final response = await _session.post('$addlinks/$taskid', data);
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> RejectRequest(String taskid, String ClientNote) async {
    try {
      setState(() {
        loadingfour = true; //make loading true to show progressindicator
      });
      Session _session = Session();
      final data = jsonEncode(<String, String>{"Note": ClientNote});
      final response =
          await _session.post('$ip/client/rejectTask/${taskid}', data);
      // print(response.toString());
      // print('Rejected');
      await gettasklist();
      setState(() {
        loadingfour = false; //make loading true to show progressindicator
      });
      return response;
    } catch (e) {
      await gettasklist();
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
      final data =
          jsonEncode(<String, String>{"Note": "Task accepted by client."});
      final response =
          await _session.post('$ip/client/approveTask/${taskid}', data);
      print(response.toString());
      print('Accepted ${taskid}');
      await gettasklist();
      setState(() {
        loadingfour = false; //make loading true to show progressindicator
      });
      return response;
    } catch (e) {
      await gettasklist();
      setState(() {
        loadingfour = false; //make loading true to show progressindicator
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            title: const Center(
                child: Text(
              "MyTasks",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
              // assets/images/
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(8),
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
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'Created Tasks (${createdTasks.length})',
                      ),
                      Tab(
                        text: 'Assigned Tasks (${assignedTasks.length})',
                      ),
                      Tab(
                        text: 'inProgress Tasks (${inProgress.length})',
                      ),
                      Tab(
                        text: 'Completed Tasks (${completedTasks.length})',
                      ),
                      Tab(
                        text:
                            'Accept/Reject Tasks (${acceptRejectTasks.length})',
                      ),
                      Tab(
                        text: 'Closed Tasks (${closedtasks.length})',
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    loading
                        ? MyLoading()
                        : RefreshIndicator(
                            onRefresh: () async {
                              await gettasklist();
                            },
                            child: createdTasks.length == 0
                                ? Container(
                                    child: Center(
                                        child: Text("There are no tasks")),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: createdTasks.length,
                                          itemBuilder: (context, index) {
                                            if (createdTasks[index]
                                                    .taskStatus ==
                                                "inProgress") {
                                              forthbuttontest =
                                                  "Operator Assigned";
                                            } else if (createdTasks[index]
                                                    .taskStatus ==
                                                "Pending") {
                                              forthbuttontest =
                                                  "Operator Not Assigned";
                                            } else if (createdTasks[index]
                                                    .taskStatus ==
                                                "Completed") {
                                              if (createdTasks[index]
                                                          .clientApproval ==
                                                      "Rejected" &&
                                                  createdTasks[index]
                                                          .managerApproval ==
                                                      "Pending") {
                                                forthbuttontest =
                                                    "Waiting for approvals";
                                              } else if (createdTasks[index]
                                                      .managerApproval ==
                                                  "Pending") {
                                                forthbuttontest =
                                                    "Waiting for Manager Approval";
                                              } else if (createdTasks[index]
                                                      .managerApproval ==
                                                  "Accepted") {
                                                forthbuttontest =
                                                    "Waiting for Client Approval";
                                              } else if (createdTasks[index]
                                                      .managerApproval ==
                                                  "Rejected") {
                                                forthbuttontest =
                                                    "Rejected by Manager";
                                              }
                                            }
                                            return createdTasks[index]
                                                        .priority ==
                                                    'null'
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      child: ClientContainer(
                                                        fontColor: blackColor,
                                                        backgrondColor:
                                                            blueColor,
                                                        first: yellowColor,
                                                        second: blackColor,
                                                        third: redColor,
                                                        forth: redColor,
                                                        fifth: redColor,
                                                        sixth: yellowColor,
                                                        taskName:
                                                            '${createdTasks[index].taskName}',
                                                        ProjectName:
                                                            '${createdTasks[index].projectName}',
                                                        taskId:
                                                            '${createdTasks[index].taskID}',
                                                        projectId:
                                                            '${createdTasks[index].projectId}',
                                                        clientId:
                                                            '${createdTasks[index].clientId}',
                                                        operatorId: '',
                                                        openDate:
                                                            '${createdTasks[index].openDate?.substring(0, 10)}',
                                                        taskDescription:
                                                            '${createdTasks[index].taskDescription}',
                                                        closeDate:
                                                            '${createdTasks[index].closeDate?.substring(0, 10)}',
                                                        clientNote:
                                                            '${createdTasks[index].clientNote}',
                                                        managerNote: '',
                                                        AssignationStatus: '',
                                                        priority: '',
                                                        clientApproval: '',
                                                        taskStatus:
                                                            '${createdTasks[index].taskStatus}',
                                                        managerApproval: '',
                                                        taskCategory: '',
                                                        managerId: '',
                                                        approve: () {},
                                                        reject: () {},
                                                        addLink: () {
                                                          // Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddLinks()));
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    "Add Submission Link"),
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    children: [
                                                                      const Text(
                                                                          'Multiple Links Can be added'),
                                                                      const SizedBox(
                                                                        height:
                                                                            8,
                                                                      ),
                                                                      TextField(
                                                                        controller:
                                                                            docnamecontroller,
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              'Document Name',
                                                                          labelText:
                                                                              'DocName',
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            8,
                                                                      ),
                                                                      TextField(
                                                                        controller:
                                                                            linkcontroller,
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              'Add Link',
                                                                          labelText:
                                                                              'Link',
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            "No"),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      if (docnamecontroller.text.toString().length ==
                                                                              0 &&
                                                                          linkcontroller.text.length ==
                                                                              0) {
                                                                        final snackBar =
                                                                            SnackBar(
                                                                          content:
                                                                              const Text("Enter doc"),
                                                                          backgroundColor: (Colors
                                                                              .black
                                                                              .withOpacity(.6)),
                                                                          action:
                                                                              SnackBarAction(
                                                                            label:
                                                                                'dismiss',
                                                                            onPressed:
                                                                                () {},
                                                                          ),
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackBar);
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      } else {
                                                                        final response = await addAttachments(
                                                                            docnamecontroller.text.toString(),
                                                                            linkcontroller.text.toString(),
                                                                            createdTasks[index].taskID);
                                                                        docnamecontroller
                                                                            .clear();
                                                                        linkcontroller
                                                                            .clear();
                                                                        print(
                                                                            'dcccscsdc$response');
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }
                                                                    },
                                                                    child: const Text(
                                                                        "Yes"),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        viewLink: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ViewLinks(
                                                                          taskid:
                                                                              createdTasks[index].taskID)));
                                                        },
                                                        forthbuttontext:
                                                            '$forthbuttontest',
                                                        managername: '',
                                                        operatorname: '',
                                                      ),
                                                    ),
                                                  );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                    loading
                        ? MyLoading()
                        : RefreshIndicator(
                            onRefresh: () async {
                              await gettasklist();
                            },
                            child: assignedTasks.length == 0
                                ? Container(
                                    child: Center(
                                        child: Text("There are no tasks")),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: assignedTasks.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: CustomWithNote(
                                                  fontColor: blackColor,
                                                  backgrondColor:
                                                      whitegreyColor,
                                                  first: yellowColor,
                                                  second: blackColor,
                                                  third: redColor,
                                                  forth: redColor,
                                                  fifth: redColor,
                                                  sixth: yellowColor,
                                                  taskName:
                                                      '${assignedTasks[index].taskName}',
                                                  ProjectName:
                                                      '${assignedTasks[index].projectName}',
                                                  taskId:
                                                      '${assignedTasks[index].taskID}',
                                                  projectId:
                                                      '${assignedTasks[index].projectId}',
                                                  clientId:
                                                      '${assignedTasks[index].clientId}',
                                                  operatorId:
                                                      '${assignedTasks[index].operatorId}',
                                                  openDate:
                                                      '${assignedTasks[index].openDate?.substring(0, 10)}',
                                                  taskDescription:
                                                      '${assignedTasks[index].taskDescription}',
                                                  closeDate:
                                                      '${assignedTasks[index].closeDate?.substring(0, 10)}',
                                                  clientNote:
                                                      '${assignedTasks[index].clientNote}',
                                                  managerNote:
                                                      '${assignedTasks[index].managerNote}',
                                                  AssignationStatus:
                                                      '${assignedTasks[index].AssignationStatus}',
                                                  priority:
                                                      '${assignedTasks[index].priority}',
                                                  clientApproval:
                                                      '${assignedTasks[index].clientApproval}',
                                                  taskStatus:
                                                      '${assignedTasks[index].taskStatus}',
                                                  managerApproval:
                                                      '${assignedTasks[index].managerApproval}',
                                                  taskCategory:
                                                      '${assignedTasks[index].taskCategory}',
                                                  managerId:
                                                      '${assignedTasks[index].managerId}',
                                                  addLink: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Add Submission Link"),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                const Text(
                                                                    'Multiple Links Can be added'),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      docnamecontroller,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    hintText:
                                                                        'Document Name',
                                                                    labelText:
                                                                        'DocName',
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      linkcontroller,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    hintText:
                                                                        'Add Link',
                                                                    labelText:
                                                                        'Link',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "No"),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                if (docnamecontroller
                                                                            .text
                                                                            .toString()
                                                                            .length ==
                                                                        0 &&
                                                                    linkcontroller
                                                                            .text
                                                                            .length ==
                                                                        0) {
                                                                  final snackBar =
                                                                      SnackBar(
                                                                    content:
                                                                        const Text(
                                                                            "Enter doc"),
                                                                    backgroundColor: (Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .6)),
                                                                    action:
                                                                        SnackBarAction(
                                                                      label:
                                                                          'dismiss',
                                                                      onPressed:
                                                                          () {},
                                                                    ),
                                                                  );
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          snackBar);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                } else {
                                                                  final response = await addAttachments(
                                                                      docnamecontroller
                                                                          .text
                                                                          .toString(),
                                                                      linkcontroller
                                                                          .text
                                                                          .toString(),
                                                                      assignedTasks[
                                                                              index]
                                                                          .taskID);
                                                                  docnamecontroller
                                                                      .clear();
                                                                  linkcontroller
                                                                      .clear();
                                                                  print(
                                                                      'dcccscsdc$response');
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              },
                                                              child: const Text(
                                                                  "Yes"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  viewLink: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewLinks(
                                                                    taskid: assignedTasks[
                                                                            index]
                                                                        .taskID)));
                                                  },
                                                  approve: () {},
                                                  reject: () {},
                                                  forthbuttontext:
                                                      '${assignedTasks[index].priority}',
                                                  operatorname:
                                                      '${mapOperatorName[assignedTasks[index].operatorId]}',
                                                  managername:
                                                      '${mapManagerName[assignedTasks[index].managerId]}',
                                                  // managername: '${mapManagerName[assignedTasks[index].managerId]}', operatorname: '${mapOperatorName[assignedTasks[index].operatorId]}',
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                    loading
                        ? MyLoading()
                        : RefreshIndicator(
                            onRefresh: () async {
                              await gettasklist();
                            },
                            child: inProgress.length == 0
                                ? Container(
                                    child: Center(
                                        child: Text("There are no tasks")),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: inProgress.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: MyContainer(
                                                  fontColor: blackColor,
                                                  backgrondColor:
                                                      whitegreyColor,
                                                  first: yellowColor,
                                                  second: blackColor,
                                                  third: redColor,
                                                  forth: redColor,
                                                  fifth: redColor,
                                                  sixth: yellowColor,
                                                  taskName:
                                                      '${inProgress[index].taskName}',
                                                  ProjectName:
                                                      '${inProgress[index].projectName}',
                                                  taskId:
                                                      '${inProgress[index].taskID}',
                                                  projectId:
                                                      '${inProgress[index].projectId}',
                                                  clientId:
                                                      '${inProgress[index].clientId}',
                                                  operatorId:
                                                      '${inProgress[index].operatorId}',
                                                  openDate:
                                                      '${inProgress[index].openDate?.substring(0, 10)}',
                                                  taskDescription:
                                                      '${inProgress[index].taskDescription}',
                                                  closeDate:
                                                      '${inProgress[index].closeDate?.substring(0, 10)}',
                                                  clientNote:
                                                      '${inProgress[index].clientNote}',
                                                  managerNote:
                                                      '${inProgress[index].managerNote}',
                                                  AssignationStatus:
                                                      '${inProgress[index].AssignationStatus}',
                                                  priority:
                                                      '${inProgress[index].priority}',
                                                  clientApproval:
                                                      '${inProgress[index].clientApproval}',
                                                  taskStatus:
                                                      '${inProgress[index].taskStatus}',
                                                  managerApproval:
                                                      '${inProgress[index].managerApproval}',
                                                  taskCategory:
                                                      '${inProgress[index].taskCategory}',
                                                  managerId:
                                                      '${inProgress[index].managerId}',
                                                  addLink: () {},
                                                  viewLink: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewLinks(
                                                                    taskid: inProgress[
                                                                            index]
                                                                        .taskID)));
                                                  },
                                                  approve: () {},
                                                  reject: () {},
                                                  forthbuttontext:
                                                      'Completed by Operator',
                                                  operatorname:
                                                      '${mapOperatorName[inProgress[index].operatorId]}',
                                                  managername:
                                                      '${mapManagerName[inProgress[index].managerId]}',
                                                  // managername: '${mapManagerName[completedTasks[index].managerId]}', operatorname: '${mapManagerName[completedTasks[index].operatorId]}',
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                    loading
                        ? MyLoading()
                        : RefreshIndicator(
                            onRefresh: () async {
                              await gettasklist();
                            },
                            child: completedTasks.length == 0
                                ? Container(
                                    child: Center(
                                        child: Text("There are no tasks")),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: completedTasks.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: MyContainer(
                                                  fontColor: blackColor,
                                                  backgrondColor:
                                                      whitegreyColor,
                                                  first: yellowColor,
                                                  second: blackColor,
                                                  third: redColor,
                                                  forth: redColor,
                                                  fifth: redColor,
                                                  sixth: yellowColor,
                                                  taskName:
                                                      '${completedTasks[index].taskName}',
                                                  ProjectName:
                                                      '${completedTasks[index].projectName}',
                                                  taskId:
                                                      '${completedTasks[index].taskID}',
                                                  projectId:
                                                      '${completedTasks[index].projectId}',
                                                  clientId:
                                                      '${completedTasks[index].clientId}',
                                                  operatorId:
                                                      '${completedTasks[index].operatorId}',
                                                  openDate:
                                                      '${completedTasks[index].openDate?.substring(0, 10)}',
                                                  taskDescription:
                                                      '${completedTasks[index].taskDescription}',
                                                  closeDate:
                                                      '${completedTasks[index].closeDate?.substring(0, 10)}',
                                                  clientNote:
                                                      '${completedTasks[index].clientNote}',
                                                  managerNote:
                                                      '${completedTasks[index].managerNote}',
                                                  AssignationStatus:
                                                      '${completedTasks[index].AssignationStatus}',
                                                  priority:
                                                      '${completedTasks[index].priority}',
                                                  clientApproval:
                                                      '${completedTasks[index].clientApproval}',
                                                  taskStatus:
                                                      '${completedTasks[index].taskStatus}',
                                                  managerApproval:
                                                      '${completedTasks[index].managerApproval}',
                                                  taskCategory:
                                                      '${completedTasks[index].taskCategory}',
                                                  managerId:
                                                      '${completedTasks[index].managerId}',
                                                  addLink: () {},
                                                  viewLink: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewLinks(
                                                                    taskid: completedTasks[
                                                                            index]
                                                                        .taskID)));
                                                  },
                                                  approve: () {},
                                                  reject: () {},
                                                  forthbuttontext:
                                                      'Completed by Operator',
                                                  operatorname:
                                                      '${mapOperatorName[completedTasks[index].operatorId]}',
                                                  managername:
                                                      '${mapManagerName[completedTasks[index].managerId]}',
                                                  // managername: '${mapManagerName[completedTasks[index].managerId]}', operatorname: '${mapManagerName[completedTasks[index].operatorId]}',
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                    loading
                        ? MyLoading()
                        : RefreshIndicator(
                            onRefresh: () async {
                              await gettasklist();
                            },
                            child: acceptRejectTasks.length == 0
                                ? Container(
                                    child: Center(
                                        child: Text("There are no tasks")),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: acceptRejectTasks.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: MyContainer(
                                                  fontColor: blackColor,
                                                  backgrondColor: blueColor,
                                                  first: yellowColor,
                                                  second: blackColor,
                                                  third: redColor,
                                                  forth: redColor,
                                                  fifth: redColor,
                                                  sixth: yellowColor,
                                                  taskName:
                                                      '${acceptRejectTasks[index].taskName}',
                                                  ProjectName:
                                                      '${acceptRejectTasks[index].projectName}',
                                                  taskId:
                                                      '${acceptRejectTasks[index].taskID}',
                                                  projectId:
                                                      '${acceptRejectTasks[index].projectId}',
                                                  clientId:
                                                      '${acceptRejectTasks[index].clientId}',
                                                  operatorId:
                                                      '${acceptRejectTasks[index].operatorId}',
                                                  openDate:
                                                      '${acceptRejectTasks[index].openDate?.substring(0, 10)}',
                                                  taskDescription:
                                                      '${acceptRejectTasks[index].taskDescription}',
                                                  closeDate:
                                                      '${acceptRejectTasks[index].closeDate?.substring(0, 10)}',
                                                  clientNote:
                                                      '${acceptRejectTasks[index].clientNote}',
                                                  managerNote:
                                                      '${acceptRejectTasks[index].managerNote}',
                                                  AssignationStatus:
                                                      '${acceptRejectTasks[index].AssignationStatus}',
                                                  priority:
                                                      '${acceptRejectTasks[index].priority}',
                                                  clientApproval:
                                                      '${acceptRejectTasks[index].clientApproval}',
                                                  taskStatus:
                                                      '${acceptRejectTasks[index].taskStatus}',
                                                  managerApproval:
                                                      '${acceptRejectTasks[index].managerApproval}',
                                                  taskCategory:
                                                      '${acceptRejectTasks[index].taskCategory}',
                                                  managerId:
                                                      '${acceptRejectTasks[index].managerId}',
                                                  addLink: () {},
                                                  viewLink: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewLinks(
                                                                    taskid: acceptRejectTasks[
                                                                            index]
                                                                        .taskID)));
                                                  },
                                                  approve: () async {
                                                    await ApproveRequest(
                                                        acceptRejectTasks[index]
                                                            .taskID);
                                                  },
                                                  reject: () async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Add Note"),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      clientnotecontroller,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    hintText:
                                                                        'Add reason for rejection',
                                                                    labelText:
                                                                        'ClientNote',
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "No"),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                await RejectRequest(
                                                                    acceptRejectTasks[
                                                                            index]
                                                                        .taskID,
                                                                    clientnotecontroller
                                                                        .text
                                                                        .toString());
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "Yes"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    // await RejectRequest(tasklist2[index].taskID,clientnotecontroller.text.toString());
                                                  },
                                                  forthbuttontext:
                                                      'Approved by Manager',
                                                  operatorname:
                                                      '${mapOperatorName[acceptRejectTasks[index].operatorId]}',
                                                  managername:
                                                      '${mapManagerName[acceptRejectTasks[index].managerId]}',
                                                  // managername: '${mapManagerName[acceptRejectTasks[index].managerId]}', operatorname: '${mapManagerName[acceptRejectTasks[index].operatorId]}',
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                    loading
                        ? MyLoading()
                        : RefreshIndicator(
                            onRefresh: () async {
                              await gettasklist();
                            },
                            child: closedtasks.length == 0
                                ? Container(
                                    child: Center(
                                        child: Text("There are no tasks")),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: closedtasks.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: MyContainer(
                                                  fontColor: blackColor,
                                                  backgrondColor:
                                                      whitegreyColor,
                                                  first: yellowColor,
                                                  second: blackColor,
                                                  third: redColor,
                                                  forth: redColor,
                                                  fifth: redColor,
                                                  sixth: yellowColor,
                                                  taskName:
                                                      '${closedtasks[index].taskName}',
                                                  ProjectName:
                                                      '${closedtasks[index].projectName}',
                                                  taskId:
                                                      '${closedtasks[index].taskID}',
                                                  projectId:
                                                      '${closedtasks[index].projectId}',
                                                  clientId:
                                                      '${closedtasks[index].clientId}',
                                                  operatorId:
                                                      '${closedtasks[index].operatorId}',
                                                  openDate:
                                                      '${closedtasks[index].openDate?.substring(0, 10)}',
                                                  taskDescription:
                                                      '${closedtasks[index].taskDescription}',
                                                  closeDate:
                                                      '${closedtasks[index].closeDate?.substring(0, 10)}',
                                                  clientNote:
                                                      '${closedtasks[index].clientNote}',
                                                  managerNote:
                                                      '${closedtasks[index].managerNote}',
                                                  AssignationStatus:
                                                      '${closedtasks[index].AssignationStatus}',
                                                  priority:
                                                      '${closedtasks[index].priority}',
                                                  clientApproval:
                                                      '${closedtasks[index].clientApproval}',
                                                  taskStatus:
                                                      '${closedtasks[index].taskStatus}',
                                                  managerApproval:
                                                      '${closedtasks[index].managerApproval}',
                                                  taskCategory:
                                                      '${closedtasks[index].taskCategory}',
                                                  managerId:
                                                      '${closedtasks[index].managerId}',
                                                  addLink: () {},
                                                  viewLink: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewLinks(
                                                                    taskid: closedtasks[
                                                                            index]
                                                                        .taskID)));
                                                  },
                                                  approve: () {},
                                                  reject: () {},
                                                  forthbuttontext:
                                                      'Task Completed',
                                                  operatorname:
                                                      '${mapOperatorName[closedtasks[index].operatorId]}',
                                                  managername:
                                                      '${mapManagerName[closedtasks[index].managerId]}',
                                                ),
                                              ),
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
        ));
  }
}
