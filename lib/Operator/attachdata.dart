import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/Operator/model/attachmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/ApI.dart';

class AttachData extends StatefulWidget {
  const AttachData({Key? key, required this.Taskid}) : super(key: key);
  final String Taskid;

  @override
  _AttachDataState createState() => _AttachDataState();
}

class _AttachDataState extends State<AttachData> {
  // operatortasktimelinebyTaskId
  bool loadingfour = false;

  List<AttachModel> completetask = [];
  Future<List<AttachModel>> getTimeline() async {
    print("// Attach Tasks");
    setState(() {
      loadingfour = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response =
        await _session.get('$ip/operator/getAttachments/${widget.Taskid}');
    print("response $response");
    print("response ${response['success']}");
    if (response['success'] == false) {
      loadingfour = false;
      setState(() {});
      return completetask;
    }
    ;
    for (dynamic i in response['data']) {
      // print(i);
      completetask.add(AttachModel.fromJson(i));
    }
    if (completetask.length >= 1) print(completetask[0]);
    loadingfour = false;
    setState(() {});
    return completetask;
  }

  TextEditingController linkcontroller = TextEditingController();
  TextEditingController docnamecontroller = TextEditingController();
  TextEditingController clientnotecontroller = TextEditingController();
  Future<dynamic> addAttachments(String docName, drivelink, taskid) async {
    try {
      List<Map<String, String>> encodelist = [
        {'documentName': docName, 'driveLink': drivelink}
      ];
      Session _session = Session();
      final data = jsonEncode(
          <String, List<Map<String, String>>>{'documentsList': encodelist});
      final response = await _session.post('$addlinks/$taskid', data);
      print('res ${response.toString()}');
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getTimeline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        title: const Center(
            child: Text(
          "AttachedDoc",
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
      body: loadingfour
          ? const Center(child: CircularProgressIndicator())
          : completetask.isEmpty
              ? const Center(
                  child: Text("No doc are attached yet"),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: completetask.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: TEXT(
                                data: '${completetask[index].driveLink}',
                                field: '${completetask[index].documentName}',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Add Submission Link"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text('Multiple Links Can be added'),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: docnamecontroller,
                        decoration: const InputDecoration(
                          hintText: 'Document Name',
                          labelText: 'DocName',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: linkcontroller,
                        decoration: const InputDecoration(
                          hintText: 'Add Link',
                          labelText: 'Link',
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (docnamecontroller.text.toString().length == 0 &&
                          linkcontroller.text.length == 0) {
                        final snackBar = SnackBar(
                          content: const Text("Enter doc"),
                          backgroundColor: (Colors.black.withOpacity(.6)),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                      } else {
                        final response = await addAttachments(
                            docnamecontroller.text.toString(),
                            linkcontroller.text.toString(),
                            widget.Taskid);
                        docnamecontroller.clear();
                        linkcontroller.clear();
                        print('dcccscsdc$response');
                        Navigator.of(context).pop();
                        setState(() {
                          completetask.clear();
                          getTimeline();
                        });
                      }
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
          );
        },
        label: Text('Add Links'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.amberAccent,
      ),
    );
  }
}

class TEXT extends StatelessWidget {
  final String field;
  final String data;
  const TEXT({Key? key, required this.field, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${field} :",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Flexible(
                  child: Text(
                " ${data}",
                softWrap: false,
              )),
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: data));
                  },
                  child: Text('Copy')),
              TextButton(
                  onPressed: () {
                    launch(data);
                  },
                  child: Text('Open')),
            ],
          ),
        ],
      ),
    );
  }
}
