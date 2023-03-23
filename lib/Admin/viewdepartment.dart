import 'package:flutter/material.dart';
import 'package:intership/Admin/model/departmentmodel.dart';
import 'package:intership/Admin/model/session.dart';
import '../constant/ApI.dart';
import '../constant/color.dart';
import 'adddepartment.dart';
import 'editdepartment.dart';

class ViewDepartment extends StatefulWidget {
  const ViewDepartment({Key? key}) : super(key: key);

  @override
  State<ViewDepartment> createState() => _ViewDepartmentState();
}

class _ViewDepartmentState extends State<ViewDepartment> {
  @override
  void initState() {
    print("init state called\n\n");
    getDetp();
    super.initState();
  }

  bool loadingofirst = false;
  List<Department> deptlist = [];
  // List<String> departlist = [];
  // List<String> departlistID = [];

  getDetp() async {
    // departlistID.clear();
    // departlist.clear();
    deptlist.clear();

    setState(() {
      loadingofirst = true; //make loading true to show progressindicator
    });
    Session _session = Session();
    final response = await _session.get('$ip/admin/getDepartments');

    for (dynamic i in response['data']['departments']) {
      // print('OK : ${i['departmentName']}');
      deptlist.add(Department.fromJson(i));
      // if (!departlist.contains(i['departmentName'])) {
      //   departlist.add(i['departmentName']);
      //   departlistID.add(i['departmentId']);
      // }
    }
    // print(departlist.length);
    loadingofirst = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
          "View Department",
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
      body: SingleChildScrollView(
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
                    itemCount: deptlist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.black12,
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('${deptlist[index].departmentName}'),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "$ip/admin/getDepartmentProfilePic/${deptlist[index].departmentId}"),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditDepartment(
                                          department: deptlist[index])));
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddDepartment()));
        },
        label: Text(
          'Add Department',
          style: TextStyle(fontSize: 11),
        ),
        icon: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
