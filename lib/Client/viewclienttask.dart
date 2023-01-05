import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intership/Client/addlinks.dart';
import 'package:intership/Client/clientprofile.dart';
import 'package:intership/Client/model/AttachmentModel.dart';
import 'package:intership/Client/viewlinks.dart';

import '../Admin/model/session.dart';
import '../Manager/model/TASKMODEL.dart';
import '../constant/ApI.dart';
import '../constant/color.dart';
import 'package:intership/Client/model/custom.dart';

TextEditingController linkcontroller = TextEditingController();
TextEditingController docnamecontroller = TextEditingController();

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

  List<TaskModel> tasklist = [];
  List<TaskModel> tasklist2 = [];
  Future<List<TaskModel>> gettasklist() async {
    setState(() {
      loading = true;//make loading true to show progressindicator
    });
    Session _session = Session();
    final response = await _session.get(getcreatedtask);
    print(response);

    for (dynamic i in response['result']) {
      print(i);
      tasklist.add(TaskModel.fromJson(i));
      if(TaskModel.fromJson(i).managerApproval == 'Accepted'){
        tasklist2.add(TaskModel.fromJson(i));
      }
    }
    loading = false;
    print(tasklist2.length);
    setState(() {});
    return tasklist;
  }

  Future<dynamic> addAttachments(String docName, drivelink, taskid) async {
    try {
      List<Map<String, String>> encodelist = [{'documentName': docName,'driveLink': drivelink}];
      Session _session = Session();
      final data = jsonEncode(<String, List<Map<String, String>>>{'documentsList':encodelist});
      final response = await _session.post('$addlinks/$taskid', data);
      return response;
    } catch (e) {
      print(e.toString());
    }
  }
  Future<dynamic> RejectRequest(String taskid) async {
    try {
      setState(() {
        loadingfour = true; //make loading true to show progressindicator
      });
      Session _session = Session();
      final data = jsonEncode(<String, String>{"Note" : "Task Rejected by client"});
      final response = await _session.post(
          'http://$ip/client/rejectTask/${taskid}', data);
      print(response.toString());
      print('Rejected');
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
      final data = jsonEncode(<String, String>{"Note" : "Task accepted by client." });
      final response = await _session.post(
          'http://$ip/client/approveTask/${taskid}', data);
      print(response.toString());
      print('Accepted ${taskid}');
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 18.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClientProfile()));
                    },
                    child: Container(
                      height: 25,
                      child: CircleAvatar(
                          child: Image.asset("assets/images/download.png")),
                    ),
                  ))
            ],
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
                    tabs: const [
                      Tab(
                        text: 'All Tasks',
                      ),
                      Tab(
                        text: 'Accept/Reject task',
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    loading
                        ? Center(child: SizedBox(height:100,width:100,child: CircularProgressIndicator()))
                        : SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: tasklist.length,
                                  itemBuilder: (context, index) {
                                    return tasklist[index].priority == 'null'
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: ClientContainer(
                                                fontColor: greyColor,
                                                backgrondColor: orangeColor,
                                                first: greyColor,
                                                second: greenColor,
                                                third: redColor,
                                                forth: greenColor,
                                                fifth: redColor,
                                                sixth: greyColor,
                                                taskName:
                                                    '${tasklist[index].taskName}',
                                                ProjectName:
                                                    '${tasklist[index].ProjectName}',
                                                taskId:
                                                    '${tasklist[index].taskID}',
                                                clientId:
                                                    '${tasklist[index].clientId}',
                                                operatorId: '',
                                                openDate:
                                                    '${tasklist[index].openDate?.substring(0, 10)}',
                                                taskDescription:
                                                    '${tasklist[index].taskDescription}',
                                                closeDate:
                                                    '${tasklist[index].closeDate?.substring(0, 10)}',
                                                clientNote:
                                                    '${tasklist[index].clientNote}',
                                                managerNote: '',
                                                AssignationStatus: '',
                                                priority: '',
                                                clientApproval: '',
                                                taskStatus:
                                                    '${tasklist[index].taskStatus}',
                                                managerApproval: '',
                                                taskCategory: '',
                                                managerId: '',
                                                approve: (){},
                                                reject: (){},
                                                addLink: () {
                                                  // Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddLinks()));
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
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
                                                              final response = await addAttachments(
                                                                  docnamecontroller
                                                                      .text
                                                                      .toString(),
                                                                  linkcontroller
                                                                      .text
                                                                      .toString(),
                                                                  tasklist[
                                                                          index]
                                                                      .taskID);
                                                              print(
                                                                  'dcccscsdc$response');
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
                                                },
                                                viewLink: (){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => ViewLinks(taskid: tasklist[index].taskID)));
                                                },
                                              ),
                                            ),
                                          );
                                  },
                                ),
                              ],
                            ),
                          ),
                    loading
                        ? const SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: tasklist2.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: ClientContainer(
                                          fontColor: greyColor,
                                          backgrondColor: greenColor,
                                            first: yellowColor,
                                            second: blackColor,
                                            third: greenColor,
                                            forth: redColor,
                                            fifth: redColor,
                                            sixth: yellowColor,
                                          taskName:
                                              '${tasklist2[index].taskName}',
                                          ProjectName:
                                              '${tasklist2[index].ProjectName}',
                                          taskId: '${tasklist2[index].taskID}',
                                          clientId:
                                              '${tasklist2[index].clientId}',
                                          operatorId:
                                              '${tasklist2[index].operatorId}',
                                          openDate:
                                              '${tasklist2[index].openDate?.substring(0, 10)}',
                                          taskDescription:
                                              '${tasklist2[index].taskDescription}',
                                          closeDate:
                                              '${tasklist2[index].closeDate?.substring(0, 10)}',
                                          clientNote:
                                              '${tasklist2[index].clientNote}',
                                          managerNote:
                                              '${tasklist2[index].managerNote}',
                                          AssignationStatus:
                                              '${tasklist2[index].AssignationStatus}',
                                          priority:
                                              '${tasklist2[index].priority}',
                                          clientApproval:
                                              '${tasklist2[index].clientApproval}',
                                          taskStatus:
                                              '${tasklist2[index].taskStatus}',
                                          managerApproval:
                                              '${tasklist2[index].managerApproval}',
                                          taskCategory:
                                              '${tasklist2[index].taskCategory}',
                                          managerId:
                                              '${tasklist2[index].managerId}',
                                          addLink: () {},
                                          viewLink: () {},
                                          approve: () async {
                                            await ApproveRequest(tasklist2[index].taskID);
                                          },
                                          reject: () async {
                                            await RejectRequest(tasklist2[index].taskID);
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
        ));
  }
}
