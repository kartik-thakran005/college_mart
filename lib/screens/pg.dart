import 'package:cached_network_image/cached_network_image.dart';
import 'package:college_mart/functions/pg_model.dart';
import 'package:college_mart/screens/pg_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class pg extends StatelessWidget {
  const pg({super.key});

  @override
  Widget build(BuildContext context) {
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
      feedbackModel.rating = element['Rating'].toString();
      feedbackModel.distance = element['Distance'].toString();
      feedbackModel.name = element['Name'];
      // feedbackModel.price = element['Price'];
      // feedbackModel.price = element['Price'];
      // feedbackModel.price = element['Price'];
      // feedbackModel.price = element['Price'];
      feedbacks.add(feedbackModel);
    });

    print('${feedbacks[0]}');
    print(feedbacks.length);
  }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        title: Center(
            child: Text(
          'PG FINDER',
          style: TextStyle(
              fontFamily: "Tektur-VariableFont_wdth,wght", fontSize: 25),
        )),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: getFeedbackFromSheet(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || feedbacks.length==0) {
              return  Center(child: CircularProgressIndicator()); 
            } else {
              if (snapshot.hasError) {
                return new Text("fetch error");
              } else {
          return ListView.builder(
                shrinkWrap: true,
                itemCount: feedbacks.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(onTap: (){pg_selected=index;
                   print('tapped');
                    Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const pg_info()),
            );},child: PG_WIDGET(pg_image: feedbacks[index].image!,pg_name: feedbacks[index].name!, pg_distance: 'in ${feedbacks[index].distance}', pg_price: int.parse(feedbacks[index].price!), pg_rating: double.parse(feedbacks[index].rating!)));
                },
              );
        }}}
      ),
        
      );
  }
}

class PG_WIDGET extends StatelessWidget {
  final String pg_name;
  final String pg_distance;
  final int pg_price;
  final double pg_rating;
  final String pg_image;
  const PG_WIDGET(
      {super.key,
      required this.pg_name,
      required this.pg_distance,
      required this.pg_price,
      required this.pg_rating,
      required this.pg_image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.amber,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: CachedNetworkImage(imageUrl:pg_image,fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Container(
          // height: MediaQuery.of(context).size.height / 7,
          width: MediaQuery.of(context).size.width - 70,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.25),
              
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 2, left: 12, right: 12),
                child: Row(
                  children: [
                    Text(
                      pg_name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // color: Colors.black
                          ),
                    ),
                    Text(
                      '₹$pg_price',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: Row(
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      itemSize: 25,
                      initialRating: pg_rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Text(
                      "$pg_distance m",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),SizedBox(height: 12,)
            ],
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}

final pg_list = [
  ['Name', 999, 2.5, 50, 'Main Image'],
  ['Name2', 9999, 4.5, 20, 'Main Image2']
];
final pg_image =[['images of pg 1'],['Images of pg 2']];
int pg_selected=0;

///coming soon
///
// import 'package:flutter/material.dart';

// class pg extends StatelessWidget {
//   const pg({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Color(0xFFFF914D),
//       appBar: AppBar(
//         title: Text('PG FINDER'),
//         centerTitle: true,
//       ),
//       body:Container(width: MediaQuery.of(context).size.width,child: Image.asset('assets/images/coming_soon.png',fit: BoxFit.fill,)),
//     );
//   }
// }
