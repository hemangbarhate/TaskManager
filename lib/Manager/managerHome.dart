import 'package:flutter/material.dart';
import 'package:intership/Manager/createDepartment.dart';
import 'package:intership/Manager/profile.dart';
import 'package:intership/Manager/viewtask.dart';
import 'package:intership/constant/color.dart';

class home_manager extends StatefulWidget {
  const home_manager({Key? key}) : super(key: key);

  @override
  _home_managerState createState() => _home_managerState();
}

class _home_managerState extends State<home_manager> {
  int _ixd  = 0;

  final tabs= [
    ViewTask(),
    CreateDept(),
    ManagerProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_ixd],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _ixd,
        backgroundColor: Colors.grey[300],
        iconSize: 30,
        // backgroundColor: greyColor.withOpacity(0.8),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "View",
            backgroundColor: blueColor,
          ),
          BottomNavigationBarItem(
            label: "Add",
            icon: Icon(Icons.add),
            backgroundColor: blueColor,
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.home),
            backgroundColor: blueColor,
          ),
        ],
        onTap: (indx)
        {
          setState(() {
            _ixd = indx;
          });
        },
      ),
    );
  }
}
