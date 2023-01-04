import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Admin/model/session.dart';
import '../constant/ApI.dart';
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
  @override
  void initState(){
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
      body: loading ? Center(child: SizedBox(height:100,width:100,child: CircularProgressIndicator())) :SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount:
                attachlist
                    .length,
                shrinkWrap:
                true,
                itemBuilder:
                    (context,
                    index) {
                  return Container(
                    color: Colors
                        .black12,
                    padding:
                    EdgeInsets.all(8),
                    margin:
                    EdgeInsets.all(6),
                    child:
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(attachlist[index].documentName),
                        Text(attachlist[index].driveLink),
                        TextButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: attachlist[index].driveLink));
                            },
                            child: Text('Copy')),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

// showDialog(
//   context: context,
//   builder:
//       (BuildContext context) {
//     return AlertDialog(
//       title: const Text(
//           "Attachment List"),
//       content: SizedBox(
//         width: 250,
//         child:
//             SingleChildScrollView(
//           child: ListView.builder(
//                   itemCount:
//                       attachlist
//                           .length,
//                   shrinkWrap:
//                       true,
//                   itemBuilder:
//                       (context,
//                           index) {
//                     return Container(
//                       color: Colors
//                           .black12,
//                       padding:
//                           EdgeInsets.all(8),
//                       margin:
//                           EdgeInsets.all(6),
//                       child:
//                           Column(
//                         crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                         children: [
//                           Text(attachlist[index].documentName),
//                           Text(attachlist[index].driveLink),
//                           TextButton(
//                               onPressed: () {
//                                 Clipboard.setData(ClipboardData(text: attachlist[index].driveLink));
//                               },
//                               child: Text('Copy')),
//                         ],
//                       ),
//                     );
//                   }),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(
//                     context)
//                 .pop();
//           },
//           child: const Text(
//               "Ok"),
//         ),
//       ],
//     );
//   },
// );