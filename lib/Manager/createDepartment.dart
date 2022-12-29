
import 'package:flutter/material.dart';
import 'package:intership/Manager/AddDepatmentOpearator.dart';
import 'package:intership/Manager/ConatainerHelper/ManagerContainer.dart';
import 'package:intership/Manager/managerProfile.dart';
import 'package:intership/constant/color.dart';
import 'package:intership/Manager/ConatainerHelper/ClientContainer.dart';

class CreateDept extends StatefulWidget {
  const CreateDept({Key? key}) : super(key: key);

  @override
  _CreateDeptState createState() => _CreateDeptState();
}

class _CreateDeptState extends State<CreateDept> {
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
                  "Add Tasks Helper",
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
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
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
                        text: 'View Department',
                      ),
                      Tab(
                        text: 'View Operator',
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                      children: [
                       SingleChildScrollView(
                         child: Column(
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: ListTile(
                                 title: Text("App development"),
                                 subtitle: Text("10 Operaotr"),
                                 leading: CircleAvatar(
                                   child: Text(''),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: ListTile(
                                 title: Text("Web development"),
                                 subtitle: Text("10 Operaotr"),
                                 leading: CircleAvatar(
                                   child: Text(''),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: ListTile(
                                 title: Text("Web_App development"),
                                 subtitle: Text("10 Operaotr"),
                                 leading: CircleAvatar(
                                   child: Text(''),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: ListTile(
                                 title: Text("Robo development"),
                                 subtitle: Text("10 Operaotr"),
                                 leading: CircleAvatar(
                                   child: Text(''),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text("Operator 1"),
                                  subtitle: Text("Department"),
                                  leading: CircleAvatar(
                                    child: Text(''),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text("Operator 2"),
                                  subtitle: Text("Department"),
                                  leading: CircleAvatar(
                                    child: Text(''),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text("Operator 3"),
                                  subtitle: Text("Department"),
                                  leading: CircleAvatar(
                                    child: Text(''),
                                  ),
                                ),
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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddDepatmentOpearator()));
          },
          child: Icon(Icons.add),
        ),),
    );
  }
}
