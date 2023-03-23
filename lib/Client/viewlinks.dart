import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Admin/model/session.dart';
import '../constant/ApI.dart';
import '../constant/color.dart';
import 'clientprofile.dart';
import 'model/AttachmentModel.dart';

class ViewLinks extends StatefulWidget {
  const ViewLinks({Key? key, required this.taskid}) : super(key: key);
  final String taskid;

  @override
  State<ViewLinks> createState() => _ViewLinksState();
}

class _ViewLinksState extends State<ViewLinks> {
  bool loading = false;
  List<AttachmentModel> attachlist = [];
  Future<List<AttachmentModel>> getattachments(String taskid) async {
    setState(() {
      loading = true;
    });
    Session _session = Session();
    print('$getlinks/$taskid');
    final response = await _session.get('$getlinks/$taskid');
    print(response);
    if (response["success"] == true) {
      for (dynamic i in response['data']) {
        print(i);
        attachlist.add(AttachmentModel.fromJson(i));
      }
    } else {
      attachlist.add(AttachmentModel(
          "Failed", taskid, 'No attachments found', 'No attachment found'));
    }
    log('message');
    setState(() {
      loading = false;
    });
    return attachlist;
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
      return response;
    } catch (e) {
      print(e.toString());
    }
  }


  // Future<void> _launchUrl(String url) async {
  //   final Uri _url = Uri.parse('https://flutter.dev');
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }
  @override
  void initState() {
    getattachments(widget.taskid);
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
          "Attachments",
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
          // assets/images/
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ClientProfile()));
                },
                child: Container(
                  height: 25,
                  child: CircleAvatar(
                      child: Image.asset("assets/images/download.png")),
                ),
              ))
        ],
      ),
      body: loading
          ? MyLoading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: attachlist.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.black12,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(attachlist[index].documentName),
                              Text(attachlist[index].driveLink,softWrap: false,),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text: attachlist[index].driveLink));
                                      },
                                      child: Text('Copy')),
                                  TextButton(
                                      onPressed: () {
                                        launch(attachlist[index].driveLink);
                                      },
                                      child: Text('Open')),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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
                          labelText: 'Link',
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context)
                          .pop();
                    },
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () async {
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
                          content: const Text(
                              "Enter doc"),
                          backgroundColor:
                          (Colors.black
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
                        ScaffoldMessenger
                            .of(context)
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
                            widget.taskid);
                        docnamecontroller
                            .clear();
                        linkcontroller
                            .clear();
                        print(
                            'dcccscsdc$response');
                        Navigator.of(
                            context)
                            .pop();
                        setState(() {
                          attachlist.clear();
                          getattachments(widget.taskid);
                        });
                      }
                    },
                    child:
                    const Text("Yes"),
                  ),
                ],
              );
            },
          );
        },
        label: Text('Add Links'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
