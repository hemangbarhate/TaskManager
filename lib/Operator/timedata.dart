import 'package:flutter/material.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/Operator/model/timemodel.dart';
import 'package:intership/constant/ApI.dart';
import 'package:intership/constant/color.dart';

class TimeData extends StatefulWidget {
  const TimeData({Key? key, required this.Taskid}) : super(key: key);
  final String Taskid;

  @override
  _TimeDataState createState() => _TimeDataState();
}

class _TimeDataState extends State<TimeData> {
  // operatortasktimelinebyTaskId
  bool loadingfour = false;

  List<TimeModel> completetask = [];
  Future<List<TimeModel>> getTimeline() async {
    // print("// Time Tasks");
    setState(() {
      loadingfour = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response =
        await _session.get('${operatortasktimelinebyTaskId}${widget.Taskid}');
    // print("response $response");
    // print("response ${response['data']['timeline']}");
    // for (dynamic i in response['data']) {
    //   print(i);
    completetask.add(TimeModel.fromJson(response['data']['timeline']));
    // }
    // if (completetask.length >= 1) print(completetask[0]);
    loadingfour = false;
    setState(() {});
    return completetask;
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
      // backgroundColor: greyColor.withOpacity(0.9),
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
                  TEXT(
                    field: 'closeDate',
                    data: "${completetask[0].closeDate}",
                  ),
                  TEXT(
                    field: 'openDate',
                    data: "${completetask[0].openDate}",
                  ),
                  TEXT(
                    field: 'actualCloseDate',
                    data: "${completetask[0].actualCloseDate}",
                  ),
                  TEXT(
                    field: 'assignationDate',
                    data: "${completetask[0].assignationDate}",
                  ),
                  TEXT(
                    field: 'clientApprovalDate',
                    data: "${completetask[0].clientApprovalDate}",
                  ),
                  TEXT(
                    field: 'clientRejection',
                    data: "${completetask[0].clientRejection}",
                  ),
                  TEXT(
                    field: 'managerRejectionDate',
                    data: "${completetask[0].managerRejectionDate}",
                  ),
                  TEXT(
                    field: 'managerApprovalDate',
                    data: "${completetask[0].managerApprovalDate}",
                  ),
                ],
              ),
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
      child: Row(
        children: [
          Text(
            "${field} :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(" ${data}"),
        ],
      ),
    );
  }
}
