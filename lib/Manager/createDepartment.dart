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
Map<String, dynamic> _portaInfoMap = {
  "name": "Vitalflux.com",
  "domains": ["Data Science", "Mobile", "Web"],
  "noOfArticles": [
    {"type": "data science", "count": 50},
    {"type": "web", "count": 75}
  ]
};
class _CreateDeptState extends State<CreateDept> {
  PortalInfo portalInfo =  PortalInfo.fromJson(_portaInfoMap);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: greyColor.withOpacity(0.1),
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
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
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: IconButton(
                  icon: Icon(
                    Icons.circle_sharp,
                    size: 40,
                    color: greyColor.withOpacity(0.9),
                  ),
                  onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ManagerProfile()))
                      }),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
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
                        Padding(
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
                            padding: const EdgeInsets.all(8.0),
                            child: const ListTile(
                              title: Text("App Department"),
                              subtitle: Text("10 Operator"),
                              leading: CircleAvatar(
                                child: Text(''),
                              ),
                            ),
                          ),
                        ),
                        Padding(
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
                            padding: const EdgeInsets.all(8.0),
                            child: const ListTile(
                              title: Text("Web Development"),
                              subtitle: Text("06 Operator"),
                              leading: CircleAvatar(
                                child: Text(''),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                              const SizedBox(  height: 10,  ),
                              // TextFormField(
                              //   style: const TextStyle(color: Colors.black),
                              //   decoration: const InputDecoration(
                              //     icon: Icon(
                              //       Icons.search,
                              //       color: Colors.black,
                              //     ),
                              //     hintText: 'App Developers',
                              //     hintStyle: TextStyle(color: Colors.grey),
                              //     labelText: 'Department',
                              //     labelStyle: TextStyle(color: Colors.grey),
                              //     border: OutlineInputBorder(
                              //         borderSide: BorderSide(color: Colors.black)),
                              //   ),
                              //   validator: (value) {
                              //     if (value != null && value.length < 1) {
                              //       return 'This field cant be null';
                              //     }
                              //     return null;
                              //   },
                              // ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _portaInfoMap.length,
                            itemBuilder: (context,index){
                              return  Padding(
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
                                  padding:  EdgeInsets.all(8.0),
                                  child:  ListTile(
                                    title: Text(portalInfo.domains![index].toString()),
                                    subtitle: Text("06 Operator"),
                                    leading: CircleAvatar(
                                      child: Text(''),
                                    ),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: yellowColor.withOpacity(0.9),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddDepatmentOpearator()));
          },
          child: Icon(Icons.add
            ,color: greyColor,size: 30,),
        ),
      ),
    );
  }
}


class PortalInfo {
  final String? name;
  final List<String>? domains;
  final List<Object>? noOfArtcles;

  PortalInfo({
    this.name,
    this.domains,
    this.noOfArtcles
  });

  factory PortalInfo.fromJson(Map<String, dynamic> parsedJson){
    return PortalInfo(
        name: parsedJson['name'],
        domains : parsedJson['domains'],
        noOfArtcles : parsedJson ['noOfArticles']
    );
  }
}