import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
import 'model/session.dart';

TextEditingController emailcontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
TextEditingController mobilecontroller = TextEditingController();
TextEditingController organizationcontroller = TextEditingController();

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final _formKey = GlobalKey<FormState>();

  Future<dynamic> addClient(
      String email, name, password, organization, mobile) async {
    try {
      Session _session = Session();
      final data = jsonEncode(<String, String>{
        'email': email,
        'name': name,
        'password': password,
        'organization': organization,
        'mobile': mobile
      });
      final response = await _session.post('http://$ip/admin/addClient', data);
      print(response.toString());
      print('Client Added successfully');
      return response;
      // Response response = await http.post(
      //   Uri.parse('http://$ip/admin/addManager'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body:
      //   jsonEncode(<String, String>{'email': email,'name': name ,'password': password,'organization': organization,'mobile': mobile}),
      // );
      // print(response);
      //
      // var data = jsonDecode(response.body.toString());
      // print(data);
      // if (response.statusCode == 200) {
      //   print('Manager Added successfully');
      //   return data;
      // } else {
      //   print('failed to add client');
      //   return;
      //
      // }
    } catch (e) {
      print(e.toString());
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
          "Add Client",
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
                  hintText: 'Enter Client Email',
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
                  hintText: 'Enter Client name',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Client Name',
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
                controller: organizationcontroller,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.password,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Organization Name',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Organization',
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
                          var response = await addClient(
                                  emailcontroller.text.toString(),
                                  namecontroller.text.toString(),
                                  passwordcontroller.text.toString(),
                                  organizationcontroller.text.toString(),
                                  mobilecontroller.text.toString())
                              .catchError((err) {});
                          if (response == null) {
                            return;
                          } else {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: Text('Add Client'))),
            ],
          ),
        ),
      ),
    );
  }
}
