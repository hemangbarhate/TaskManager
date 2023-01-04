import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/Manager/ApiCall/DepartmentANDOpratorData.dart';
import 'package:intership/Manager/managerViewtask.dart';
import 'package:intership/Manager/model/operatormodel.dart';
import 'package:intership/constant/ApI.dart';
import 'package:intership/constant/color.dart';

class AssignTask extends StatefulWidget {
  final String taskId;
  const AssignTask({Key? key, required this.taskId}) : super(key: key);
  @override
  _AssignTaskState createState() => _AssignTaskState();
}

enum Priority { high, medium, low }

class _AssignTaskState extends State<AssignTask> {
  Priority? _pri = Priority.medium;
  bool loading = false;
  Future<dynamic> assignTask(
      String opId, String managerNote, String priorityAssigned) async {
    try {
      Session _session = Session();
      final data = jsonEncode(
        <String, String>{
          "operatorId": opId,
          "managerNote": managerNote,
          "priority": priorityAssigned,
          "AssignationStatus": "Assigned",
          "taskStatus": "inProgress"
        },
      );
      print(
          "Operatorid ${opId} && managerNote ${managerNote} && priorityAssigned $priorityAssigned taskId ${widget.taskId}");
      final response = await _session.post(
          'http://164.92.83.169/manager/assignTask/${widget.taskId}', data);
      print(response.toString());
      print('Task Assigned successfully');
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  List<OperatorData> operaortlist = [];
  @override
  void getDATA() async {
    // TODO: implement initState
    setState(() {
      loading = true;
    });
    operaortlist = await getOperator();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getDATA();
    super.initState();
  }

  TextEditingController managerNOTE = TextEditingController();
  int select = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: const Center(
            child: Text(
          "Assign Task",
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Set Priority",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: greyColor.withOpacity(0.9)),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
              ),
            ),
            ListTile(
              title: const Text('High'),
              leading: Radio<Priority>(
                value: Priority.high,
                groupValue: _pri,
                onChanged: (Priority? value) {
                  setState(() {
                    _pri = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Medium'),
              leading: Radio<Priority>(
                value: Priority.medium,
                groupValue: _pri,
                onChanged: (Priority? value) {
                  setState(() {
                    _pri = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Low'),
              leading: Radio<Priority>(
                value: Priority.low,
                groupValue: _pri,
                onChanged: (Priority? value) {
                  setState(() {
                    _pri = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Note for Operator",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: greyColor.withOpacity(0.9)),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: managerNOTE,
                decoration: InputDecoration(
                  labelText: 'Note',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Assign Operator",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: greyColor.withOpacity(0.9)),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
              ),
            ),
            loading
                ? CircularProgressIndicator()
                : Container(
                    height: 350,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: operaortlist.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  select = index;
                                  print("${operaortlist[index].operatorId} = ${operaortlist[index].email}");
                                });
                              },
                              child: Container(
                                color: select == index
                                    ? greyColor.withOpacity(0.2)
                                    : whiteColor.withOpacity(1),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: ListTile(
                                      title: Text("${operaortlist[index].name}"),
                                      subtitle:
                                          Text("${operaortlist[index].email}"),
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
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () async {
                if (select != -1 && !managerNOTE.text.isEmpty) {
                  print(_pri);
                  var response = await assignTask(
                    operaortlist[select].operatorId,
                    managerNOTE.text.toString(),
                    _pri.toString().substring(9),
                  ).catchError((err) {});
                  if (response == null) {
                    return;
                  } else {
                    managerNOTE.clear();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ViewTask(),
                      ),
                    );
                  }
                } else {
                  final snackBar = SnackBar(
                    content: Text("Try again"),
                    backgroundColor: (Colors.black12),
                    action: SnackBarAction(
                      label: 'dismiss',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
              },
              child: Container(
                // width: 150,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      greyColor.withOpacity(0.7),
                      greyColor.withOpacity(0.7)
                      // Colors.teal[200],
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    '  Submit  ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
