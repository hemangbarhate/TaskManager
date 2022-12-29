import 'package:flutter/material.dart';
import 'package:intership/constant/color.dart';

class AddDepatmentOpearator extends StatefulWidget {
  const AddDepatmentOpearator({Key? key}) : super(key: key);

  @override
  _AddDepatmentOpearatorState createState() => _AddDepatmentOpearatorState();
}

class _AddDepatmentOpearatorState extends State<AddDepatmentOpearator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.grey[200],
        shadowColor: Colors.white,
        title: const Center(
            child: Text(
              "ADD DEPARTMENT",
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.black),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Padding(
              padding: EdgeInsets.all(25),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Add Department",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:greyColor.withOpacity(0.9) ),),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(

                decoration: InputDecoration(
                  labelText: 'Name ',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  // width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        greyColor.withOpacity(0.7),
                        greyColor.withOpacity(0.7)
                        // Colors.teal[200],
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      '  Add Department  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Add Opeartor",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:greyColor.withOpacity(0.9) ),),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(

                decoration: InputDecoration(
                  labelText: 'Name ',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(

                decoration: InputDecoration(
                  labelText: 'Email ',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(

                decoration: InputDecoration(
                  labelText: 'Department ',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(

                decoration: InputDecoration(
                  labelText: 'Moblie ',
                  focusColor: whiteColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // <-- SEE HERE
                minLines: 1, // <-- SEE HERE
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  // width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        greyColor.withOpacity(0.7),
                        greyColor.withOpacity(0.7)
                        // Colors.teal[200],
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      '  Add Operator  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
