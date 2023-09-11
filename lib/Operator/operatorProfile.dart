import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/constant/ApI.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/CommanLoginPage.dart';
import '../constant/color.dart';

var name, email, mobile, organization;

class OperatorProfile extends StatefulWidget {
  const OperatorProfile({Key? key}) : super(key: key);

  @override
  _OperatorProfileState createState() => _OperatorProfileState();
}

class _OperatorProfileState extends State<OperatorProfile> {
  bool load = false;
  var profileImage;
  @override
  void initState() {
    getProfile();
    getProfileImage();
    super.initState();
  }

  getProfileImage() async {
    Session _session = Session();
    profileImage = await _session.getprofileImage("$ip/operator/profilePic");
    setState(() {});
  }

  late File _pickedImage;
  String apiUrl = '$ip/operator/profilePic';
  uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _pickedImage = File("${pickedFile?.path}");
    Session _session = Session();
    await _session.uploadImage1(pickedFile!.path, apiUrl);
    setState(() {
      getProfile();
      getProfileImage();
    });
  }

  void getProfile() async {
    setState(() {
      load = true;
    });
    Session _session = Session();
    final response = await _session.get('$ip/operator/profile');
    print(response);
    setState(() {
      name = response['data']['operator']['name'];
      email = response['data']['operator']['email'];
      mobile = response['data']['operator']['mobile'];
      organization = response['data']['operator']['departmentName'];
    });
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamColor2.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
          "Operator Profile",
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width / 1.09,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    whiteColor.withOpacity(0.9),
                    whiteColor.withOpacity(0.9)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(8, 8),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).size.height / 7,
                            width: MediaQuery.of(context).size.width / 6,
                            padding: EdgeInsets.all(6),
                            child: profileImage == null
                                ? Image.asset("assets/images/download.png")
                                : CircleAvatar(
                                    backgroundImage: MemoryImage(
                                      profileImage,
                                    ),
                                  )),
                        Column(
                          children: [
                            Container(
                              height: 35,
                            ),
                            GestureDetector(
                              onTap: () {
                                uploadImage();
                              },
                              child: Container(
                                  height: 50, child: Icon(Icons.edit)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                load ? "name" : "$name",
                                style: TextStyle(
                                    color: blackColor.withOpacity(1),
                                    fontSize: 22),
                              ),
                              Text(
                                "Operator",
                                style: TextStyle(
                                    color: blackColor.withOpacity(0.6),
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 1.2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // color: greyColor.withOpacity(0.1),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            creamColor2.withOpacity(0.01),
                            creamColor2.withOpacity(0.01)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(8, 8),
                            blurRadius: 25,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                                // height: 40,
                                // width: 22,
                                child: const Icon(
                              Icons.email,
                              size: 35,
                            )),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    load ? "email" : "$email",
                                    style: TextStyle(
                                        color: blackColor.withOpacity(1),
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // color: greyColor.withOpacity(0.1),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            creamColor2.withOpacity(0.01),
                            creamColor2.withOpacity(0.01)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(8, 8),
                            blurRadius: 25,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                                // height: 40,
                                // width: 22,
                                child: const Icon(
                              Icons.mobile_screen_share,
                              size: 35,
                            )),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    load ? "mobile" : "$mobile",
                                    style: TextStyle(
                                        color: blackColor.withOpacity(1),
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5.8,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Response response =
                          await http.get(Uri.parse(operatorlogout));
                      if (response.statusCode == 200) {
                        print('LogOut successfully');
                        final sp = await SharedPreferences.getInstance();
                        sp.remove('cookie');
                        sp.remove('userType');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommanLoginPage(),
                            ),
                            (route) => false);
                      } else {
                        print('LogOut Failed');
                        return;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Container(
                        // width: ,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              orangeColor.withOpacity(0.5),
                              orangeColor.withOpacity(0.9),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            child: const Text(
                              'LogOut',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "Netflix",
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 0.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
      // ),
    );
  }
}

//Container(
//         // width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 10,
//               ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 3.3 ,
//
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//                   blueColor.withOpacity(0.5),
//                   blueColor.withOpacity(0.5),
//                 ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//                 border: Border.all(
//                   color: Color(0x282019).withOpacity(0.2),
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 50,
//                   ),
//                   CircleAvatar(
//                     backgroundColor: greyColor.withOpacity(0.3),
//                     radius: 50,
//                     // child: Image.asset("assets/images/pro.png"),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10.0, bottom: 05),
//                     child: Container(
//                       height: 30,
//                       width: 250,
//                       child: Center(
//                         child: Text(
//                           "Dhiraj Darakhe ",
//                           style: TextStyle(fontSize: 18, color:Colors.white.withOpacity(1)),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       // decoration: BoxDecoration(
//                       //   color: Colors.grey[200],
//                       //   borderRadius: BorderRadius.circular(10),
//                       // ),
//                       // height: 45,
//                       width: 250,
//                       child: Center(
//                         child: Text(
//                           "Manager, App development ",
//                           style: TextStyle(fontSize: 15, color:Colors.white.withOpacity(1)),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//               SizedBox(
//                 height: 35,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   height: 45,
//                   width: 350,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "🙂 :  Manager ",
//                         style: TextStyle(fontSize: 17),
//                   ),
//                     ),
//                 ),
//               ),  Padding(
//                 padding: const EdgeInsets.only(top: 20.0, right: 6, left: 5),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   height: 45,
//                   width: 350,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "📱 :    7218724337 ",
//                         style: TextStyle(fontSize: 17),
//                   ),
//                     ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 20.0, right: 6, left: 5),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   height: 45,
//                   width: 350,
//                   child: Center(
//                     child: Text(
//                       "📧 : dhirajdarakhe03@gmail.com ",
//                       style: TextStyle(fontSize: 17),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 68,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(38.0),
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     width: 150,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                          greyColor.withOpacity(0.7),
//                           greyColor.withOpacity(0.7)
//                           // Colors.teal[200],
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           offset: Offset(5, 5),
//                           blurRadius: 10,
//                         )
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Center(
//                         child: Text(
//                           'LogOut',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
