import 'package:flutter/material.dart';
// import 'dart:html';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intership/Admin/homepage.dart';
import 'package:intership/Admin/model/userstate.dart';
import 'package:intership/Manager/managerHome.dart';
import 'package:intership/Admin/model/session.dart';
import 'dart:convert';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:intership/Operator/operatorHome.dart';
import 'package:intership/constant/ApI.dart';
import 'package:intership/constant/color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Client/home_client.dart';


final Map<String, String> genderMap = {
    'manager': 'Manager',
    'client': 'Client',
    'operator': 'Operator',
    'admin': 'Admin',
  };
  String _selectedGender = genderMap.keys.first;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  late bool userLoggedIn;
  // late String userType;
  String? userType;
  String? userToken;
  @override
  void initState() {
    super.initState();
  }

  void checkState() async {
    // Provider.of<UserState>(context,).initSP();

    // userType = await Provider.of<UserState>(context, listen: false).fetchCookieandUser();

    // if (userType == "null") {
    //   userLoggedIn = false;
    // } else {
    //   userLoggedIn = true;
    // }

    // setState(() {
    //   isLoading = false;
    // });

    final sp = await SharedPreferences.getInstance();

    // String? userType, userToken;

    userToken = sp.getString('cookie');
     userType = sp.getString('userType');

    if (userType == null || userToken == null) {
      userLoggedIn = false;
    } else {
      userLoggedIn = true;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    checkState();

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (userLoggedIn && userType == 'manager') {
        return home_manager();
      }
      else if (userLoggedIn && userType == 'client') {
        return home_client();
      }
      else if (userLoggedIn && userType == 'admin') {
        return HomePage();
      }
      else if (userLoggedIn && userType == 'operator') {
        return home_operator();
      }
       else {
        return CommanLoginPage();
      }
    }
  }
}

class CommanLoginPage extends StatefulWidget {
  @override
  State<CommanLoginPage> createState() => _CommanLoginPageState();
}

class _CommanLoginPageState extends State<CommanLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  //map
  bool loading = false;
  
  Future<dynamic> login(String email, String password, String api) async {
    try {
      setState(() {
        loading = true;
      });
      Session _session = Session();
      final data =
          jsonEncode(<String, String>{'email': email, 'password': password});
      final response = await _session.post(api, data);
      print(_session.cookies);
      print(response.toString());
      setState(() {
        loading = false;
      });
      return response;
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  dynamic sp;
  void initSP() async {
    sp = await SharedPreferences.getInstance();
  }

  // String _selectedGender = genderMap.keys.first;
  @override
  Widget build(BuildContext context) {
    initSP();
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
                height: MediaQuery.of(context).size.height / 15,
              ),
              Container(
                // height: MediaQuery.of(context).size.height / 1.8,
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
                        CupertinoRadioChoice(
                            selectedColor: yellowColor.withOpacity(1),
                            notSelectedColor: creamColor2,
                            choices: genderMap,
                            onChange: (genderKey) {
                              setState(() {
                                _selectedGender = genderKey;
                                print(_selectedGender);
                              });
                            },
                            initialKeyValue: _selectedGender),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: emailController,
                                cursorColor: Colors.black87,
                                style: const TextStyle(color: Colors.black),
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
                                obscureText: true,
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
                          height: 45,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!emailController.text.isEmpty &&
                                !pwdController.text.isEmpty) {
                              String api = "";
                              // print(_selectedGender == "manager");
                              if (_selectedGender == "manager")
                                api = managerlogin;
                              else if (_selectedGender == "operator")
                                api = operatorlogin;
                              else if (_selectedGender == "admin")
                                api = adminlogin;
                              else if (_selectedGender == 'client')
                                api = clientlogin;
                              print(_selectedGender);
                              var response = await login(
                                      emailController.text.toString(),
                                      pwdController.text.toString(),
                                      api)
                                  .catchError((err) {});
                              if (mounted && response['success'] == true) {
                                sp.setString('userType',_selectedGender);
                                if (_selectedGender == "manager") {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const home_manager()));
                                } else if (_selectedGender == "operator") {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const home_operator()));
                                } else if (_selectedGender == "admin") {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                } else if (_selectedGender == "client") {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const home_client()));
                                }
                              } else {
                                final snackBar = SnackBar(
                                  content:
                                      const Text("Enter Correct Credentials"),
                                  backgroundColor: (Colors.black12),
                                  action: SnackBarAction(
                                    label: 'dismiss',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                return;
                              }
                            } else {
                              print("ddddd");
                              final snackBar = SnackBar(
                                content: const Text('Please Enter Credentials'),
                                backgroundColor: (Colors.black12),
                                action: SnackBarAction(
                                  label: 'dismiss',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return null;
                            }
                          },
                          child: loading
                              ? SpinKitCircle(
                                  color: Colors.white,
                                  size: 50.0,
                                )
                              // Container(
                              //     height: 50,
                              //     width: 50,
                              //     child: const CircularProgressIndicator())
                              : Container(
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  decoration: BoxDecoration(
                                    // color: Colors.cyan[500],
                                    border: Border.all(
                                      color: Colors.yellowAccent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
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
                        // const SizedBox(
                        //   height: 25,
                        // ),
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
// void onGenderSelected(String genderKey) {
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