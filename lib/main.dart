import 'package:flutter/material.dart';
import 'package:intership/Admin/model/userstate.dart';
import 'package:intership/Auth/CommanLoginPage.dart';
import 'package:intership/Manager/loginPage.dart';
import 'package:intership/Operator/operatorHome.dart';
import 'package:provider/provider.dart';

import 'Manager/managerHome.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const double defaultPadding = 16.0;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: UserState())],
      child: Consumer<UserState>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Auth',
            theme: ThemeData(
                primaryColor: kPrimaryColor,
                // scaffoldBackgroundColor: Colors.white,
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    // primary: kPrimaryColor,
                    shape: const StadiumBorder(),
                    maximumSize: const Size(double.infinity, 56),
                    minimumSize: const Size(double.infinity, 56),
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  // fillColor: kPrimaryLightColor,
                  // iconColor: kPrimaryColor,
                  // prefixIconColor: kPrimaryColor,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                )),
            home: const Home(),
          );
        },
      ),
    );
  }
}
