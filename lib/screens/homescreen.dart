import 'package:cached_network_image/cached_network_image.dart';
import 'package:college_mart/functions/ad.dart';
import 'package:college_mart/screens/product_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nopsuite_carousel_slider/effects/worm_effect.dart';
import 'package:nopsuite_carousel_slider/nopsuite_carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../functions/model_theme.dart';
// import 'package:line_icons/line_icons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  List<FeedbackModel> feedbacks = <FeedbackModel>[];
  getFeedbackFromSheet() async {
    print('start');
    var raw = await http.get(Uri.parse(
        "https://script.google.com/macros/s/AKfycbwdO8WZJy1mSGnUZV9qGIzCTq4Kytczk5VCHGeTRps0Y43YNU-M-nbrgZGxdXghxvifCA/exec"));

    // var jsonFeedback = convert.jsonDecode(raw.body);
    var jsonFeedback2 = convert.jsonDecode(raw.body);
    print('1');
    print(jsonFeedback2);
    print("2");
    print('this is json Feedback $jsonFeedback2');

    // feedbacks = jsonFeedback.map((json) => FeedbackModel.fromJson(json));

    await jsonFeedback2.forEach((element) {
      print('$element THIS IS NEXT>>>>>>>');
      FeedbackModel feedbackModel = new FeedbackModel();
      feedbackModel.image = element['Image'];
      feedbackModel.link = element['Link'];

      feedbacks.add(feedbackModel);
    });

    print('${feedbacks[0]}');
    print(feedbacks.length);
  }
  var length=0;

  @override
  void initState() {
    // getFeedbackFromSheet();
    length=feedbacks.length;
    print("length : $length");
    super.initState();
  }
  // List<AdModel> ads2 = <AdModel>[];
  // getadsfromsheet() async {
  //   print('start');
    // var raw = await http.get(Uri.parse(
    //     "https://script.google.com/macros/s/AKfycbw5o_baEJfIuyP8OyrRSUM3pGPF4Ehz5IRFAD_Cz_vvkMbCoajooFts53iUakms-yZW-A/exec"));
  //   var jsonad = convert.jsonDecode(raw.body);
  //   jsonad.map((json) => AdModel.fromJson(json));
  //   jsonad.forEach((element) {
  //     AdModel adModel = new AdModel();
  //     adModel.Image=element['Image'];
  //     adModel.Link=element['Link'];
  //     print(admode);

  //     ads2.add(adModel);
  //   });
  //   print('done');
  // }

  @override
  Widget build(BuildContext context) {
    // getFeedbackFromSheet();
    // feedbacks.shuffle();
 
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        // backgroundColor: Colors.blue[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 40,
          elevation: 0,
          title: Center(
              child: Text(
            'COLLEGE  MART',
            style: TextStyle(
                fontFamily: "Tektur-VariableFont_wdth,wght", fontSize: 25),
          )),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  // themeNotifier.isDark
                  //     ? themeNotifier.isDark = false
                  //     : themeNotifier.isDark = true;
                  setState(() {
                    themeNotifier.isDark = !themeNotifier.isDark;
                    // isdark=themeNotifier.isDark;
                  });
                },
                icon: themeNotifier.isDark
                    ? Icon(
                        Icons.nights_stay_rounded,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.sunny,
                        color: Colors.black,
                      ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                TextField(
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search_rounded),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
                SizedBox(
                  height: 15,
                ),
                FutureBuilder(
          future: getFeedbackFromSheet(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting || feedbacks.length==0) {
              return  Center(child: CircularProgressIndicator()); 
            } else {
              if (snapshot.hasError) {
                return new Text("fetch error");
              } else {
                print("here");
                print(feedbacks.length);
                   var pages = List.generate (
      feedbacks.length,
      (index) => Container(
        // height: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // borderRadius: BorderRadius.circular(16),
          // color: colors[index],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: SizedBox(
          height: 100,
          child: InkWell(
            onTap: () async {
              // try {
              //   // await launch(URL+ feedbackForm.toParams());
              //   await launchUrl(Uri.parse(feedbacks[index].link!,),mode: LaunchMode.externalApplication);

              // } catch (e) {
              //   print(e);
              // }
              await launchUrl(Uri.parse(feedbacks[index].link!,),mode: LaunchMode.externalApplication);

            },
            // child: Center(child: Image.network(feedbacks[index].image!)),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: CachedNetworkImage(imageUrl:feedbacks[index].image!,
              placeholder: (context, url) => CircularProgressIndicator(),fit: BoxFit.fill,),
            ),
          ),
        ),
      ),
    );
                return  ady(controller: controller, pages: pages,);
                // return new Container(
                //     height: 250.0,
                //     child: new Carousel(
                //       boxFit: BoxFit.cover,
                //       images: [NetworkImage(snapshot.data[0].)],
                //       autoplay: true,
                //       dotSize: 4.0,
                //       indicatorBgPadding: 4.0,
                //       animationCurve: Curves.fastOutSlowIn,
                //       animationDuration: Duration(milliseconds: 1000),
                //     ));
              }
            }
          }),
                // ady(controller: controller, pages: pages,),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Kits',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins-Regular'),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: dtu_homepage_semesterkit.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SemesterKit(
                              name: dtu_homepage_semesterkit[index][0],
                              rang: Colors.blue,
                              itemcode: index);
                        })),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins-Regular'),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: dtu_homepage_products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              child: Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                          height: 77,
                                          child: Image.asset(
                                              dtu_homepage_products[index][1])),
                                      Text(dtu_homepage_products[index][0],
                                          style: TextStyle(
                                              fontFamily: 'Poppins-Regular'),
                                          overflow: TextOverflow.ellipsis),
                                      Container(
                                          alignment: Alignment.bottomRight,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                            '₹${dtu_homepage_products[index][2]}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          )))
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    color: Colors.grey.withOpacity(0.25),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                width: 111,
                                height: 147,
                              ),
                              onTap: () {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message:
                                        '${dtu_homepage_products[index][0]} added to cart',
                                    // icon: Icon(Icons.info_outline),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                                if (dtu_homepage_products[index][3] == 0) {
                                  dtu_homepage_products[index][3]++;
                                  print(cart_list.length);

                                  cart_list.add(dtu_homepage_products[index]);
                                  print(cart_list);
                                }
                                ;
                                print('Pressed');
                              });
                        })),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '2nd Hand',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins-Regular'),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: dtu_homepage_secondhand.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              child: Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                          height: 77,
                                          child: Image.asset(
                                              dtu_homepage_secondhand[index]
                                                  [1])),
                                      Text(dtu_homepage_secondhand[index][0],
                                          style: TextStyle(
                                              fontFamily: 'Poppins-Regular'),
                                          overflow: TextOverflow.ellipsis),
                                      Container(
                                          alignment: Alignment.bottomRight,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                            '₹${dtu_homepage_secondhand[index][2]}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          )))
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    color: Colors.grey.withOpacity(0.25),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                width: 111,
                                height: 147,
                              ),
                              onTap: () {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message:
                                        '${dtu_homepage_secondhand[index][0]} added to cart',
                                    // icon: Icon(Icons.info_outline),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                                if (dtu_homepage_secondhand[index][3] == 0) {
                                  dtu_homepage_secondhand[index][3]++;
                                  print(cart_list.length);

                                  cart_list.add(dtu_homepage_secondhand[index]);
                                  print(cart_list);
                                }
                                ;
                                print('Pressed');
                              });
                        })),

                //stationary
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Stationary',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins-Regular'),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: dtu_homepage_stationary.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    color: Colors.grey.withOpacity(0.25),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                width: 111,
                                height: 147,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                          height: 77,
                                          child: Image.asset(
                                              dtu_homepage_stationary[index]
                                                  [1])),
                                      Text(dtu_homepage_stationary[index][0],
                                          style: TextStyle(
                                              fontFamily: 'Poppins-Regular'),
                                          overflow: TextOverflow.ellipsis),
                                      Container(
                                          alignment: Alignment.bottomRight,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10))),
                                          child: Center(
                                              child: Text(
                                            '₹${dtu_homepage_stationary[index][2]}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          )))
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message:
                                        '${dtu_homepage_stationary[index][0]} added to cart',
                                    // icon: Icon(Icons.info_outline),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                                if (dtu_homepage_stationary[index][3] == 0) {
                                  dtu_homepage_stationary[index][3]++;
                                  print(cart_list.length);

                                  cart_list.add(dtu_homepage_stationary[index]);
                                  print(cart_list);
                                }
                                ;
                                print('Pressed');
                              });
                        })),

                //starter kit

                // Text(
                //   'Starter  Kit',
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.w600,
                //       fontFamily: 'Poppins-Regular'),
                // ),
                // SingleChildScrollView(
                //   child: Row(
                //     children: [
                //       InkWell(
                //         child: Container(
                //           decoration: BoxDecoration(
                //               color: Colors.blue,
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(20))),
                //           width: 100,
                //           height: 130,
                //         ),
                //         onTap: () => print('tapped'),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             color: Colors.blue,
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(20))),
                //         width: 100,
                //         height: 130,
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             color: Colors.blue,
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(20))),
                //         width: 100,
                //         height: 130,
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             color: Colors.blue,
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(20))),
                //         width: 100,
                //         height: 130,
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             color: Colors.blue,
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(20))),
                //         width: 100,
                //         height: 130,
                //       ),
                //     ],
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   ),
                //   scrollDirection: Axis.horizontal,
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ady extends StatelessWidget {
  String? Image;
  String? Link;
  ady({
    required this.controller,
    required this.pages,
    this.Image,
    this.Link,
  });

  final PageController controller;
  final List<Container> pages;

  @override
  Widget build(BuildContext context) {
    return NopSuiteCarouselSlider(
      controller: controller,
      count: pages.length,
      itemBuilder: pages,
      height: MediaQuery.of(context).size.width * 9 / 16,
      effect: WormEffect(
        dotHeight: 8,
        dotWidth: 16,
        radius: 4,
        dotColor: Colors.grey,
        activeDotColor: Colors.deepPurpleAccent,
        type: WormType.normal,
        strokeWidth: 5,
      ),
    );
  }
}

