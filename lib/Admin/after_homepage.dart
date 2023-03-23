import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intership/Admin/addProject.dart';
import 'package:intership/Admin/addclient.dart';
import 'package:intership/Admin/adddepartment.dart';
import 'package:intership/Admin/addmanager.dart';
import 'package:intership/Admin/addoperator.dart';
import 'package:intership/Auth/CommanLoginPage.dart';
import 'package:intership/constant/ApI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intership/Admin/homepage.dart';

import 'constant.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
          "SuperAdmin",
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
        actions: [
          TextButton(
              onPressed: () async {
                Response response = await http.get(Uri.parse(adminlogout));
                if (response.statusCode == 200) {
                  print('LogOut successfully');
                  final sp = await SharedPreferences.getInstance();
                  sp.remove('cookie');
                  sp.remove('userType');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommanLoginPage(),
                      ),
                      (route) => false);
                } else {
                  return;
                }
              },
              child: const Text(
                'LogOut',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 1,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidget(
                    routename: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddManager()));
                    },
                    size: size,
                    imagename: 'manager',
                    boxcolor: kpblue,
                    boxname: 'Add Manager'),
                CustomWidget(
                  routename: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddClient()));
                  },
                  size: size,
                  boxcolor: kpred,
                  boxname: 'Add Client',
                  imagename: 'client',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidget(
                    routename: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddOperator()));
                    },
                    size: size,
                    imagename: 'operator',
                    boxcolor: kpyellow,
                    boxname: 'Add Operator'),
                CustomWidget(
                    routename: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProject()));
                    },
                    size: size,
                    imagename: 'addproject',
                    boxcolor: kpblue,
                    boxname: 'Add ProjectName'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidget(
                    routename: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddDepartment()));
                    },
                    size: size,
                    imagename: 'client',
                    boxcolor: kpred,
                    boxname: 'Add Departments'),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
