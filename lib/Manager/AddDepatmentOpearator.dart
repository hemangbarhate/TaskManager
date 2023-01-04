import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intership/Admin/addclient.dart';
import 'package:intership/Admin/model/session.dart';
// import 'package:intership/Manager/session.dart';
import 'package:intership/constant/ApI.dart';
import 'package:intership/constant/color.dart';

class AddDepatmentOpearator extends StatefulWidget {
  const AddDepatmentOpearator({Key? key}) : super(key: key);

  @override
  _AddDepatmentOpearatorState createState() => _AddDepatmentOpearatorState();
}

class _AddDepatmentOpearatorState extends State<AddDepatmentOpearator> {


  // Future<dynamic> addOperator(
  //     String email, name, password, departmentid, mobile) async {
  //   try {
  //     Session _session = Session();
  //     final data = jsonEncode(<String, String>{
  //       'email': email,
  //       'name': name,
  //       'password': password,
  //       'mobile': mobile,
  //       'departmentId': departmentid
  //     });
  //     print(data);
  //     final response =
  //         await _session.post('http://$ip/manager/addOperator', data);
  //     print(response.toString());
  //     print('Operator Added successfully');
  //     return response;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<dynamic> addOperator(String email,String name,String password,String departmentid,String mobile) async {
    try {
      Session _session = Session();
      final data = jsonEncode(<String, String>{
        'email': email,
        'name': name,
        'password': password,
        'mobile': mobile,
        'departmentId': departmentid
      });
      final response = await _session.post(
          'http://164.92.83.169/manager/addOperator', data);
      print(response.toString());
      print('Operator Added successfully');
      return response;
    } catch (e) {
      print(e.toString());
    }
  }
  Future<dynamic> addDept(String dept) async {
    try {
      Session _session = Session();
      final data = jsonEncode(<String, String>{'name': dept});
      final response = await _session.post(
          'http://164.92.83.169/manager/addDepartment', data);
      print(response.toString());
      print('Department Added successfully');
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController opname = TextEditingController();
    TextEditingController opemail = TextEditingController();
    TextEditingController oppassword = TextEditingController();
    TextEditingController opmobile = TextEditingController();
    TextEditingController department = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: const Center(
            child: Text(
          "ADD DEPARTMENT",
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Add Department",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: greyColor.withOpacity(0.9)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: department,
                decoration: const InputDecoration(
                  labelText: 'Name ',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  var response = await addDept(
                    department.text.toString(),
                  ).catchError((err) {});
                  if (response == null) {
                    return;
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  // width: 150,
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
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      '  Add Department  ',
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
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Add Opeartor",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: greyColor.withOpacity(0.9)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: opname,
                decoration: const InputDecoration(
                  labelText: 'Name ',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: opemail,
                decoration: const InputDecoration(
                  labelText: 'Email ',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: opmobile,
                decoration: const InputDecoration(
                  labelText: 'Mobile ',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: oppassword,

                decoration: const InputDecoration(
                  labelText: 'password ',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  // final isValidForm = _formKey.currentState!.validate();
                  // if (isValidForm) {
                  var response = await addOperator(
                          opemail.text.toString(),
                          opname.text.toString(),
                          oppassword.text.toString(),
                          'departmentcontroller.text.toString()',
                          oppassword.text.toString())
                      .catchError((err) {});
                  if (response == null) {
                    return;
                  } else {
                    Navigator.of(context).pop();
                    // }
                  }
                },
                child: Container(
                  // width: 150,
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
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      '  Add Operator  ',
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
          ],
        ),
      ),
    );
  }
}
