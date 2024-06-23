// import 'package:college_mart/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../bottomnavbar.dart';

class college_selecter extends StatelessWidget {
  const college_selecter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'COLLEGE MART',
            style: TextStyle(fontSize: 24),
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Your College :',
                style: TextStyle(fontSize: 23),
              ),
              SizedBox(
                height: 15,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 22),
                  itemCount: college_list.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return college_widget(
                        college_logo: college_list[index][1],
                        college_name: college_list[index][0]);
                  }),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class college_widget extends StatelessWidget {
  String college_logo;
  String college_name;
  college_widget({
    required this.college_logo,
    required this.college_name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
          if (college_name == 'DTU') {
              prefs.setBool('isDTU', true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const bottomnavigationbar1()),
            );
          }
          if (college_name == 'NSUT') {
              prefs.setBool('isNSUT', true);
                 showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message:
                                        'Coming Super Soon to Your College',
                                    // icon: Icon(Icons.info_outline),
                                    // backgroundColor: Colors.blue,
                                  ),
                                );
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const bottomnavigationbar1()),
            // );
          }
          if (college_name == 'IGDTUW') {
              prefs.setBool('isIGDTUW', true);
                   showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message:
                                        'Coming Super Soon to Your College',
                                    // icon: Icon(Icons.info_outline),
                                    // backgroundColor: Colors.blue,
                                  ),
                                );
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const bottomnavigationbar1()),
            // );
          }
          if (college_name == 'IIIT D') {
              prefs.setBool('isIIITD', true);
                 showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message:
                                        'Coming Super Soon to Your College',
                                    // icon: Icon(Icons.info_outline),
                                    // backgroundColor: Colors.blue,
                                  ),
                                );
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const bottomnavigationbar1()),
            // );
          }
        },
        child: Container(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.229,
                  child: Image.asset(
                    college_logo,
                    fit: BoxFit.scaleDown,
                  )),
              Text(
                college_name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}

List college_list = [
  [
    'DTU',
    'assets/images/dtu_logo.png',
  ],
  ['NSUT', 'assets/images/nsut.png'],
  ['IGDTUW', 'assets/images/igdtuw.png'],
  ['IIIT D', 'assets/images/iiit.png']
];
