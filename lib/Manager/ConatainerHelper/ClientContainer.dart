import 'package:flutter/material.dart';
import 'package:intership/Manager/assignTask.dart';
import 'package:intership/constant/color.dart';

class ClientContainer extends StatefulWidget {
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
  final VoidCallback assignTask;
  final VoidCallback TimeLineDoc;
  final VoidCallback AttachDoc;
  final VoidCallback ChangeStatus;
  final VoidCallback Approve;
  final VoidCallback Reject;
  final String who;

  const ClientContainer({
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
    required this.Reject,
  }) : super(key: key);

  @override
  _ClientContainerState createState() => _ClientContainerState();
}

class _ClientContainerState extends State<ClientContainer> {
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
                  widget.who == 'operator'
                      ? Container()
                      : Row(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    widget.fontColor.withOpacity(01)),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.who == 'operator'
                                  ? "Operator"
                                  : "${widget.clientId}",
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
                  "Tasks Name : ${widget.taskName} ",
                  style: TextStyle(
                      // #FED457
                      fontWeight: FontWeight.w600,
                      // color: Color(0xFED457),
                      color: widget.fontColor.withOpacity(1),
                      fontSize: 15),
                ),
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
              widget.backgrondColor != greenColor
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text(
                          "Manager note:   ${widget.managerNote}",
                          style: TextStyle(
                              color: widget.fontColor.withOpacity(0.8)),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: widget.ChangeStatus,
                    child: Container(
                      width: 100,
                      height: 46,
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
                            widget.who == 'operator'
                                ? 'Status'
                                : '${widget.taskStatus}',
                            // widget.backgrondColor == greenColor
                            //     ? "Request"
                            //     : (widget.backgrondColor == orangeColor
                            //         ? "Assigned"
                            //         : (widget.backgrondColor == blueColor
                            //             ? "Running"
                            //             : "Done")),
                            style: TextStyle(
                              color: widget.first == greyColor
                                  ? yellowColor.withOpacity(0.9)
                                  : greyColor.withOpacity(0.9),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.TimeLineDoc,
                    child: Container(
                      width: 100,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.second.withOpacity(0.7),
                            widget.second.withOpacity(0.7)
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
                            widget.who == 'manager' ? 'Open' : 'TimeLine',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
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
                      width: 120,
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Center(
                          child: Text(
                            '${widget.openDate}',
                            style: TextStyle(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AssignTask()));
                    },
                    child: Container(
                      width: 120,
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.assignTask,
                    child: Container(
                      width: 100,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.fifth.withOpacity(0.9),
                            widget.fifth.withOpacity(0.9)
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
                            widget.backgrondColor == greenColor
                                ? "ASSIGN"
                                : widget.priority,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                            widget.who == 'manager' ? 'Add Link' : 'AttachDoc',
                            style: TextStyle(
                              color: widget.sixth == greyColor
                                  ? yellowColor.withOpacity(0.9)
                                  : greyColor.withOpacity(0.9),
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
              if (widget.backgrondColor == yellowColor)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: widget.Approve,
                      child: Container(
                        width: 130,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.green,
                              Colors.greenAccent,
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
                              'APPROVE',
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
                      onTap: widget.Reject,
                      child: Container(
                        width: 130,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.red,
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
                              'Reject',
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
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
