import 'package:flutter/material.dart';
import 'package:intership/Client/viewclienttask.dart';
import 'package:intership/Client/createtask.dart';
import '../constant/color.dart';
import 'clientprofile.dart';

class home_client extends StatefulWidget {
  const home_client({Key? key}) : super(key: key);

  @override
  State<home_client> createState() => _home_clientState();
}

class _home_clientState extends State<home_client> {
  int _ixd  = 0;

  final tabs= [
    ViewTask(),
    CreateTask(),
    ClientProfile(),
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
            label: "View",
            backgroundColor: blueColor,
          ),
          BottomNavigationBarItem(
            label: "Add",
            icon: Icon(Icons.add),
            backgroundColor: redColor,
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle),
            backgroundColor: Colors.blue,
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
