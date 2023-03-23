import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intership/Admin/Report/managerReport.dart';
import 'package:intership/Admin/addoperator.dart';
import 'package:intership/constant/ApI.dart';
// import 'package:superadmin/constant.dart';
import 'editoperator.dart';
import 'model/operatormodel.dart';
import 'model/session.dart';

class ViewOperator extends StatefulWidget {
  const ViewOperator({Key? key}) : super(key: key);

  @override
  State<ViewOperator> createState() => _ViewOperatorState();
}

class _ViewOperatorState extends State<ViewOperator> {
  @override
  List<Client> managerlist = [];
  Future<List<Client>> getManager() async {
    managerlist.clear();
    Session _session = Session();
    final response = await _session.get(getoperatorlist);
    print(response);

    for (dynamic i in response['data']) {
      // print(i['email']);
      managerlist.add(Client.fromJson(i));
    }
    print(managerlist.length);
    return managerlist;
  }

  List<Client> deactivatedlist = [];
  Future<List<Client>> getDeactivatedOperator() async {
    deactivatedlist.clear();
    Session _session = Session();
    final response = await _session.get(getdeactivatedoperatorlist);
    print(response);

    for (dynamic i in response['data']) {
      // print(i['email']);
      deactivatedlist.add(Client.fromJson(i));
    }
    return deactivatedlist;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          shadowColor: Colors.white,
          title: Container(
              child: const Text(
            "View Operator",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          )),
          elevation: 0.0,
          leading: Builder(builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: IconButton(
                  icon: const Icon(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        text: 'Active',
                      ),
                      Tab(
                        text: 'Inactive',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: getManager(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Client>> snapshot) {
                              if (!snapshot.hasData) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 50, bottom: 50),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 30),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: managerlist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          print('${managerlist[index].name}');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      mnagerReport(
                                                        managerID:
                                                            managerlist[index]
                                                                .operatorId,
                                                        report:
                                                            'operatorReports',
                                                      )));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(6),
                                          padding: EdgeInsets.all(12),
                                          color: Colors.black12,
                                          // color: Color(0xfffed456),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "$ip/admin/getOperatorProfilePic/${managerlist[index].operatorId}"),
                                            ),
                                            title: Text(
                                              managerlist[index].name,
                                            ),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  managerlist[index].email,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(managerlist[index].mobile)
                                              ],
                                            ),
                                            trailing: Wrap(
                                              spacing: 0,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditOperator(
                                                                      operator:
                                                                          managerlist[
                                                                              index])));
                                                    },
                                                    icon: Icon(Icons.edit)),
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Really ??"),
                                                          content: const Text(
                                                              "Do you want to Deactivate this Operator"),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
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
                                                                Session
                                                                    _session =
                                                                    Session();
                                                                var res =
                                                                    await _session
                                                                        .get(
                                                                            "$ip/admin/deleteOperator/${managerlist[index].operatorId}");
                                                                setState(() {});
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
                                                  icon: Icon(Icons.delete),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: getDeactivatedOperator(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Client>> snapshot) {
                              if (!snapshot.hasData) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 50, bottom: 50),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 30),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: deactivatedlist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          print(
                                              '${deactivatedlist[index].name}');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      mnagerReport(
                                                        managerID:
                                                            deactivatedlist[
                                                                    index]
                                                                .operatorId,
                                                        report:
                                                            'operatorReports',
                                                      )));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(6),
                                          padding: EdgeInsets.all(12),
                                          color: Colors.black12,
                                          // color: Color(0xfffed456),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "$ip/admin/getOperatorProfilePic/${deactivatedlist[index].operatorId}"),
                                            ),
                                            title: Text(
                                              deactivatedlist[index].name,
                                            ),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  deactivatedlist[index].email,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(deactivatedlist[index]
                                                    .mobile)
                                              ],
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Really ??"),
                                                      content: const Text(
                                                          "Do you want to Reactivate this Operator"),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text("No"),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            Session _session =
                                                                Session();
                                                            var res =
                                                                await _session.get(
                                                                    "$ip/admin/activateOperator/${deactivatedlist[index].operatorId}");
                                                            setState(() {});
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text("Yes"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(Icons.restart_alt),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddOperator()));
          },
          label: Text(
            'Add Operator',
            style: TextStyle(fontSize: 11),
          ),
          icon: Icon(Icons.add),
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }
}
