import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  TextEditingController textController = TextEditingController();
  String displayText = "";

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
                          child: const Text("LogIn", style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            // fontWeight:,
                            color: Colors.yellowAccent
                          ),),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              TextField(
                                cursorColor: Colors.black87,
                                style: TextStyle(
                                    color: Colors.black
                                ),
                                decoration: InputDecoration(
                                  hintText: "User name",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextField(
                                cursorColor: Colors.black87,
                                style: TextStyle(
                                    color: Colors.black
                                ),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
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
