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

  const ClientContainer(
      {Key? key,
      required this.fontColor,
      required this.backgrondColor,
      required this.first,
      required this.second,
      required this.third,
      required this.forth,
      required this.fifth,
      required this.sixth})
      : super(key: key);

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
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                          radius: 20,
                          backgroundColor: widget.fontColor.withOpacity(01)),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Client name",
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
                  "Tasks Name : ABC XYZ ",
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
                    "Description : \n   now theres a best way to achieve this, its ListTile."
                    "it has leading property for left side, and title and subtitle,"
                    "and then for right side widgets it has trailing property.",
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
                            widget.backgrondColor == greenColor
                                ? "Request"
                                : (widget.backgrondColor == orangeColor
                                    ? "Assigned"
                                    : (widget.backgrondColor == blueColor
                                        ? "Running"
                                        : "Done")),
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
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AssignTask()));
                    },
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
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Center(
                          child: Text(
                            'Open',
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
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Center(
                          child: Text(
                            '01.02.023',
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
                      width: 100,
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
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Center(
                          child: Text(
                            '01.01.023',
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
                      if (widget.backgrondColor == greenColor)
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AssignTask()));
                    },
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
                                : "urgent",
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
                      onTap: () {},
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
                      onTap: () {},
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
