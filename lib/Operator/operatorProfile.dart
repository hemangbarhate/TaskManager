import 'package:flutter/material.dart';

import '../constant/color.dart';

class OperatorProfile extends StatefulWidget {
  const OperatorProfile({Key? key}) : super(key: key);

  @override
  _OperatorProfileState createState() => _OperatorProfileState();
}

class _OperatorProfileState extends State<OperatorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
              "Operator Profile",
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                backgroundColor: greyColor.withOpacity(0.9),
                radius: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.grey[200],
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  height: 45,
                  width: 250,
                  child: Center(
                    child: Text(
                      "Dhiraj Darakhe ",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 45,
                  width: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "🙂 :  Operator ",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),  Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 6, left: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 45,
                  width: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "📱 :    7218724337 ",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 6, left: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 45,
                  width: 350,
                  child: Center(
                    child: Text(
                      "📧 : dhirajdarakhe03@gmail.com ",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(38.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          greyColor.withOpacity(0.7),
                          greyColor.withOpacity(0.7)
                          // Colors.teal[200],
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          'LogOut',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
