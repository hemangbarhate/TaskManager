import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intership/Admin/constant.dart';
import 'package:intership/constant/ApI.dart';
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
                Response response =
                    await http.get(Uri.parse(adminlogout));
                if (response.statusCode == 200) {
                  print('LogOut successfully');
                  Navigator.pop(context);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidget(routename: 'AddManager', size: size, imagename: 'manager', boxcolor: kpblue, boxname: 'Add Manager'),
                CustomWidget(routename: 'AddClient', size: size, boxcolor: kpred, boxname: 'Add Client', imagename: 'client',),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidget(routename: 'AddOperator', size: size, imagename: 'operator', boxcolor: kpyellow, boxname: 'Add Operator'),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 1,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidget(routename: 'ViewManager', size: size, imagename: 'manager', boxcolor: kpred, boxname: 'View Managers'),
                CustomWidget(routename: 'ViewClient', size: size, boxcolor: kpblue, boxname: 'View Clients', imagename: 'client',),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidget(routename: 'ViewOperator', size: size, imagename: 'operator', boxcolor: kpyellow, boxname: 'View Operators'),
              ],
            ),
          ],
        ),
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

  final routename;
  final Size size;
  final imagename;
  final boxcolor;
  final boxname;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '$routename');
      },
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
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            width: size.width / 2.3,
            height: 25,
            decoration: BoxDecoration(
                color: boxcolor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Center(
                child: Text(
              '$boxname',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ),
        ],
      ),
    );
  }
}
