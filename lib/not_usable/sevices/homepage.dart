import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intership/constant/color.dart';
import 'package:intership/not_usable/homeContainer.dart';
import 'package:intership/not_usable/sevices/profilePage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: AppBar(

            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            title: const Center(
                child: Text(
              "My Tasks",
              style: TextStyle(fontSize: 24, color: Colors.black),
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: IconButton(
                    icon:  Icon(
                      Icons.circle_sharp,
                      size: 50,
                      color: greyColor.withOpacity(0.9),
                    ),
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => profilePage()))
                    }),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 13.0, right: 13, bottom: 50),
          child: Column(
            children: const <Widget>[
              HomeContainer(
                fontColor: blackColor,
                urgentColor: redColor,
                runtimeColor: blackColor,
                openColor: greyColor,
                BdateColor: greyColor,
                addlinkColor: blackColor,
                UdateColor: greyColor, backgrondColor: yellowColor,
              ),
              HomeContainer(
                fontColor: yellowColor,
                urgentColor: redColor,
                runtimeColor: yellowColor,
                backgrondColor: greyColor,
                openColor: greenColor,
                BdateColor: yellowColor,
                addlinkColor: yellowColor,
                UdateColor: greenColor,
              ),

              HomeContainer(
                fontColor: yellowColor,
                urgentColor: redColor,
                runtimeColor: yellowColor,
                backgrondColor: greyColor,
                openColor: greenColor,
                BdateColor: yellowColor,
                addlinkColor: yellowColor,
                UdateColor: greenColor,
              ),
              HomeContainer(
                fontColor: yellowColor,
                urgentColor: redColor,
                runtimeColor: greyColor,
                backgrondColor: blueColor,
                openColor: greenColor,
                BdateColor: redColor,
                addlinkColor: greyColor,
                UdateColor: greenColor,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: HomeContainer(
                  fontColor: blackColor,
                  urgentColor: redColor,
                  runtimeColor: greyColor,
                  backgrondColor: orangeColor,
                  openColor: greenColor,
                  BdateColor: redColor,
                  addlinkColor: greyColor,
                  UdateColor: greenColor,
                ),
              )
              ,

            ],
          ),
        ),
      ),
    );
  }
}
