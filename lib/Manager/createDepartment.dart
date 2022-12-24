import 'package:flutter/material.dart';
import 'package:intership/constant/color.dart';

class CreateDept extends StatefulWidget {
  const CreateDept({Key? key}) : super(key: key);

  @override
  _CreateDeptState createState() => _CreateDeptState();
}

class _CreateDeptState extends State<CreateDept> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title:  Container(
            child: const Text(
              "Add Department",
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
