// import 'package:college_mart/bottomnavbar.dart';
// import 'package:college_mart/screens/select_college.dart';
import 'package:college_mart/screens/on_boarding.dart';
import 'package:college_mart/screens/splash_screen.dart';
// import 'package:college_mart/screens/homescreen.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'functions/model_theme.dart';

void main() async {
 runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDTU=false;
  bool isNSUT=false;
  bool isIGDTUW=false;
  bool isIIITD=false;

  @override
  void initState(){
    super.initState();

    _initcheck();
  }

  void _initcheck() async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return bool
      // bool? boolValue = prefs.getBool('isDTU');
      if(prefs.getBool('isDTU')!=null){
        setState(() {
          isDTU=prefs.getBool('isDTU')!;
        });
      }
            else if(prefs.getBool('isNSUT')!=null){
        setState(() {
          isNSUT=prefs.getBool('isNSUT')!;
        });
      }
           else if(prefs.getBool('isIGDTUW')!=null){
        setState(() {
          isIGDTUW=prefs.getBool('isIGDTUW')!;
        });
      }
           else if(prefs.getBool('isIIITD')!=null){
        setState(() {
          isIIITD=prefs.getBool('isIIITD')!;
        });
      }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
          title: 'College Mart',
          // theme: ThemeData.light(), // Provide light theme.
          // darkTheme: ThemeData.dark(), // Provide dark theme.
          // themeMode: ThemeMode.system,
          theme: themeNotifier.isDark
              ? ThemeData(
                  fontFamily: 'Tektur-VariableFont_wdth,wght',

                  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  // colorScheme: ColorScheme.dark(),

                  useMaterial3: true,
                  brightness: Brightness.dark)
              : ThemeData(
                  fontFamily: 'Tektur-VariableFont_wdth,wght',
                  brightness: Brightness.light,

                  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  // colorScheme: ColorScheme.dark(),

                  useMaterial3: true,
                ),
          debugShowCheckedModeBanner: false,
          // home: const bottomnavigationbar1(),
          home:  splash_screen(DTU: isDTU, NSUT: isNSUT, IGDTUW: isIGDTUW, IIITD: isIIITD),
          // home: OnBoardingPage(),
        );
      }),
    );
  }
}
