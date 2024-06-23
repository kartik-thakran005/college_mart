// import 'package:college_mart/screens/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:college_mart/screens/homescreen.dart';
import 'package:college_mart/screens/pg.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
// import 'package:line_icons/line_icon.dart';
import 'package:nopsuite_carousel_slider/effects/worm_effect.dart';
import 'package:nopsuite_carousel_slider/nopsuite_carousel_slider.dart';
import 'package:share_whatsapp/share_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../functions/pg_model.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class pg_info extends StatefulWidget {
  const pg_info({super.key});

  @override
  State<pg_info> createState() => _pg_infoState();
}

class _pg_infoState extends State<pg_info> {
  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 0.8, keepPage: true);
    List<String> pg_images=[];
     List<FeedbackModel> feedbacks = <FeedbackModel>[];
  getFeedbackFromSheet() async {
    print('start');
    var raw = await http.get(Uri.parse(
        "https://script.google.com/macros/s/AKfycbxh6KsaFaLar7kThmC8gSskV8qM65CPr3CQqr-3nqz8vdhubN8HxVrkh5YoHPLFlZJYlw/exec"));

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
      feedbackModel.price = element['Price'].toString();
      feedbackModel.imagee2 = element['Image2'].toString();
      feedbackModel.imagee3 = element['Image3'].toString();
      feedbackModel.name = element['Name'];
      feedbackModel.imagee4 = element['Image4'];
      feedbackModel.imagee5 = element['Image4'];
      feedbackModel.description = element['Description'];
      feedbackModel.wnumber = element['Number'].toString();
      feedbackModel.location = element['Location'];
      feedbacks.add(feedbackModel);
      pg_images.add(feedbackModel.image!);
      pg_images.add(feedbackModel.imagee2!);
      pg_images.add(feedbackModel.imagee3!);
      pg_images.add(feedbackModel.imagee4!);
      pg_images.add(feedbackModel.imagee5!);

    });
    

    print('${feedbacks[0]}');
    print(feedbacks.length);
  }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        toolbarHeight: 40,
        elevation: 0,
        title:FutureBuilder(
          future: getFeedbackFromSheet(),
          // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting || feedbacks.length==0) {
              return  Center(child: CircularProgressIndicator()); 
            } else {
              if (snapshot.hasError) {
                return new Text("fetch error");
              } else {
            return Center(
            child: Text(
          feedbacks[pg_selected].name!,
          style: TextStyle(
              fontFamily: "Tektur-VariableFont_wdth,wght", fontSize: 25),
        ));}}
          },
        ),
         
        backgroundColor: Colors.transparent,actions: [IconButton(onPressed: (() async {
                                  try {
                                    // await launch(URL+ feedbackForm.toParams());
                                    await launchUrl(Uri.parse(feedbacks[pg_selected].location!),
                                        mode: LaunchMode.externalApplication);
                                  } catch (e) {
                                    print(e);
                                  }
                                }), icon: Icon(Icons.location_on))],
      ),
      bottomNavigationBar: BottomAppBar(color: Colors.transparent,child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              height: 50,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(LineIcons.whatSApp,size: 35,),SizedBox(width: 5,),
                    Text(
                      'Enquire now',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          fontFamily: 'Poppins-Regular'),
                    ),
                  ],mainAxisAlignment: MainAxisAlignment.center,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: () async {
                  var whatsapp="+918700927933";
                  var whatsappUrl =
        "https://wa.me/91${feedbacks[pg_selected].wnumber!}?text=I%20want%20to%20enquire%20about%20${feedbacks[pg_selected].name!}%20listed%20on%20college%20mart";
                  print("hi");
                  await launchUrl(Uri.parse(whatsappUrl),
                                        mode: LaunchMode.externalApplication);
                  // shareWhatsapp.share(text:"Hi , I want to Enquire about ${feedbacks[pg_selected].name!} listed on Coleege Mart App",phone: feedbacks[pg_selected].wnumber,);
          
          
                  // Future<void> shareFile() async{
                  //   print("hi2");
                  //   await WhatsappShare.shareFile(
                  //     text: "Hi , I want to Enquire about ${feedbacks[pg_selected].name!} listed on Coleege Mart App",
                  //     filePath: [feedbacks[pg_selected].image!], phone: feedbacks[pg_selected].wnumber!);
                  // }
          
                },
              ),
            ),
          ),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
          future: getFeedbackFromSheet(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting || feedbacks.length==0) {
              return  Center(child: CircularProgressIndicator()); 
            } else {
              if (snapshot.hasError) {
                return new Text("fetch error");
              } else { return
          Column(
      children: [
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
      5,
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
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: CachedNetworkImage(imageUrl:"${pg_images[index+pg_selected*5]}",
            placeholder: (context, url) => CircularProgressIndicator(),fit: BoxFit.fill,),
          ),
        ),
      ),
    );
                // return  ady(controller: controller, pages: pages,);
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
                return images_pg(controller: controller, pages: pages);
              }
            }
          }),
        // Container(color: Colors.blue,height: 500,),
        
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: Row(
            children: [
              Text(
                feedbacks[pg_selected].name!,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '₹${feedbacks[pg_selected].price}',
                // 'hi',
                style: TextStyle(color: Colors.green, fontSize: 25,fontWeight: FontWeight.w700),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(feedbacks[pg_selected].description!,textAlign: TextAlign.left,),
          ],
        ),
        SizedBox(
          height: 10,
        ),
       
      ],
    );
  }}})),
      ),
    );
  }
}

class pg_info_widget extends StatelessWidget {
  const pg_info_widget({
    super.key,
    required this.controller,
    required this.pages,
    required this.feedbacks,
  });

  final PageController controller;
  final List<Container> pages;
  final List<FeedbackModel> feedbacks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        // Container(color: Colors.blue,height: 500,),
        images_pg(controller: controller, pages: pages),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: Row(
            children: [
              Text(
                feedbacks[pg_selected].name!,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '₹${feedbacks[pg_selected].price}',
                // 'hi',
                style: TextStyle(color: Colors.green, fontSize: 25,fontWeight: FontWeight.w700),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(feedbacks[pg_selected].description!,style: TextStyle(fontSize: 20,fontFamily: 'Poppins-Regular',),),
          ],
        ),
        SizedBox(
          height: 10,
        ),
       
      ],
    );
  }
}

class images_pg extends StatelessWidget {
  const images_pg({
    super.key,
    required this.controller,
    required this.pages,
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

/*
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
            child: CachedNetworkImage(imageUrl:feedbacks[index].image!,
            placeholder: (context, url) => CircularProgressIndicator(),),
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

  */