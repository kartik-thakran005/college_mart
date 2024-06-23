import 'package:college_mart/screens/about.dart';
import 'package:college_mart/screens/cart.dart';
import 'package:college_mart/screens/freelacing.dart';
import 'package:college_mart/screens/homescreen.dart';
import 'package:college_mart/screens/pg.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'functions/model_theme.dart';

class bottomnavigationbar1 extends StatefulWidget {
  const bottomnavigationbar1({super.key});
  

  @override
  State<bottomnavigationbar1> createState() => _bottomnavigationbar1State();
}

class _bottomnavigationbar1State extends State<bottomnavigationbar1> {
  // int _index=0;
  
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  // ignore: unused_field
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Freelancing',
      style: optionStyle,
    ),
    Text(
      'Pg Finder',
      style: optionStyle,
    ),
    Text(
      'Cart',
      style: optionStyle,
    ),
        Text(
      'About',
      style: optionStyle,
    ),
  ];
  final screens = [
    MyHomePage(),
    freellancing(),
    pg(),
    cart(),
    about()
  ];
  @override
  Widget build(BuildContext context) {
        return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: themeNotifier.isDark? Colors.black:Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     blurRadius: 20,
                //     color: Colors.black.withOpacity(.1),
                //   ),
                // ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GNav(
                    rippleColor: themeNotifier.isDark?Colors.black:Colors.grey[300]!,
                    hoverColor: themeNotifier.isDark?Colors.black:Colors.purple[100]!,
                    gap: 8,
                    activeColor:themeNotifier.isDark?Colors.white: Colors.black,
                    iconSize: 20,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    duration: Duration(milliseconds: 400),
                    tabBackgroundColor:themeNotifier.isDark?Colors.grey[800]!: Colors.grey[300]!,
                    color:themeNotifier.isDark?Colors.white: Colors.black,
                    tabs: [
                      GButton(
                        icon: LineIcons.home,
                        text: 'Home',onPressed: (){print('HOME');},
                      ),
                      GButton(
                        icon: LineIcons.handshake,
                        text: 'Freelancer',
                      ),
                      GButton(
                        icon: LineIcons.building,
                        text: 'Find Pg',
                      ),
                      GButton(
                        icon: LineIcons.shoppingBasket,
                        text: 'Cart',
                      ),
                                      GButton(
                        icon: LineIcons.infoCircle,
                        text: 'About',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );});
  }
}
