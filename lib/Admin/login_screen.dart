// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:intership/Admin/constant.dart';
// import 'package:intership/Admin/model/session.dart';
// import 'package:superadmin/constant.dart';
// import 'package:superadmin/model/session.dart';
//
// class LoginPage extends StatefulWidget {
//   LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//
//   Future<dynamic> login(String email, String password) async {
//     try {
//       Session _session = Session();
//       final data = jsonEncode(<String, String>{'email': email, 'password': password});
//       final response = await _session.post('$ip/admin/login', data);
//       print(_session.cookies);
//       print(response);
//       return response;
//       // Response response = await http.post(
//       //   Uri.parse('$ip/admin/login'),
//       //   headers: <String, String>{
//       //     'Content-Type': 'application/json; charset=UTF-8',
//       //   },
//       //   body:
//       //       jsonEncode(<String, String>{'email': email, 'password': password}),
//       // );
//       // print(response.headers.toString());
//       //
//       // var data = jsonDecode(response.body.toString());
//       // print(data);
//       // if (response.statusCode == 200) {
//       //   print('Login successfully');
//       //   return data;
//       // } else {
//       //   print('failed');
//       //   return;
//       //
//       // }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 colors: [Colors.white60, Colors.white60, Colors.white60]),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const SizedBox(
//                 height: 80,
//               ),
//               Header(),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 17,
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height / 1.8,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       color: Colors.black87,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(60),
//                         topRight: Radius.circular(60),
//                       )),
//                   child: Padding(
//                     padding: const EdgeInsets.all(30),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           child: const Text(
//                             "Admin Login",
//                             style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w800,
//                                 // fontWeight:,
//                                 color: Colors.yellowAccent),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         Container(
//                           child: Column(
//                             children: <Widget>[
//                               TextField(
//                                 cursorColor: Colors.black87,
//                                 controller: emailController,
//                                 style: TextStyle(color: Colors.black),
//                                 decoration: InputDecoration(
//                                   hintText: "Email",
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       borderRadius: BorderRadius.circular(50)),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 25,
//                               ),
//                               TextField(
//                                 cursorColor: Colors.black87,
//                                 controller: passwordController,
//                                 style: TextStyle(color: Colors.black),
//                                 decoration: InputDecoration(
//                                   hintText: "Password",
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       borderRadius: BorderRadius.circular(50)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         GestureDetector(
//                           onTap: () async {
//                             var response = await login(
//                                     emailController.text.toString(),
//                                     passwordController.text.toString())
//                                 .catchError((err) {});
//                             if (response['success'] == true) {
//                               Navigator.of(context).pushNamed('HomePage');
//                             }else{
//                               print(response['data']);
//                               return;
//                             }
//                           },
//                           child: Container(
//                             height: 50,
//                             margin: const EdgeInsets.symmetric(horizontal: 50),
//                             decoration: BoxDecoration(
//                               // color: Colors.cyan[500],
//                               border: Border.all(
//                                 color: Colors.yellowAccent,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: const Center(
//                               child: Text(
//                                 "Login",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Header extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Container(
//           height: MediaQuery.of(context).size.height / 3,
//           child: Image.asset('assets/login.png')),
//     );
//   }
// }
//
// // [2 whitespaces or 1 tab]assets:
// // [4 whitespaces or 2 tabs]- assets/images/  #index all files inside images folder
// // [4 whitespaces or 2 tabs]- assets/images/elephant.jpg #index only elephant.jpg
