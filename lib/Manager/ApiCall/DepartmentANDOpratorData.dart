import 'package:intership/Admin/model/session.dart';
import 'package:intership/Manager/model/operatormodel.dart';

//
List<String> departlist = [];
List<String> departlistID = [];

getDetp() async {
  Session _session = Session();
  final response =
  await _session.get('http://164.92.83.169/manager/getDepartments');
  for (dynamic i in response['data']['departments']) {
    if (!departlist.contains(i['departmentName'])) {
      departlist.add(i['departmentName']);
      departlistID.add(i['departmentId']);
    }
  }
}

Future<List<OperatorData>> getOperator() async {
   await getDetp();
   List<OperatorData> operaortlist = [];
  Session _session = Session();
  for (String i in departlistID) {
    print(i);
    final response =
    await _session.get('http://164.92.83.169/manager/getOperators/$i');
    print("OperatorResponse $response");

    for (dynamic i in response['data']['operators']) {
      print('data is being fetched : ${i['name']}');
      if (!operaortlist.contains(i['name'])) {
        operaortlist.add(OperatorData.fromJson(i));

      }
    }
  }
  return operaortlist;
}
