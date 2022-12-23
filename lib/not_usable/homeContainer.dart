import 'package:flutter/material.dart';
import 'package:intership/not_usable/Button.dart';

import '../constant/color.dart';

class HomeContainer extends StatefulWidget {
  final Color runtimeColor;
  final Color openColor;
  final Color UdateColor;
  final Color BdateColor;
  final Color urgentColor;
  final Color addlinkColor;
  final Color fontColor;
  final Color backgrondColor;
  const HomeContainer({Key? key, required this.runtimeColor, required this.openColor, required this.UdateColor, required this.BdateColor, required this.urgentColor, required this.addlinkColor, required this.fontColor, required this.backgrondColor}) : super(key: key);

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            widget.backgrondColor.withOpacity(0.98),
            widget.backgrondColor.withOpacity(0.98),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          border: Border.all(
            color: Color(0x282019).withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 2, top: 2, bottom: 5),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Stack(children: [
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                          radius: 20,
                          backgroundColor:
                          Color(0xFED457).withOpacity(0.8)),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Client name",
                        style: TextStyle(
                          // #FED457
                            fontWeight: FontWeight.w600,
                            // color: Color(0xFED457),
                            color: widget.fontColor.withOpacity(0.9),
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: widget.fontColor.withOpacity(0.8),
                            size: 30,
                          ),
                          onPressed: () => {
                            print("Delete")
                          }),
                    ],
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Text(
                    "now theres a best way to achieve this, its ListTile."
                        " it has leading property for left side, and title and subtitle, and then for right side widgets it has trailing property.",
                    style: TextStyle(
                        color: widget.fontColor.withOpacity(0.8)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GlowingButton(
                      color1: widget.runtimeColor.withOpacity(0.8),
                      color2: widget.runtimeColor.withOpacity(0.8),
                      buttonString: 'RunTime',
                    ),
                    GlowingButton(
                      color1: widget.openColor.withOpacity(0.8),
                      color2: widget.openColor.withOpacity(0.8),
                      buttonString: 'Open',
                    ),
                    GlowingButton(
                        color1: widget.UdateColor.withOpacity(0.8),
                        color2: widget.UdateColor.withOpacity(0.8),
                        buttonString: '11-11-22'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GlowingButton(
                      color1: widget.BdateColor.withOpacity(0.8),
                      color2: widget.BdateColor.withOpacity(0.8),
                      buttonString: '11-11-22',
                    ),
                    GlowingButton(
                      color1: widget.urgentColor.withOpacity(0.8),
                      color2: widget.urgentColor.withOpacity(0.8),
                      buttonString: 'Urgent',
                    ),
                    GlowingButton(
                      color1: widget.addlinkColor.withOpacity(0.9),
                      color2: widget.addlinkColor.withOpacity(0.9),
                      buttonString: 'AddLink',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
