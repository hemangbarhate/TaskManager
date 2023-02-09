import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/Auth/CommanLoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/ApI.dart';
import '../constant/color.dart';

var name, email, mobile, organization;

class ClientProfile extends StatefulWidget {
  const ClientProfile({Key? key}) : super(key: key);

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  var profileImage;
  @override
  void initState() {
    getProfile();
    getProfileImage();
    super.initState();
  }

  getProfileImage() async {
    Session _session = Session();
    var profileImage1 = await _session
        .getprofileImage("http://$ip/client/profilePic");
    setState(() {
      profileImage = profileImage1;
    });
  }



  late File _pickedImage;
  String apiUrl = 'http://$ip/client/profilePic';
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
    Session _session = Session();
    final response = await _session.get(clientprofile);

    setState(() {
      name = response['data']['client']['name'];
      email = response['data']['client']['email'];
      mobile = response['data']['client']['mobile'];
      organization = response['data']['client']['organization'];
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
          "Client Profile",
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
              height: MediaQuery.of(context).size.height / 1.3,
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
                                // _uploadImage();
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
                                "$name",
                                style: TextStyle(
                                    color: blackColor.withOpacity(1),
                                    fontSize: 22),
                              ),
                              Text(
                                "Client",
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
                  SizedBox(
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
                                child: Icon(
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
                                    "$email",
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
                                child: Icon(
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
                                    "$mobile",
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
                              Icons.work,
                              size: 35,
                            )),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "$organization",
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
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Response response =
                          await http.get(Uri.parse(clientlogout));
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
