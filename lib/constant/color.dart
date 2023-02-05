import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const Color redColor = Color(0xEE281C);
const Color yellowColor =  Color(0xFED457);
const Color creamColor2 = Color(0xfffebe5);  // cream color
const Color whitegreyColor = Color(0xfffdf1dc);  // change ffebe5
const Color blackColor  = Color(0x000000);
//daf6f4
const Color creamColor  = Color(0xfdaf6f4);
const Color blueColor  = Color(0xfcfecff);  // change
const Color blueColor1   = Color(0xf2196F3FF);
const Color orangeColor  = Color(0xFFA500);
const Color whiteColor  = Color(0xFFFFFF);


class MyLoading extends StatelessWidget {
  const MyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SpinKitDancingSquare(
              color: Colors.grey.withOpacity(1),
            ),
            Text("Loading...")
          ],
        ));
  }
}
