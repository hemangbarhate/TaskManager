import 'package:flutter/material.dart';
import 'package:intership/Manager/assignTask.dart';
import 'package:intership/constant/color.dart';

class OpeartorContainer extends StatefulWidget {
  final Color fontColor;
  final Color backgrondColor;
  final Color first;
  final Color second;
  final Color third;
  final Color forth;
  final Color fifth;
  final Color sixth;
  final String taskId;
  final String clientId;
  final String operatorId;
  final String managerId;
  final String taskName;
  final String ProjectName;
  final String taskDescription;
  final String openDate;
  final String closeDate;
  final String clientNote;
  final String managerNote;
  final String priority;
  final String AssignationStatus;
  final String taskStatus;
  final String clientApproval;
  final String managerApproval;
  final String taskCategory;
  final String clientName;
  final String managerName;
  final VoidCallback assignTask;
  final VoidCallback TimeLineDoc;
  final VoidCallback AttachDoc;
  final VoidCallback ChangeStatus;
  final VoidCallback Approve;
  final VoidCallback Reject;
  final String who;

  const OpeartorContainer({
    Key? key,
    required this.fontColor,
    required this.backgrondColor,
    required this.first,
    required this.second,
    required this.third,
    required this.forth,
    required this.fifth,
    required this.sixth,
    required this.taskId,
    required this.clientId,
    required this.operatorId,
    required this.managerId,
    required this.taskName,
    required this.taskDescription,
    required this.openDate,
    required this.closeDate,
    required this.clientNote,
    required this.managerNote,
    required this.priority,
    required this.AssignationStatus,
    required this.taskStatus,
    required this.clientApproval,
    required this.managerApproval,
    required this.taskCategory,
    required this.assignTask,
    required this.ProjectName,
    required this.who,
    required this.TimeLineDoc,
    required this.AttachDoc,
    required this.ChangeStatus,
    required this.Approve,
    required this.Reject, required this.clientName, required this.managerName,
  }) : super(key: key);

  @override
  _OpeartorContainerState createState() => _OpeartorContainerState();
}

class _OpeartorContainerState extends State<OpeartorContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 05, left: 05),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            widget.backgrondColor.withOpacity(1),
            widget.backgrondColor.withOpacity(1),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          border: Border.all(
            color: const Color(0x282019).withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
          const EdgeInsets.only(left: 8.0, right: 5, top: 2, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Stack(children: [
                   Row(
                    children: <Widget>[
                      Icon(Icons.task, size: 35,),
                      const SizedBox(
                        width: 15,
                      ),
                      Text( '${widget.taskName}',
                        style: TextStyle(
                          // #FED457
                            fontWeight: FontWeight.w600,
                            color: widget.fontColor.withOpacity(0.9),
                            fontSize: 20),
                      ),
                    ],
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Project Name : ${widget.ProjectName} ",
                  style: TextStyle(
                    // #FED457
                      fontWeight: FontWeight.w600,
                      // color: Color(0xFED457),
                      color: widget.fontColor.withOpacity(1),
                      fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Text(
                    "Manager name :  ${widget.managerName}",
                    style: TextStyle(color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Text(
                    "Client name :   ${widget.clientName}",
                    style: TextStyle(color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Text(
                    "Description :   ${widget.taskDescription}",
                    style: TextStyle(color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Text(
                    "Client note :   ${widget.clientNote}",
                    style: TextStyle(color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Text(
                    "Manager note:   ${widget.managerNote}",
                    style: TextStyle(
                        color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              )
                 ,
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AssignTask()));
                    },
                    child: Container(
                      width: 100,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.third.withOpacity(0.7),
                            widget.third.withOpacity(0.7)
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
                      // child: Padding(
                      //   padding: EdgeInsets.all(2),
                        child: Center(
                          child: Text(
                            '${widget.openDate}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        // ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.AttachDoc,
                    child: Container(
                      width: 100,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.sixth.withOpacity(0.9),
                            widget.sixth.withOpacity(0.9)
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Center(
                          child: Text(
                            'ViewDoc',
                            style: TextStyle(
                              color: whiteColor.withOpacity(1),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AssignTask()));
                    },
                    child: Container(
                      width: 110,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.forth.withOpacity(0.9),
                            widget.forth.withOpacity(0.9)
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Center(
                          child: Text(
                            '${widget.closeDate}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              widget.taskStatus == 'Closed' || widget.taskStatus == 'Completed'  ? Container():   Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: widget.ChangeStatus,
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.6,

                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.first.withOpacity(0.9),
                            widget.first.withOpacity(0.9)
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Center(
                          child: Text(
                          widget.taskStatus == 'Pending'
                                ? 'Accept'
                                :  "Done" ,
                            style: TextStyle(
                              color: whiteColor.withOpacity(1),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
