class FeedbackModel {
  String? image;
  String? name;
  String? price;
  String? rating;
  String? description;
  String? wnumber;
  String? location;
  String? imagee2;
  String? imagee3;
  String? imagee4;
  String? imagee5;
  String? distance;

  FeedbackModel(
      {this.image, this.name,this.description,this.imagee2,this.imagee3,this.imagee4,this.imagee5,this.location,this.price,this.rating,this.wnumber,this.distance
      });

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel(
      image: "${json['Image']}",
      name: "${json['Name']}",
      location: "${json['Location']}",
      description: "${json['Description']}",
      price: "${json['Price']}",
      imagee2: "${json['Image2']}",
      imagee3: "${json['Image3']}",
      imagee4: "${json['Image4']}",
      imagee5: "${json['Image5']}",
      rating: "${json['Rating']}",
      wnumber: "${json['Number']}",
      distance: "${json['Distance']}",
    );
  }

  Map toJson() => {
        "Name": name,
        "Image": image,
        "Location": location,
        "Description": description,
        "Price": price,
        "Image2": imagee2,
        "Image3": imagee3,
        "Image4": imagee3,
        "Image5": imagee4,
        "Rating": rating,
        "Number": wnumber,
        "Distance" : distance,
      };
}
//https://script.google.com/macros/s/AKfycbxh6KsaFaLar7kThmC8gSskV8qM65CPr3CQqr-3nqz8vdhubN8HxVrkh5YoHPLFlZJYlw/exec