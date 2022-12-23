import 'package:flutter/material.dart';
import 'package:intership/Widget/Button.dart';
import 'package:intership/constant/color.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    icon: Icon(
                      Icons.circle_sharp,
                      size: 50,
                      color: greyColor.withOpacity(0.9),
                    ),
                    onPressed: () => {}),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    greyColor.withOpacity(0.98),
                    greyColor.withOpacity(0.98),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  border: Border.all(
                    color: const Color(0x282019).withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                // height: 250,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      // height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              whiteColor.withOpacity(0.98),
                              whiteColor.withOpacity(0.98),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        border: Border.all(
                          color: const Color(0x282019).withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const CircleAvatar(
                                  radius: 30,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[
                                    Text(
                                      "XYZ ABC PQR",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text("abc@gmail.com")
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Details of the person/employee", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold),),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Name : ", style: TextStyle(
                                    fontSize: 15
                                ),),
                                const Text("Email : ", style: TextStyle(
                                  fontSize: 15
                                ),),
                                const Text("Mobile NO : ", style: TextStyle(
                                    fontSize: 15
                                ),),
                                const Text("Organization Name : ", style: TextStyle(
                                    fontSize: 15
                                ),),
                              ],
                            ),
                          ), const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GlowingButton(
                                color1: yellowColor.withOpacity(0.99),
                                color2: yellowColor.withOpacity(0.99),
                                buttonString: 'LogOut'),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text(
                          "now theres a best way to achieve this, its ListTile."
                          " it has leading property for left side, and title and subtitle, and then for right side widgets it has trailing property.",
                          style: TextStyle(color: yellowColor.withOpacity(0.8)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GlowingButton(
                            color1: yellowColor.withOpacity(0.99),
                            color2: yellowColor.withOpacity(0.99),
                            buttonString: 'RunTime',
                          ),
                          GlowingButton(
                            color1: greenColor.withOpacity(0.8),
                            color2: greenColor.withOpacity(0.8),
                            buttonString: 'Open',
                          ),
                          GlowingButton(
                              color1: greenColor.withOpacity(0.8),
                              color2: greenColor.withOpacity(0.8),
                              buttonString: '11-11-22'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 15, top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GlowingButton(
                            color1: redColor.withOpacity(0.8),
                            color2: redColor.withOpacity(0.8),
                            buttonString: '11-11-22',
                          ),
                          GlowingButton(
                            color1: redColor.withOpacity(0.8),
                            color2: redColor.withOpacity(0.8),
                            buttonString: 'Urgent',
                          ),
                          GlowingButton(
                            color1: yellowColor.withOpacity(0.99),
                            color2: yellowColor.withOpacity(0.99),
                            buttonString: 'AddLink',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
