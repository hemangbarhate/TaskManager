import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intership/Manager/ConatainerHelper/ManagerContainer.dart';
import 'package:intership/Manager/managerProfile.dart';
import 'package:intership/constant/color.dart';
import 'package:intership/Manager/ConatainerHelper/ClientContainer.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: greyColor.withOpacity(0.1),
          appBar: AppBar(
                backgroundColor:  Colors.grey[200],
                shadowColor: Colors.white,
                title: const Center(
                    child: Text(
                      "Tasks 1",
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.black),
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

                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: IconButton(
                        icon:  Icon(
                          Icons.circle_sharp,
                          size: 40,
                          color: greyColor.withOpacity(0.9),
                        ),
                        onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ManagerProfile()))
                        }),
                  )
                ],
              ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 45,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.circular(25.0)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'Client Request',
                      ),
                      Tab(
                        text: 'Operator',
                      )
                    ],
                  ),
                ),
                 Expanded(
                    child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                       children: const <Widget> [
                         ClientContainer(
                           fontColor: greyColor,
                           backgrondColor: greenColor,
                         ),
                         ClientContainer(
                           fontColor: greyColor,
                           backgrondColor: greenColor,
                         ),
                         ClientContainer(
                           fontColor: greyColor,
                           backgrondColor: greenColor,
                         )
                       ],
                      ),
                    ),
                    SingleChildScrollView(
          child: Column(
            children: const <Widget> [
              ManagerContainer(
                fontColor: greyColor,
                backgrondColor: blueColor,
              ),
              ManagerContainer(
                fontColor: greyColor,
                backgrondColor: redColor,
              ),
              ManagerContainer(
                fontColor: greyColor,
                backgrondColor: blueColor,
              ),

            ],
          ),
        ),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
