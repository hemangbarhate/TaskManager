import 'package:flutter/material.dart';
import 'package:intership/Manager/createDepartment.dart';
import 'package:intership/Manager/managerProfile.dart';
import 'package:intership/Manager/managerViewtask.dart';
import 'package:intership/Operator/operatorProfile.dart';
import 'package:intership/Operator/operatorViewtask.dart';
import 'package:intership/constant/color.dart';

class home_operator extends StatefulWidget {
  const home_operator({Key? key}) : super(key: key);

  @override
  _home_operatorState createState() => _home_operatorState();
}

class _home_operatorState extends State<home_operator> {
  int _ixd = 0;

  final tabs = [
    OperatorVIewTasks(),
    OperatorProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_ixd],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _ixd,
        backgroundColor: yellowColor.withOpacity(1),
        iconSize: 30,
        // backgroundColor: greyColor.withOpacity(0.8),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "ViewTasks",
            backgroundColor: blueColor,
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle),
            backgroundColor: blueColor,
          ),
        ],
        onTap: (indx) {
          setState(() {
            _ixd = indx;
          });
        },
      ),
    );
  }
}
