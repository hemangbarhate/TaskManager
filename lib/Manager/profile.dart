import 'package:flutter/material.dart';

import '../constant/color.dart';

class ManagerProfile extends StatefulWidget {
  const ManagerProfile({Key? key}) : super(key: key);

  @override
  _ManagerProfileState createState() => _ManagerProfileState();
}

class _ManagerProfileState extends State<ManagerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title:  Container(
            child: const Text(
          "Manager Profile",
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

      ),
    );
  }
}
