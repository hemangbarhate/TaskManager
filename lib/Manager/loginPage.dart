import 'package:flutter/material.dart';
// import 'dart:html';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intership/Manager/managerHome.dart';
import 'package:intership/Manager/session.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ManagerLoginPage extends StatefulWidget {
  @override
  State<ManagerLoginPage> createState() => _ManagerLoginPageState();
}

class _ManagerLoginPageState extends State<ManagerLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  final loginEndpoint = 'http://164.92.83.169/manager/login';

  Future<dynamic> login(String email, String password) async {
    try {
      Session _session = Session();
      final data =
          jsonEncode(<String, String>{'email': email, 'password': password});
      final response = await _session.post(loginEndpoint, data);
      print(_session.cookies);
      print(response.toString());
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.white60, Colors.white60, Colors.white60]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              Header(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 17,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: const Text(
                            "LogIn",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                // fontWeight:,
                                color: Colors.yellowAccent),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: emailController,
                                cursorColor: Colors.black87,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                controller: pwdController,
                                cursorColor: Colors.black87,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var response = await login(
                                    emailController.text.toString(),
                                    pwdController.text.toString())
                                .catchError((err) {});
                            if (response == null) {
                              return;
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => home_manager()));
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              // color: Colors.cyan[500],
                              border: Border.all(
                                color: Colors.yellowAccent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Don't have account ?",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  //
  //
  // void pageRounte(String token) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.setString("login", token);
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => home_manager()));
  // }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Image.asset('assets/images/login.png')),
    );
  }
}

// [2 whitespaces or 1 tab]assets:
// [4 whitespaces or 2 tabs]- assets/images/  #index all files inside images folder
// [4 whitespaces or 2 tabs]- assets/images/elephant.jpg #index only elephant.jpg
