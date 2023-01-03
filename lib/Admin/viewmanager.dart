import 'package:flutter/material.dart';
import 'package:intership/constant/ApI.dart';
// import 'package:superadmin/constant.dart';
import 'model/managermodel.dart';
import 'model/session.dart';
class ViewManager extends StatefulWidget {
  const ViewManager({Key? key}) : super(key: key);

  @override
  State<ViewManager> createState() => _ViewManagerState();
}

class _ViewManagerState extends State<ViewManager> {

  List<Managermodel> managerlist = [];
  Future<List<Managermodel>> getManager () async{
    Session _session = Session();
    final response = await _session.get(getmanagerlist);
    print(response['data']);

    // for(Map<String,dynamic> i in response['data']){
    //   managerlist.add(Managermodel.fromJson(i));
    //   setState(() {
    //     managerlist
    //   });
    // }
    print(managerlist);
    return managerlist;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
              "View Manager",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            )),
        elevation: 0.0,
        leading: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
                icon: Icon(Icons.arrow_back,color: Colors.black,),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
                future: getManager(), builder: (BuildContext context, AsyncSnapshot<List<Managermodel>> snapshot) {
                  if(!snapshot.hasData){
                    return Container(
                      height: 50,
                        width: 50,
                        child: CircularProgressIndicator());
                  }
                  else{
                  return ListView.builder(
                    itemCount: managerlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(

                      );
                    },

                  );
                  }
              },

              )
      ),
    );
  }
}
