import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/Operator/model/attachmodel.dart';
import 'package:intership/Operator/model/timemodel.dart';

import '../Operator/timedata.dart';
import '../constant/ApI.dart';

class TimeDataMnager extends StatefulWidget {
  const TimeDataMnager({Key? key, required this.Taskid}) : super(key: key);
  final String Taskid;

  @override
  State<TimeDataMnager> createState() => _TimeDataMnagerState();
}

class _TimeDataMnagerState extends State<TimeDataMnager> {


  bool loadingfour = false;

  List<TimeModel> completetask = [];
  Future<List<TimeModel>>
  getTimeline() async {
    // print("// Time Tasks");
    setState(() {
      loadingfour = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response =
    await _session.get('http://$ip/manager/getTimeline/${widget.Taskid}');
    // print("response $response");
    completetask.add(TimeModel.fromJson(response['data']['timeline']));

    loadingfour = false;
    setState(() {});
    return completetask;
  }


  // bool loadingfour = false;

  List<AttachModel> attachlist = [];
  Future<List<AttachModel>> getAttachline() async {
    print("// Attach Tasks");
    setState(() {
      loadingfour = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response = await _session.get('http://$ip/manager/getAttachments/${widget.Taskid}');
    print("response $response ===== >>>>>>>>  .${widget.Taskid}.");
    // print("response ${response['success'] }");
    if(response['success'] == false)
    {
      loadingfour = false;
      setState(() {});
      return attachlist;
    };
    for (dynamic i in response['data']) {
      // print(i);
      attachlist.add(AttachModel.fromJson(i));
    }
    loadingfour = false;
    setState(() {});
    return attachlist;
  }
  @override
  void initState() {
    // TODO: implement initState
    getTimeline();
    getAttachline();
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
              "TimeLine",
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
      body: loadingfour
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Text("Time Line of Task",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),),
            TEXT(
              field: 'closeDate',
              data: "${completetask[0].closeDate?.substring(0,10)}",
            ),
            TEXT(
              field: 'openDate',
              data: "${completetask[0].openDate?.substring(0,10)}",
            ),
            TEXT(
              field: 'actualCloseDate',
              data:  "${completetask[0].actualCloseDate?.substring(0,10)}" == "null" ? "Pending" : "${completetask[0].actualCloseDate?.substring(0,10)}" ,
            ),
            TEXT(
              field: 'assignationDate',
              data:"${completetask[0].managerApprovalDate?.substring(0,10)}" == "null" ? "Pending" :  "${completetask[0].assignationDate?.substring(0,10)}",
            ),
            TEXT(
              field: 'clientApprovalDate',
              data:"${completetask[0].managerApprovalDate?.substring(0,10)}" == "null" ? "Pending" : "${completetask[0].clientApprovalDate?.substring(0,10)}",
            ),
            TEXT(
              field: 'clientRejection',
              data:"${completetask[0].managerApprovalDate?.substring(0,10)}" == "null" ? "Pending" : "${completetask[0].clientRejection?.substring(0,10)}",
            ),
            TEXT(
              field: 'managerRejectionDate',
              data:"${completetask[0].managerApprovalDate?.substring(0,10)}" == "null" ? "Pending" : "${completetask[0].managerRejectionDate?.substring(0,10)}",
            ),
            TEXT(
              field: 'managerApprovalDate',
              data:"${completetask[0].managerApprovalDate?.substring(0,10)}" == "null" ? "Pending" : "${completetask[0].managerApprovalDate?.substring(0,10)}",
            ),
            attachlist.isEmpty
                ? const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 28.0),
                child: Text("No doc are attached yet",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),
                // Text("No doc are attached yet"),
              ),
            )
                : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                    child: Text("Attached Links of Task",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: attachlist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.black12,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${attachlist[index].documentName}"),
                            Text("${attachlist[index].driveLink}"),
                            TextButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: attachlist[index].driveLink));
                                },
                                child: Text('Copy')),
                          ],
                        ),
                      );

                      //   Padding(
                      //   padding: const EdgeInsets.all(0.0),
                      //   child: Container(
                      //     child: TEXT(
                      //       data: '${attachlist[index].driveLink}',
                      //       field: '${attachlist[index].documentName}',
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
