import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/Operator/model/attachmodel.dart';

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
    final response = await _session
        .get('http://$ip/operator/getAttachments/${widget.Taskid}');
    print("response $response");
    print("response ${response['success'] }");
    if(response['success'] == false)
      {
        loadingfour = false;
        setState(() {});
        return completetask;
      };
    for (dynamic i in response['data']) {
      // print(i);
      completetask.add(AttachModel.fromJson(i));
    }
    if (completetask.length >= 1) print(completetask[0]);
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
              Flexible(child: Text(" ${data}")),
            ],
          ),
          TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(
                    text: data));
              },
              child: Text('Copy')),
        ],
      ),
    );
  }
}
