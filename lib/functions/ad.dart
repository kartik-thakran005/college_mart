// import 'package:flutter/material.dart';

// class AdModel {
//   String? Image;
//   String? Link;

//   AdModel({this.Image,this.Link});

//   factory AdModel.fromJson(dynamic json) {
//     return AdModel(Image: "${json['Image']}",
//     Link: "${json['Link']}",);
//   }

//   Map toJson() => {"Image": Image, "Link": Link};
// }
class FeedbackModel {
  String? image;
  String? link;
  // String source;
  // String feedback;
  // String sourceUrl;

  FeedbackModel(
      {this.image, this.link
      });

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel(
      image: "${json['Image']}",
      link: "${json['Link']}",
    );
  }

  Map toJson() => {
        "Link": link,
        "Image": image,
      };
}
