import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intership/Manager/ConatainerHelper/ManagerContainer.dart';
import 'package:intership/Manager/createTask.dart';
import 'package:intership/Manager/managerProfile.dart';
import 'package:intership/constant/color.dart';
import 'package:intership/Manager/ConatainerHelper/ClientContainer.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // backgroundColor: greyColor.withOpacity(0.1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title: const Center(
              child: Text(
            "Tasks",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          )),
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: IconButton(
                    icon: Image.asset("assets/images/bigmouth_icon.png"),
                    iconSize: 70,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                ),
              );
            },
              // assets/images/
          ),
          actions: <Widget>[
            Padding(
              padding:  EdgeInsets.only(right: 18.0),
              child: Container(
                height: 25,
                  child: CircleAvatar(

                      child:
                    Image.asset("assets/images/download.png")
                    ),
              )
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width-2,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Reque..',
                    ),
                    Tab(
                      text: 'Assig..',
                    ),
                    Tab(
                      text: 'InProg..',
                    ),
                    Tab(
                      text: 'Compl..',
                    )
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: const <Widget>[
                        ClientContainer(
                          fontColor: greyColor,
                          backgrondColor: greenColor,
                          first: yellowColor,
                          second: blackColor,
                          third: greenColor,
                          forth: redColor,
                          fifth: redColor,
                          sixth: yellowColor,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: const <Widget>[
                        ClientContainer(
                          fontColor: greyColor,
                          backgrondColor: orangeColor, first: greyColor,
                          second: greenColor,third: greenColor,
                          forth: redColor,
                          fifth: redColor,
                          sixth: greyColor,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: const <Widget>[
                        ClientContainer(
                          fontColor: yellowColor,
                          backgrondColor: blueColor
                          ,first: greyColor,
                          second: greenColor,third: greenColor,
                          forth: redColor,
                          fifth: redColor,
                          sixth: greyColor,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: const <Widget>[
                        ClientContainer(
                          fontColor: greyColor,
                          backgrondColor: yellowColor
                          ,first: greyColor,
                          second: greenColor,third: greenColor,
                          forth: redColor,
                          fifth: redColor,
                          sixth: greyColor,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // foregroundColor: Colors.blueAccent,
          backgroundColor: yellowColor.withOpacity(0.9),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CreateTask()));
          },
          child: Icon(Icons.add
          ,color: greyColor,size: 30,),
        ),
      ),
    );
  }
}
