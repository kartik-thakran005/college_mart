import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class about extends StatefulWidget {
  // final PageController? pageController;

  const about({
    super.key,
  });

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  PageController? _pageController;
  double pageOffset = 0;
  //  PageController _pageController=PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7);
    // setState(() {
    //   pageOffset=_pageController!.page!.toDouble();
    // });
    _pageController!.addListener(() {
      setState(() {
        pageOffset = _pageController!.page!.toDouble();
      });
    });
    // aboutInfo.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        title: Center(
            child: Text(
          'ABOUT',
          style: TextStyle(
              fontFamily: "Tektur-VariableFont_wdth,wght", fontSize: 25),
        )),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                            SizedBox(
                height: 10,
              ),
                            Text(
                'ABOUT COLLEGE MART : ',
                style: TextStyle(fontSize: 23,fontWeight: FontWeight.w800),
                textAlign: TextAlign.start,
                
              ),
              SizedBox(height: 10,),
              Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height *0.20,
                      child: InkWell(onDoubleTap:(){} ,child: Image.asset('assets/images/collegemart.png')))),
                      SizedBox(height: 5,),
               Padding(
                 padding: const EdgeInsets.only(left: 15,right: 15),
                 child: Text('Collge Mart is an app \nto cater all the needs of college studets',style: TextStyle(fontSize: 20,fontFamily: 'Poppins-Regular',
                 ),textAlign: TextAlign.center,),
               ),
              // Center(
              //     child: Container(
              //         height: MediaQuery.of(context).size.height / 3,
              //         child: Image.asset('assets/images/collegemart.png'))),
              SizedBox(
                height: 10,
              ),
                            Divider(
                endIndent: 40,
                indent: 40,
              ),
              SizedBox(height: 10,),
              Text(
                'ABOUT THE TEAM : ',
                style: TextStyle(fontSize: 23,fontWeight: FontWeight.w800),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 15,),
              Container(
                height: MediaQuery.of(context).size.height * 2.78/ 5,
                padding: EdgeInsets.only(bottom: 10),
                child: PageView.builder(
                    itemCount: aboutInfo.length,
                    controller: _pageController,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                aboutInfo[i][2],
                                height:
                                    MediaQuery.of(context).size.height * 3 / 5,
                                width:
                                    MediaQuery.of(context).size.width * 4.5 / 5,
                                fit: BoxFit.cover,
                                // alignment: Alignment.center,
                                alignment: Alignment(-pageOffset.abs() + i, 0),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              bottom: 20,
                              right: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    aboutInfo[i][0],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontFamily: 'BebasNeue-Regular'
                                        // fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                  Text(
                                    aboutInfo[i][1],
                                    style: TextStyle(
                                        color: Colors.blueAccent[400],
                                        fontSize: 16,
                                        fontFamily: 'BreeSerif-Regular'
                                        // fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Text(
                                  //   aboutInfo[i]['description'],
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 12,
                                  //       fontFamily: 'Raleway'
                                  //       ),
                                  // ),
                                ],
                              ),
                            ),

                            // adding social media links
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton(
                                onPressed: (() async {
                                  try {
                                    // await launch(URL+ feedbackForm.toParams());
                                    await launchUrl(Uri.parse(aboutInfo[i][3]),
                                        mode: LaunchMode.externalApplication);
                                  } catch (e) {
                                    print(e);
                                  }
                                }),
                                icon: LineIcon.instagram(),
                                color: Colors.black,
                                iconSize: 40,
                              ), //Socials(i)
                            )
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                endIndent: 40,
                indent: 40,
              ),
              SizedBox(height: 20,),
              Center(child: Text('Socials ',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)),
              Center(child: IconButton(onPressed: () async {
                                  try {
                                    // await launch(URL+ feedbackForm.toParams());
                                    await launchUrl(Uri.parse('https://instagram.com/college__mart?utm_source=qr&igshid=MzNlNGNkZWQ4Mg%3D%3D'),
                                        mode: LaunchMode.externalApplication);
                                  } catch (e) {
                                    print(e);
                                  }
                                }, icon: LineIcon.instagram(color: Colors.grey,size: 40,)))
            ],
          ),
        ),
      ),
    );
  }
}

class about_us extends StatelessWidget {
  const about_us({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          color: Colors.amber[300]),
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width * 0.7,
    );
  }
}

List aboutInfo = [
  [
    'KARTIK  THAKRAN',
    'FOUNDER & APP DEVELOPER',
    'assets/images/kartik.jpg',
    'https://instagram.com/kartik__thakran?igshid=OGQ5ZDc2ODk2ZA=='
  ],
    [
    'DAKSH DABAS',
    'MANAGER ',
    'assets/images/daksh.jpeg',
    'https://instagram.com/daksh.dabass?igshid=OGQ5ZDc2ODk2ZA=='
  ],
  [
    'HIMANSHU  RAO',
    'MANAGER ',
    'assets/images/HIMANSHU.jpg',
    'https://instagram.com/himanshuyadav__2?igshid=MzNlNGNkZWQ4Mg=='
  ],
  [
    'JIVESH  MUDGIL',
    'MANAGER ',
    'assets/images/JIVESH.jpeg',
    'https://instagram.com/mudgil.jivesh?igshid=MzNlNGNkZWQ4Mg=='
  ],
  [
    'HARSH  SAINI',
    'MANAGER ',
    'assets/images/HARSH.jpeg',
    'https://instagram.com/itz_harsh2808?igshid=OGQ5ZDc2ODk2ZA=='
  ],
    [
    'KUNAL LOHCHAB',
    'MANAGER ',
    'assets/images/kunal.jpeg',
    'https://instagram.com/ikunallohchab?igshid=MjEwN2IyYWYwYw=='
  ],
    [
    'UJJWAL MISHRA',
    'UI DESIGNER',
    'assets/images/ujjwal.jpeg',
    'https://instagram.com/college__mart?utm_source=qr&igshid=MzNlNGNkZWQ4Mg%3D%3D'
  ],

];
