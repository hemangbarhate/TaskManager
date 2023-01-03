// To parse this JSON data, do
//
//     final clientmodel = clientmodelFromJson(jsonString);

import 'dart:convert';

Clientmodel clientmodelFromJson(String str) => Clientmodel.fromJson(json.decode(str));

String clientmodelToJson(Clientmodel data) => json.encode(data.toJson());

class Clientmodel {
  Clientmodel({
    required this.success,
    required this.data,
  });

  bool success;
  List<Datum> data;

  factory Clientmodel.fromJson(Map<String, dynamic> json) => Clientmodel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.clientId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.organization,
    required this.password,
  });

  String clientId;
  String name;
  String email;
  String mobile;
  String organization;
  String password;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    clientId: json["clientId"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    organization: json["organization"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "clientId": clientId,
    "name": name,
    "email": email,
    "mobile": mobile,
    "organization": organization,
    "password": password,
  };
}
