import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intership/constant/ApI.dart';
// import 'package:superadmin/constant.dart';
import 'model/clientmodel.dart';
import 'model/session.dart';

class ViewClient extends StatefulWidget {
  const ViewClient({Key? key}) : super(key: key);

  @override
  State<ViewClient> createState() => _ViewClientState();
}

class _ViewClientState extends State<ViewClient> {
  @override

  List<Client> managerlist = [];
  Future<List<Client>> getManager() async {
    Session _session = Session();
    final response = await _session.get(getclientlist);
    print(response);

    for (dynamic i in response['data']) {
      // print(i['email']);
      managerlist.add(Client.fromJson(i));
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
              "View Client",
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
                (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
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
                    return Container(
                      margin: EdgeInsets.all(6),
                      padding: EdgeInsets.all(10),
                      color: Color(0xff282019),
                      // color: Color(0xfffed456),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Operator Name : ${managerlist[index].name}',style: TextStyle(color: Color(0xfffed456),),),
                          Text('Email : ${managerlist[index].email}',style: TextStyle(color: Color(0xfffed456),),),
                          Text('Mobile No : ${managerlist[index].mobile}',style: TextStyle(color: Color(0xfffed456),),),
                        ],
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
