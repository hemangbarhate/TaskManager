import 'package:flutter/material.dart';

class ViewClient extends StatefulWidget {
  const ViewClient({Key? key}) : super(key: key);

  @override
  State<ViewClient> createState() => _ViewClientState();
}

class _ViewClientState extends State<ViewClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
              "View Client",
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
        child: ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: const Icon(Icons.person,size: 30,),
                  trailing: const Text(
                    "",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                  title: Text("Client Name $index",style: TextStyle(fontWeight: FontWeight.bold
                      ,color: Colors.black, fontSize: 20),));
            }),
      ),
    );
  }
}
