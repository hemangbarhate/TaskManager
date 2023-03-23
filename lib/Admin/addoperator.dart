import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/ApI.dart';
import '../constant/color.dart';
import 'constant.dart';
import 'homepage.dart';
import 'model/session.dart';



TextEditingController emailcontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
TextEditingController mobilecontroller = TextEditingController();
TextEditingController departmentcontroller = TextEditingController();

class AddOperator extends StatefulWidget {
  const AddOperator({Key? key}) : super(key: key);

  @override
  State<AddOperator> createState() => _AddOperatorState();
}

class _AddOperatorState extends State<AddOperator> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  Future<dynamic> addOperator(String email, name,password,departmentid,mobile) async {
    try {
      Session _session = Session();
      final data = jsonEncode(<String, String>{'email': email,'name': name ,'password': password,'mobile': mobile,'departmentId': departmentid});
      print(data);
      final response = await _session.post('$ip/admin/addOperator', data);
      print(response.toString());
      print('Operator Added successfully');
      return response;

    } catch (e) {
      print(e.toString());
    }
  }

  List<String> departlist = [];
  List<String> departlistID = [];
  Map<dynamic,String> deptmap = {};
  int select = -1;
  getDetp() async {
    setState(() {
      loading = true;
    });
    Session _session = Session();
    final response =
    await _session.get('$ip/admin/getDepartments');
    for (dynamic i in response['data']['departments']) {
      if (!departlist.contains(i['departmentName'])) {
        departlist.add(i['departmentName']);
        departlistID.add(i['departmentId']);
        deptmap[i['departmentName']]=i['departmentId'];
      }
    }
    setState(() {
      loading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getDetp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
              "Add Operator",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            )),
        elevation: 0.0,
        leading: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
                icon: const Icon(Icons.arrow_back,color: Colors.black,),
                onPressed: () {
                  Navigator.of(context).pop();
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
                controller: emailcontroller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email_outlined,color: Colors.black,),
                  hintText: 'Enter Operator Email',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                ),
                validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: namecontroller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person,color: Colors.black,),
                  hintText: 'Enter Operator name',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Operator Name',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                ),
                validator: (value) {
                  if (value != null && value.length < 4) {
                    return 'Enter min. 4 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: passwordcontroller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password,color: Colors.black,),
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                ),
                validator: (value) {
                  if (value != null && value.length < 6) {
                    return 'Enter min. 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              // TextFormField(
              //   style: TextStyle(color: Colors.black),
              //   controller: departmentcontroller,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.work,color: Colors.black,),
              //     hintText: 'Enter Departmentid',
              //     hintStyle: TextStyle(color: Colors.black),
              //     labelText: 'Department',
              //     labelStyle: TextStyle(color: Colors.black),
              //     border: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black)
              //     ),
              //   ),
              //   readOnly: true,
              //   onTap: () {
              //
              //   },
              //   validator: (value) {
              //     if (value != null && value.length < 4) {
              //       return 'Enter min. 4 characters';
              //     }
              //     return null;
              //   },
              // ),
              Text('Select Department'),
              SizedBox(height: 4,),
              loading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                    padding: const EdgeInsets.fromLTRB(40,0,10,0),
                    child: Container(
                height: 250,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: blueColor.withOpacity(0.6),
                    ),
                    borderRadius: BorderRadius.circular(1),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: departlist.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                select = index;
                              });
                            },
                            child: Container(
                              color: select == index
                                  ? Colors.grey.withOpacity(0.2)
                                  : whiteColor.withOpacity(1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: ListTile(
                                    title:
                                    Text("${departlist[index]}"),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ),
              ),
                  ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: mobilecontroller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone,color: Colors.black,),
                  hintText: 'Enter a phone number',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value != null && value.length != 10) {
                    return 'Enter 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),
              SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        final isValidForm = _formKey.currentState!.validate();
                        if (isValidForm && select != -1) {
                          var response = await addOperator(
                              emailcontroller.text.toString(),
                              namecontroller.text.toString(),
                              passwordcontroller.text.toString(),
                              departlistID[select],
                              mobilecontroller.text.toString()
                          ).catchError((err) {});
                          if (response == null) {
                            return;
                          } else {
                            if(response['success']==false){
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(response['error'])));
                            }
                            else{
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(response['data'])));
                            }
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => const HomePage()));
                          }
                        }
                      }, child: Text('Add operator'))),
            ],
          ),
        ),
      ),
    );
  }
}
