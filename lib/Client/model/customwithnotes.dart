
import 'package:flutter/material.dart';
import 'package:intership/Manager/assignTask.dart';
import 'package:intership/constant/color.dart';

class CustomWithNote extends StatefulWidget {
  final Color fontColor;
  final Color backgrondColor;
  final Color first;
  final Color second;
  final Color third;
  final Color forth;
  final Color fifth;
  final Color sixth;
  final String managername;
  final String operatorname;
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
  final String forthbuttontext;
  final String clientApproval;
  final String managerApproval;
  final String taskCategory;
  final VoidCallback addLink;
  final VoidCallback viewLink;
  final VoidCallback approve;
  final VoidCallback reject;

  const CustomWithNote(
      {Key? key,
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
        required this.taskCategory, required this.addLink, required this.viewLink, required this.ProjectName, required this.approve, required this.reject, required this.forthbuttontext, required this.managername, required this.operatorname
      })
      : super(key: key);

  @override
  _CustomWithNoteState createState() => _CustomWithNoteState();
}

class _CustomWithNoteState extends State<CustomWithNote> {
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.taskName} ",
                  style: TextStyle(
                    // #FED457
                      fontWeight: FontWeight.bold,
                      // color: Color(0xFED457),
                      color: widget.fontColor.withOpacity(1),
                      fontSize: 30),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Project Name : ${widget.ProjectName} ",
                  style: TextStyle(
                    // #FED457
                      fontWeight: FontWeight.bold,
                      // color: Color(0xFED457),
                      color: widget.fontColor.withOpacity(1),
                      fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  child: Text(
                    "Description : ${widget.taskDescription}",
                    style: TextStyle(color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  child: Text(
                    "Client Note : ${widget.clientNote}",
                    style: TextStyle(color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  child: Text(
                    "Manager Note : ${widget.managerNote}",
                    style: TextStyle(color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  child: Text(
                    "Assigned Manager : ${widget.managername} ",
                    style: TextStyle(color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  child: Text(
                    "Assigned Operator : ${widget.operatorname}",
                    style: TextStyle(color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              ),
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
                            '${widget.taskStatus}',
                            // widget.backgrondColor == greenColor
                            //     ? "Request"
                            //     : (widget.backgrondColor == orangeColor
                            //         ? "Assigned"
                            //         : (widget.backgrondColor == blueColor
                            //             ? "Running"
                            //             : "Done")),
                            style: TextStyle(
                              color: widget.first == creamColor2
                                  ? yellowColor.withOpacity(0.9)
                                  : creamColor2.withOpacity(0.9),
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
                      width: 120,
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
                      child:  Padding(
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
                            widget.third.withOpacity(0.9),
                            widget.third.withOpacity(0.9)
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
                            '${widget.forthbuttontext}',
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
                    onTap:  widget.viewLink,
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
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Center(
                          child: Text(
                            'View Links',
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
                    onTap:  widget.addLink,
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
                            'Add Link',
                            style: TextStyle(
                              color: widget.sixth == creamColor2
                                  ? yellowColor.withOpacity(0.9)
                                  : creamColor2.withOpacity(0.9),
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
              if (widget.managerApproval == 'Accepted' &&
                  (widget.clientApproval == 'Pending' ||
                      widget.clientApproval == 'Rejected') &&
                  widget.taskStatus == 'Completed')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: widget.approve,
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
                      onTap: widget.reject,
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
              // color: const Color(0xffc3f7ab),
              // splashColor: Colors.lightBlueAccent,
              // elevation: 10.0,
              // shape: const StadiumBorder(),
              // child: const Padding(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: 10, vertical: 10),
              //     child: Text('Accept')
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