// ignore: must_be_immutable
class SemesterKit extends StatelessWidget {
  String name;
  var rang;
  int itemcode;
  SemesterKit({
    super.key,
    required this.name,
    required this.rang,
    required this.itemcode,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    height: 77,
                    child: Image.asset(dtu_homepage_semesterkit[itemcode][1])),
                Text(name,
                    style: TextStyle(fontFamily: 'Poppins-Regular'),
                    overflow: TextOverflow.ellipsis),
                Container(
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Center(
                        child: Text(
                      '₹${dtu_homepage_semesterkit[itemcode][2]}',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )))
              ],
            ),
          ),
          decoration: BoxDecoration(
              // color: Colors.amber,
              color: Colors.grey.withOpacity(0.25),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: 111,
          height: 250,
        ),
        onTap: () {
          product_selected = itemcode;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => product_discription(
                    product_included: 'kartik',
                    product_name: name,
                    Product_pice:
                        dtu_homepage_semesterkit[itemcode][2].toString())),
          );
        });
  }
}

int product_selected = 0;

final colors = [
  Colors.red.shade100,
  Colors.green.shade100,
  Colors.greenAccent.shade100,
  Colors.amberAccent.shade100,
  Colors.blue.shade100,
  Colors.amber.shade100,
];

final List ads = [
  [
    'assets/images/ad0.png',
    'https://instagram.com/college__mart?utm_source=qr&igshid=MzNlNGNkZWQ4Mg%3D%3D'
  ],
  ['assets/images/ad1.png', 'https://collegemartt.blogspot.com/'],
  ['assets/images/ad2.png', 'https://freemoneycollegemart.blogspot.com/'],
];

