import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intership/Admin/Report/managerReport.dart';
import 'package:intership/constant/ApI.dart';
// import 'package:superadmin/constant.dart';
import 'model/managermodel.dart';
import 'model/session.dart';

class ViewManager extends StatefulWidget {
  const ViewManager({Key? key}) : super(key: key);

  @override
  State<ViewManager> createState() => _ViewManagerState();
}

class _ViewManagerState extends State<ViewManager> {
  @override

  List<Operator> managerlist = [];
  Future<List<Operator>> getManager() async {
    managerlist.clear();
    Session _session = Session();
    final response = await _session.get(getmanagerlist);
    print(response);

    for (dynamic i in response['data']) {
      // print(i['email']);
      managerlist.add(Operator.fromJson(i));
    }
    print(managerlist.length);
    return managerlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
          "View Manager",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        )),
        elevation: 0.0,
        leading: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          );
        }),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: getManager(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Operator>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                      height: 75,
                      width: 75,
                      child: CircularProgressIndicator()),
                );
              } else {
                return ListView.builder(
                  itemCount: managerlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: ()
                      {
                        print('${managerlist[index].name}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                 mnagerReport(managerID: managerlist[index].managerId,
                                   report: 'managerReports',
                                )));
                      },
                      child: Container(
                        color: Colors.black12,
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(6),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "http://$ip/admin/getManagerProfilePic/${managerlist[index].managerId}"
                            ),
                          ),
                          title: Text(
                            managerlist[index].name,
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(managerlist[index].email, overflow: TextOverflow.ellipsis,),
                              Text(managerlist[index].mobile)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )),
    );
  }
}
