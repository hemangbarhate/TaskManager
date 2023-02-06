import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intership/Admin/Report/ReportModel.dart';
import 'package:intership/Admin/model/session.dart';
import 'package:intership/constant/color.dart';
import 'package:intl/intl.dart';

import '../../constant/ApI.dart';

class mnagerReport extends StatefulWidget {
  String managerID;
  String report;
  mnagerReport({Key? key, required this.managerID, required this.report}) : super(key: key);

  @override
  _mnagerReportState createState() => _mnagerReportState();
}

class _mnagerReportState extends State<mnagerReport> {
  List<ReportModel> managerreportlist = [];
  Future<dynamic> managerReportFunc(String managerId, Report, startdate, endate) async {
    try {
      Session _session = Session();
      final data = jsonEncode(<String, String>{
        'startDate': startdate,
        'endDate': endate,
      });
      final response = await _session.post(
          'http://$ip/admin/reports/$Report/$managerId', data);
      print("Dhiraj ${response.toString()}");
      for (dynamic i in response['result']) {
        print("iii $i");
        managerreportlist.add(ReportModel.fromJson(i));
      }
      print("managerreportlist  ${managerreportlist}");
      setState(() {

      });
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  TextEditingController opendate = TextEditingController();
  TextEditingController closedate = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    // managerReportFunc(
    //     "82027796-7695-42eb-b314-5ba0e647c81e", "2021-12-02", "2023-02-02");
    // opendate.text = ""; //set the initial value of text field
    // closedate.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          shadowColor: Colors.white,
          title: Text("Report",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
          leading: Builder(builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            );
          }),
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                // Row(
                //   children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: opendate,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                      hintText: 'Start Date',
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: 'OpenDate',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          opendate.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    validator: (value) {
                      if (value != null && value.length < 1) {
                        return 'This field cant be null';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: closedate,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                      hintText: 'End Date',
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: 'CloseDate',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          closedate.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    validator: (value) {
                      if (value != null && value.length < 1) {
                        return 'This field cant be null';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            final isValidForm = _formKey.currentState!.validate();
                            if (isValidForm) {
                              await managerReportFunc(
                                      widget.managerID,
                                      widget.report,
                                      opendate.text.toString(),
                                      closedate.text.toString())
                                  .catchError((err) {});
                            }
                          },
                          child: Text('Get Report'))),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      Flexible(
                        child: Container(
                          height: 300,
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                child: Table(
                                  border: TableBorder.all(),
                                  defaultColumnWidth: FixedColumnWidth(190),
                                  children: [
                                    TableRow(children: [
                                      Column(children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('TaskName',
                                              style: TextStyle(fontSize: 17.0)),
                                        ),
                                        Text('------------------------------------------'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: managerreportlist.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Text("${managerreportlist[index].taskName}"),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ]),
                                      Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('OpenDate',
                                              style: TextStyle(fontSize: 17.0)),
                                        ),
                                        Text('------------------------------------------'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: managerreportlist.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Text("${managerreportlist[index].openDate?.substring(0,10)}"),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ]),
                                      Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('AssignationDate',
                                              style: TextStyle(fontSize: 17.0)),
                                        ),
                                        Text('------------------------------------------'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: managerreportlist.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Text("${managerreportlist[index].assignationDate?.substring(0,10)}"),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ]),
                                      Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('OperatorAcceptDate',
                                              style: TextStyle(fontSize: 16.0)),
                                        ),
                                        Text('------------------------------------------'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: managerreportlist.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Text("${managerreportlist[index].operatorAcceptDate?.substring(0,10)}"),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ]),
                                      Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('ActualCloseDate',
                                              style: TextStyle(fontSize: 17.0)),
                                        ),
                                        Text('------------------------------------------'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: managerreportlist.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Text("${managerreportlist[index].actualCloseDate?.substring(0,10)}"),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ]),
                                      Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('CloseDate',
                                              style: TextStyle(fontSize: 17.0)),
                                        ),
                                        Text('------------------------------------------'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: managerreportlist.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Text("${managerreportlist[index].closeDate?.substring(0,10)}"),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ]),
                                      Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('AssignationStatus',
                                              style: TextStyle(fontSize: 17.0)),
                                        ),
                                        Text('------------------------------------------'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: managerreportlist.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Text("${managerreportlist[index].AssignationStatus}"),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ]),
                                      Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('TaskStatus',
                                              style: TextStyle(fontSize: 17.0)),
                                        ),
                                        Text('------------------------------------------'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          primary: false,

                                          shrinkWrap: true,
                                          itemCount: managerreportlist.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Text("${managerreportlist[index].taskStatus}"),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ]),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