final List dtu_homepage_semesterkit = [
  [
    'Starter Kit',
    'assets/images/starter_kit.png',
    450,
    0,
  ],
  [
    'Semester Kit',
    'assets/images/semester_kit.png',
    250,
    0,
  ],
  // ['LabCoat', 'assets/images/labcoat.png',100],
  // ['Apron','assets/images/labcoat.png',100]
];

final List dtu_homepage_secondhand = [
  ['Apron(2)', 'assets/images/apron.png', 90, 0],
  ['Labcoat(2)', 'assets/images/labcoat.png', 150, 0],
  ['Mini Drafter(2)', 'assets/images/md.png', 150, 0],
  ['Sheet Holder(2)', 'assets/images/sh.png', 120, 0],
  ['Scientific Calculator', 'assets/images/sc.png', 1000, 0]
];
final List dtu_homepage_products = [
  ['Apron', 'assets/images/apron.png', 120, 0],
  ['Labcoat', 'assets/images/labcoat.png', 300, 0],
  ['Mini Drafter', 'assets/images/md.png', 250, 0],
  ['Sheet Holder', 'assets/images/sh.png', 150, 0],
  ['Scientific Calculator', 'assets/images/sc.png', 1000, 0]
];

final List dtu_homepage_stationary = [
  ['Spiral Register', 'assets/images/register.png', 100, 0],
  ['Practical File', 'assets/images/practical_file.png', 60, 0],
  ['Auxillary Notebook', 'assets/images/auxi.png', 10, 0],
  ['Blue Pen', 'assets/images/blue_pen.png', 10, 0],
  ['Black Pen', 'assets/images/black_pen.png', 10, 0],
];
// final List item = [
//   ['Starter Kit', 500, 0],
//   ['Semester Kit', 100, 0],
// ];
// final List itemcost = ['₹500', '₹100', '₹10', '10k-100k'];
List cart_list = [];
