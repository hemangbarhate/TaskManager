import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intership/Admin/homepage.dart';
import 'package:intership/Admin/model/session.dart';

import '../constant/ApI.dart';
import '../constant/color.dart';

class AddDepartment extends StatefulWidget {
  const AddDepartment({Key? key}) : super(key: key);

  @override
  State<AddDepartment> createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController department = TextEditingController();

  // Future<dynamic> addDept(String dept) async {
  //   try {
  //     Session _session = Session();
  //     final data = jsonEncode(<String, String>{'departmentName': dept});
  //     final response = await _session.post(
  //         '$ip/admin/addDepartment', data);
  //     // print(response.toString());
  //     // print('Department Added successfully');
  //     return response;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  PickedFile? pickedImage;
  late File imageFile;
  bool load = false;

  Future chooseImage() async {
    print('bbaaaaaaaaaaaa');
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      print('aaaaaaaaaaaaaa');
      pickedImage = pickedFile;
      imageFile = File(pickedFile!.path);
      load = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: const Center(
            child: Text(
          "Add Department",
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: department,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Department name',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Department Name',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (value) {
                  if (value != null && value.length < 3) {
                    return 'Enter min. 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  chooseImage();
                },
                child: Container(
                  child: load == true
                      ? Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(imageFile),
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(15.0),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/images/choose.png',
                                  height: 130.0,
                                  width: 130.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text('Choose Image'),
                            ],
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        final isValidForm = _formKey.currentState!.validate();
                        if (isValidForm) {
                          Session _session = Session();
                          var response = await _session.uploadProjectData(
                              department.text.toString(),
                              pickedImage!.path,
                              '$ip/admin/addDepartment');
                          if (response == null) {
                            return;
                          } else {
                            if (response['success'] == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(response['error'])));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(response['data'])));
                            }
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }
                        }
                      },
                      child: Text('Add Department'))),
            ],
          ),
        ),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.all(18.0),
// child: TextFormField(
// controller: department,
// decoration: const InputDecoration(
// labelText: 'Name ',
// focusColor: whiteColor,
// border: OutlineInputBorder(),
// ),
// validator: (value) {
// if (value != null && value.length < 3) {
// return 'Enter min. 3 characters';
// }
// return null;
// },
//
// maxLines: 5, // <-- SEE HERE
// minLines: 1, // <-- SEE HERE
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: GestureDetector(
// onTap: () async {
// var response = await addDept(
// department.text.toString(),
// ).catchError((err) {});
// log(response);
// if (response == null) {
// return;
// } else {
// if(response['success']==false){
// ScaffoldMessenger.of(context)
//     .showSnackBar(SnackBar(content: Text(response['error'])));
// }
// else{
// ScaffoldMessenger.of(context)
//     .showSnackBar(SnackBar(content: Text(response['data'])));
// }
// Navigator.of(context).pushReplacement(MaterialPageRoute(
// builder: (context) => const HomePage()));
// }
// },
// child: Container(
// // width: 150,
// height: 50,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [
// blueColor.withOpacity(1),
// blueColor.withOpacity(1),
// // Colors.teal[200],
// ],
// begin: Alignment.topLeft,
// end: Alignment.bottomRight,
// ),
// borderRadius: BorderRadius.circular(20),
// boxShadow: const [
// BoxShadow(
// color: Colors.black12,
// offset: Offset(5, 5),
// blurRadius: 10,
// )
// ],
// ),
// child: const Padding(
// padding: EdgeInsets.all(15.0),
// child: Text(
// '  Add Department  ',
// style: TextStyle(
// color: Colors.black,
// fontSize: 13,
// fontWeight: FontWeight.w400,
// ),
// ),
// ),
// ),
// ),
// )