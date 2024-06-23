import 'package:college_mart/screens/select_college.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: '100% Privacy',
              body: 'No Data Collected',
              image: buildImage('assets/images/privacy.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Cash on Delivery',
              body: '',
              image: buildImage('assets/images/cod.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'No Login Required',
              body: 'No need to do Boring Signup/Signin process',
              image: buildImage('assets/images/nologin.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Delete an Item',
              body: 'Slide an Item to left to delete it',
              // footer: ButtonWidget(
              //   text: 'Start Reading',
              //   onClicked: () => goToHome(context),
              // ),
              image: buildImage('assets/images/delete.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),
          onDone: () => goToHome(context),
          showBackButton: true,
          back: Icon(Icons.arrow_back,color: Colors.black,
          ),
          // showSkipButton: true,
          // skip: Text('Skip'),
          // onSkip: () => goToHome(context),
          next: Icon(Icons.arrow_forward,color: Colors.black,size: 30,),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Colors.white,
          // skipFlex: 0,
          // nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => college_selecter()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        activeColor: Colors.blue,
        color: Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,fontFamily: "Poppins-Regular"),
        bodyTextStyle: TextStyle(fontSize: 20,fontFamily: "Poppins-Regular"),
        // descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white
        // pageColor: Colors.white,
      );
}