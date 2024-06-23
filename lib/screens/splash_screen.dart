// import 'dart:async';

// import 'dart:ffi';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:college_mart/screens/on_boarding.dart';
// import 'package:college_mart/screens/homescreen.dart';
import 'package:college_mart/screens/select_college.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../bottomnavbar.dart';

// ignore: must_be_immutable
class splash_screen extends StatefulWidget {
   bool DTU;
   bool NSUT;
   bool IGDTUW;
   bool IIITD;
   splash_screen({super.key,required this.DTU,required this.NSUT,required this.IGDTUW,required this.IIITD});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.transparent,
      duration: const Duration(milliseconds: 2000),
      onInit: () {
        debugPrint("On Init");
        // print(widget.user);
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset('assets/images/collegemart.png'),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      // defaultNextScreen: widget.DTU?bottomnavigationbar1(): widget.NSUT?bottomnavigationbar1():widget.IGDTUW?bottomnavigationbar1():widget.IIITD?bottomnavigationbar1():OnBoardingPage(),
      defaultNextScreen: widget.DTU?bottomnavigationbar1():OnBoardingPage(),
      // defaultNextScreen:
      //     (_isdtu!) ? const bottomnavigationbar1() : const college_selecter(),
    );
  }
}
//widget.user?bottomnavigationbar1():