import 'package:flutter/material.dart';
import 'package:intership/Admin/addProject.dart';
import 'package:intership/Admin/editproject.dart';
import 'package:intership/constant/ApI.dart';
import 'package:intership/Admin/model/session.dart';
import 'model/projectnamemodel.dart';

class ViewProject extends StatefulWidget {
  const ViewProject({Key? key}) : super(key: key);

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  List<ProjectName> activeProject = [];
  List<ProjectName> inactiveProject = [];

  Future<List<ProjectName>> getactiveProjectName() async {
    activeProject.clear();

    Session _session = Session();
    final response = await _session.get('$ip/admin/getProjects');
    print(response);

    for (dynamic i in response['data']) {
      activeProject.add(ProjectName.fromJson(i));
    }
    return activeProject;
  }

  Future<List<ProjectName>> getinactiveProjectName() async {
    inactiveProject.clear();

    Session _session = Session();
    final response = await _session.get('$ip/admin/getDeactivatedProjects');

    for (dynamic i in response['data']) {
      inactiveProject.add(ProjectName.fromJson(i));
    }
    return inactiveProject;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          shadowColor: Colors.white,
          title: Container(
              child: const Text(
            "View ProjectName",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          )),
          elevation: 0.0,
          leading: Builder(builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            );
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width - 2,
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
                      text: 'Active',
                    ),
                    Tab(
                      text: 'Inactive',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: getactiveProjectName(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ProjectName>> snapshot) {
                              if (!snapshot.hasData) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 50, bottom: 50),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 30),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: activeProject.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        color: Colors.black12,
                                        padding: EdgeInsets.all(12),
                                        margin: EdgeInsets.all(6),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              "$ip/admin/getProjectIcon/${activeProject[index].projectId}",
                                            ),
                                          ),
                                          title: Text(
                                            "${activeProject[index].projectName}",
                                          ),
                                          trailing: Wrap(
                                            spacing: 0,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditProject(
                                                                    project:
                                                                        activeProject[
                                                                            index])));
                                                  },
                                                  icon: Icon(Icons.edit)),
                                              IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Really ??"),
                                                        content: const Text(
                                                            "Do you want to Deactivate this ProjectName"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "No"),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              Session _session =
                                                                  Session();
                                                              var res =
                                                                  await _session
                                                                      .get(
                                                                          "$ip/admin/deleteProject/${activeProject[index].projectId}");
                                                              setState(() {});
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Yes"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: getinactiveProjectName(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ProjectName>> snapshot) {
                              if (!snapshot.hasData) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 50, bottom: 50),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 30),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: inactiveProject.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        color: Colors.black12,
                                        padding: EdgeInsets.all(12),
                                        margin: EdgeInsets.all(6),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              "$ip/admin/getProjectIcon/${inactiveProject[index].projectId}",
                                            ),
                                          ),
                                          title: Text(
                                            "${inactiveProject[index].projectName}",
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text("Really ??"),
                                                    content: const Text(
                                                        "Do you want to Reactivate this ProjectName"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text("No"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          Session _session =
                                                              Session();
                                                          var res =
                                                              await _session.get(
                                                                  "$ip/admin/activateProject/${inactiveProject[index].projectId}");
                                                          setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text("Yes"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.restart_alt),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProject()));
          },
          label: Text(
            'Add Project',
            style: TextStyle(fontSize: 11),
          ),
          icon: Icon(Icons.add),
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }
}
