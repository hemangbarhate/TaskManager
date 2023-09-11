

 import 'dart:developer';

import 'package:intership/Admin/model/session.dart';
import 'package:intership/Manager/model/clientmodel.dart';

import '../../constant/ApI.dart';

List <ClientModel> clientlist = [];

 Future<List <ClientModel> >  getClientdata() async {clientlist.clear();
  log("// client data");
  Session _session = Session();
  final response =
  await _session.get('$ip/manager/getClients');
  log("response $response");

    for (dynamic i in response['data']) {
      print("i");
      clientlist.add(ClientModel.fromJson(i));
    }

  if(clientlist.length >= 1) print(clientlist[0]);
  return clientlist;
}