import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class UserState with ChangeNotifier {
  dynamic state ;
  void initSP() async {
    state = await SharedPreferences.getInstance();
    print("object");
    notifyListeners();
  }

  Future<String> fetchCookieandUser() async {
    String jwt;
    String userType;
    jwt = await state.getString('cookie');
    userType = await state.getString('userType');
    if (jwt != null && userType != null) {
      return userType.toString();
    } else {
      return "null";
    }
  }

  void setCookieandUser(String cookie, String userType) async {
    await state.setString('cookie', cookie);
    await state.setString('userType', userType);
    notifyListeners();
  }
}
