import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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

  Future<List<TaskModel>> gerInProgressTask() async {
    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response = await _session.get(operatortaskByOperatorId);
    // print(response);
    for (dynamic i in response['result']) {
      if (TaskModel.fromJson(i).taskStatus == 'inProgress') {
      //   print(i);
        assignedtask.add(TaskModel.fromJson(i));
      }
    }
    print(assignedtask.length);
    for (var i in assignedtask) {
      print("${i.taskDescription} == ${i.taskStatus}");
    }
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
      // await gerInProgressTask();
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
    return Scaffold(
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
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Container(
                height: 25,
                child: CircleAvatar(
                    child: Image.asset("assets/images/download.png")),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: SingleChildScrollView(
        // children:  [
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : assignedtask.isEmpty
                      ? const Center(
                          child: Text("Tasks aren't Assigned yet"),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: assignedtask.length,
                                itemBuilder: (context, index) {
                                  return assignedtask[index].taskStatus != 'inProgress'
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: ClientContainer(
                                              Approve: () {}, Reject: () {},
                                              TimeLineDoc: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TimeData(
                                                      Taskid:
                                                          '${assignedtask[index].taskID}',
                                                    ),
                                                  ),
                                                );
                                              },
                                              AttachDoc: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AttachData(
                                                      Taskid:
                                                          '${assignedtask[index].taskID}',
                                                    ),
                                                  ),
                                                );
                                              },
                                              ChangeStatus: () {
                                                // print('object');
                                                UpdateStatus(
                                                  '${assignedtask[index].taskID}',
                                                );
                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => const home_operator()));
                                              },
                                              who: 'operator',
                                              fontColor: greyColor,
                                              backgrondColor: greenColor,
                                              first: yellowColor,
                                              second: blackColor,
                                              third: greenColor,
                                              forth: redColor,
                                              fifth: redColor,
                                              sixth: yellowColor,
                                              taskName:
                                                  '${assignedtask[index].taskName}',
                                              ProjectName:
                                                  '${assignedtask[index].ProjectName}',
                                              taskId:
                                                  '${assignedtask[index].taskID}',
                                              clientId:
                                                  '${assignedtask[index].clientId}',
                                              // '${mapClientIdName[assignedtask[index].clientId]}',
                                              operatorId: '',
                                              openDate:
                                                  '${assignedtask[index].openDate?.substring(0, 10)}',
                                              taskDescription:
                                                  '${assignedtask[index].taskDescription}',
                                              closeDate:
                                                  '${assignedtask[index].closeDate?.substring(0, 10)}',
                                              clientNote:
                                                  '${assignedtask[index].clientNote}',
                                              managerNote: '',
                                              AssignationStatus: '',
                                              priority: '',
                                              clientApproval: '',
                                              taskStatus:
                                                  '${assignedtask[index].taskStatus}',
                                              managerApproval: '',
                                              taskCategory: '',
                                              managerId: '',
                                              assignTask: () {
                                                if (assignedtask[index]
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
    );
  }
}
