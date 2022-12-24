import 'package:flutter/material.dart';
import 'package:intership/Manager/managerHome.dart';
import '';

import 'not_usable/sevices/homepage.dart';
const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: home_manager(),
    );
  }
}



// void main() {
//   runApp(const MyApp());
// }
// }
//
// class start extends StatefulWidget {
//   const start({Key? key}) : super(key: key);
//
//   @override
//   _startState createState() => _startState();
// }
//
// class _startState extends State<start> {
//   final _pageController = PageController(initialPage: 2);
//
//   int maxCount = 5;
//
//   /// widget list
//   final List<Widget> bottomBarPages = [
//     const Page1(),
//     const Homepage(),
//     const Page5(),
//   ];
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: List.generate(
//             bottomBarPages.length, (index) => bottomBarPages[index]),
//       ),
//       extendBody: true,
//       bottomNavigationBar: (bottomBarPages.length <= maxCount)
//           ? AnimatedNotchBottomBar(
//         pageController: _pageController,
//         color: yellowColor.withOpacity(0.9),
//         showLabel: false,
//         notchColor: Color(0x5f54e0).withOpacity(0.9),
//         bottomBarItems: const [
//           BottomBarItem(
//             inActiveItem: Icon(
//               Icons.home_filled,
//               color: Colors.blueGrey,
//             ),
//             activeItem: Icon(
//               Icons.home_filled,
//               color: Colors.yellow,
//             ),
//             itemLabel: 'Page 1',
//           ),
//           BottomBarItem(
//             inActiveItem: Icon(
//               Icons.add,
//               color: greyColor,
//             ),
//             activeItem: Icon(
//               Icons.add,
//               // size: ,
//               color: Colors.black,
//             ),
//           ),
//
//           BottomBarItem(
//             inActiveItem: Icon(
//               Icons.person,
//               color: Colors.blueGrey,
//             ),
//             activeItem: Icon(
//               Icons.person,
//               color: Colors.yellow,
//             ),
//             itemLabel: 'Page 5',
//           ),
//         ],
//         onTap: (index) {
//           /// control your animation using page controller
//           _pageController.animateToPage(
//             index,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.easeIn,
//           );
//         },
//       )
//           : null,
//     );
//   }
// }
//
// class Page1 extends StatelessWidget {
//   const Page1({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.yellow, child: const Center(child: Text('Page 1')));
//   }
// }
//
// class Page5 extends StatelessWidget {
//   const Page5({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.lightGreenAccent,
//         child: const Center(child: Text('Page 4')));
//   }
// }