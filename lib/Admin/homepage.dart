import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intership/Admin/addProject.dart';
import 'package:intership/Admin/addclient.dart';
import 'package:intership/Admin/addmanager.dart';
import 'package:intership/Admin/addoperator.dart';
import 'package:intership/Admin/after_homepage.dart';
import 'package:intership/Admin/constant.dart';
import 'package:intership/Admin/viewProject.dart';
import 'package:intership/Admin/viewclient.dart';
import 'package:intership/Admin/viewmanager.dart';
import 'package:intership/Admin/viewoperator.dart';
import 'package:intership/constant/ApI.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/CommanLoginPage.dart';
import 'viewdepartment.dart';
// import 'package:superadmin/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     CustomWidget(
            //         routename: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => AddManager()));
            //         },
            //         size: size,
            //         imagename: 'manager',
            //         boxcolor: kpblue,
            //         boxname: 'Add Manager'),
            //     CustomWidget(
            //       routename: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => AddClient()));
            //       },
            //       size: size,
            //       boxcolor: kpred,
            //       boxname: 'Add Client',
            //       imagename: 'client',
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     CustomWidget(
            //         routename: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => AddOperator()));
            //         },
            //         size: size,
            //         imagename: 'operator',
            //         boxcolor: kpyellow,
            //         boxname: 'Add Operator'),
            //     CustomWidget(
            //         routename: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => AddProject()));
            //         },
            //         size: size,
            //         imagename: 'addproject',
            //         boxcolor: kpblue,
            //         boxname: 'Add ProjectName'),
            //   ],
            // ),
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
                              builder: (context) => ViewManager()));
                    },
                    size: size,
                    imagename: 'manager',
                    boxcolor: kpred,
                    boxname: 'View Managers'),
                CustomWidget(
                  routename: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewClient()));
                  },
                  size: size,
                  boxcolor: kpblue,
                  boxname: 'View Clients',
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
                              builder: (context) => ViewOperator()));
                    },
                    size: size,
                    imagename: 'operator',
                    boxcolor: kpyellow,
                    boxname: 'View Operators'),
                CustomWidget(
                    routename: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewProject()));
                    },
                    size: size,
                    imagename: 'addproject',
                    boxcolor: kpblue,
                    boxname: 'View ProjectName'),
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
                              builder: (context) => ViewDepartment()));
                    },
                    size: size,
                    imagename: 'client',
                    boxcolor: kpred,
                    boxname: 'View Departments'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScreen()));
        },
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    Key? key,
    required this.routename,
    required this.size,
    required this.imagename,
    required this.boxcolor,
    required this.boxname,
  }) : super(key: key);

  final VoidCallback routename;
  final Size size;
  final imagename;
  final boxcolor;
  final boxname;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: routename,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: size.height / 6,
            width: size.width / 2.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  // assets/images/bigmouth_icon.png
                  image: AssetImage('assets/images/$imagename.png'),
                  fit: BoxFit.cover),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            width: size.width / 2.3,
            height: 25,
            decoration: BoxDecoration(
                color: boxcolor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Center(
                child: Text(
              '$boxname',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ),
        ],
      ),
    );
  }
}
