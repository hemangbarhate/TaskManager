import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/Admin/model/operatormodel.dart';
import 'package:intership/Manager/AddDepatmentOpearator.dart';
import 'package:intership/Manager/ConatainerHelper/ManagerContainer.dart';
import 'package:intership/Manager/managerProfile.dart';
import 'package:intership/Manager/model/operatormodel.dart';
import 'package:intership/constant/color.dart';
import 'package:intership/Manager/ConatainerHelper/ClientContainer.dart';

import '../constant/ApI.dart';

class CreateDept extends StatefulWidget {
  const CreateDept({Key? key}) : super(key: key);

  @override
  _CreateDeptState createState() => _CreateDeptState();
}

Map<String, dynamic> _portaInfoMap = {
  "name": "Vitalflux.com",
  "domains": ["Data Science", "Mobile", "Web"],
  "noOfArticles": [
    {"type": "data science", "count": 50},
    {"type": "web", "count": 75}
  ]
};

List<String> departlist = [];
List<String> departlistID = [];
List<Client> operaortlist = [];
// List<String> opeindexlist = [];
List<dynamic> operaortprofilelist = [];

class _CreateDeptState extends State<CreateDept> {
  var profileImage1;
  PortalInfo portalInfo = PortalInfo.fromJson(_portaInfoMap);
  bool loadingofsecond = false;
  bool loadingofirst = false;
  @override
  void initState() {
    print("init state called\n\n");
    getDetp();
    getOperator();
    super.initState();
  }

  getProfileImage(String operatorId) async {
    Session _session = Session();
    profileImage1 = await _session
        .getprofileImage("http://$ip/manager/getOperatorProfilePic/$operatorId");
    operaortprofilelist.add(profileImage1);
    // print("aaaaa ${operaortprofilelist.length}");
    setState(() {});
  }

  getDetp() async {
    departlistID.clear();
    departlist.clear();

    setState(() {
      loadingofirst = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response =
        await _session.get('http://$ip/manager/getDepartments');

    for (dynamic i in response['data']['departments']) {
      // print('OK : ${i['departmentName']}');
      if (!departlist.contains(i['departmentName'])) {
        departlist.add(i['departmentName']);
        departlistID.add(i['departmentId']);
      }
    }
    // print(departlist.length);
    loadingofirst = false;
    setState(() {
      if(operaortlist.length == 0) getOperator();
    });
  }

  Future<List<Client>> getOperator() async {
    operaortprofilelist.clear();
    operaortlist.clear();
    setState(() {
      loadingofsecond = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    for (String i in departlistID) {
      print(i);
      final response =
          await _session.get('http://$ip/manager/getOperators/$i');
      for (dynamic i in response['data']['operators']) {
        if (!operaortlist.contains(i['name'])) {
          operaortlist.add(Client.fromJson(i));
          await getProfileImage(i['operatorId']);
        }
      }
    }

    setState(() {
      loadingofsecond = false;
    });
    return operaortlist;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: creamColor2.withOpacity(0.1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title: const Center(
              child: Text(
            "Add Tasks Helper",
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
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: Colors.grey[800],
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
                          const SizedBox(
                            height: 10,
                          ),
                          loadingofirst
                              ? Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: Center(
                            child: CircularProgressIndicator(
                                color: blackColor.withOpacity(1),
                            ),
                          ),
                              )
                         : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: departlist.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        yellowColor.withOpacity(0.9),
                                        yellowColor.withOpacity(0.9),
                                        // Colors.teal[200],
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(5, 5),
                                        blurRadius: 10,
                                      )
                                    ],
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(departlist[index]),
                                    leading: CircleAvatar(
                                      child: Icon(Icons.shopping_bag_outlined),
                                    )
                                    ,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          loadingofsecond
                              ? Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                                child: Center(
                                    child: CircularProgressIndicator(
                                      color: blackColor.withOpacity(1),
                                    ),
                                  ),
                              )
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: operaortlist.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              yellowColor.withOpacity(0.9),
                                              yellowColor.withOpacity(0.9),
                                              // Colors.teal[200],
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(5, 5),
                                              blurRadius: 10,
                                            )
                                          ],
                                        ),
                                        padding: EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: Text(operaortlist[index].name),
                                          subtitle: Text(operaortlist[index].email),
                                          leading: operaortprofilelist[index] == null
                                              ? Image.asset("assets/images/download.png")
                                              : CircleAvatar(
                                            backgroundImage: MemoryImage(
                                              operaortprofilelist[index],
                                              // profileImage1
                                            ),
                                          ),
                                          trailing: IconButton(onPressed: () async {

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Really ??"),
                                                  content: const Text(
                                                      "Do you want to Delete this Operator"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text("No"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Session _session = Session();
                                                        await _session.get("http://$ip/manager/deleteOperator/${operaortlist[index].operatorId}");
                                                        setState(() {
                                                          getDetp();
                                                          getOperator();
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text("Yes"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }, icon: Icon(Icons.delete)),
                                        ),
                                      ),
                                    );
                                  })
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent.withOpacity(1),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddDepatmentOpearator()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class PortalInfo {
  final String? name;
  final List<String>? domains;
  final List<Object>? noOfArtcles;

  PortalInfo({this.name, this.domains, this.noOfArtcles});

  factory PortalInfo.fromJson(Map<String, dynamic> parsedJson) {
    return PortalInfo(
        name: parsedJson['name'],
        domains: parsedJson['domains'],
        noOfArtcles: parsedJson['noOfArticles']);
  }
}
