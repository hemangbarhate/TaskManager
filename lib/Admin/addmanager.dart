import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intership/Admin/homepage.dart';

import '../constant/ApI.dart';
import 'constant.dart';
import 'model/session.dart';

TextEditingController emailcontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
TextEditingController mobilecontroller = TextEditingController();

class AddManager extends StatefulWidget {
  const AddManager({Key? key}) : super(key: key);

  @override
  State<AddManager> createState() => _AddManagerState();
}

class _AddManagerState extends State<AddManager> {
  final _formKey = GlobalKey<FormState>();

  Future<dynamic> addManager(String email, password, name, mobile) async {
    try {
      Session _session = Session();
      final data = jsonEncode(<String, String>{
        'email': email,
        'name': name,
        'password': password,
        'mobile': mobile
      });
      final response = await _session.post('$ip/admin/addManager', data);
      print(response['error']);
      print('Manager Added successfully');
      return response;
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
          "Add Manager",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        )),
        elevation: 0.0,
        leading: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
                icon: Icon(
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
                  icon: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Manager Email',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
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
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Manager name',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Manager Name',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
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
                  icon: Icon(
                    Icons.password,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
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
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: mobilecontroller,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  hintText: 'Enter a phone number',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value != null && value.length != 10) {
                    return 'Enter 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        final isValidForm = _formKey.currentState!.validate();
                        if (isValidForm) {
                          var response = await addManager(
                                  emailcontroller.text.toString(),
                                  passwordcontroller.text.toString(),
                                  namecontroller.text.toString(),
                                  mobilecontroller.text.toString())
                              .catchError((err) {});
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
                      },
                      child: Text('Add Manager'))),
            ],
          ),
        ),
      ),
    );
  }
}
