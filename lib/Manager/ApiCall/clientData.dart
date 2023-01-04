

 import 'package:intership/Admin/model/session.dart';
import 'package:intership/Manager/model/clientmodel.dart';

List <ClientModel> clientlist = [];

 Future<List <ClientModel> >  getClientdata() async {
  print("// client data");
  Session _session = Session();
  final response =
  await _session.get('http://164.92.83.169/manager/getClients');
  print("response $response");

    for (dynamic i in response['data']) {
      print("i");
      clientlist.add(ClientModel.fromJson(i));
    }

  if(clientlist.length >= 1) print(clientlist[0]);
  return clientlist;
}