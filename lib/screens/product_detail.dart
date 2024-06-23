// import 'package:college_mart/screens/cart.dart';
import 'package:college_mart/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:nopsuite_carousel_slider/effects/worm_effect.dart';
import 'package:nopsuite_carousel_slider/nopsuite_carousel_slider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class product_discription extends StatefulWidget {
  String product_name;
  String Product_pice;
  String product_included;
  product_discription(
      {super.key,
      required this.product_name,
      required this.Product_pice,
      required this.product_included});

  @override
  State<product_discription> createState() => _product_discriptionState();
}

class _product_discriptionState extends State<product_discription> {
  int kit_selected() {
    int index = 0;
    for (int i = 0; i < dtu_homepage_semesterkit.length; i++) {
      if (widget.product_name == dtu_homepage_semesterkit[index][0]) {
        break;
      } else {
        index++;
      }
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        images[kit_selected()].length,
        (index) => Container(
              // height: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                // borderRadius: BorderRadius.circular(16),
                // color: colors[index],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: SizedBox(
                height: 250,
                child: Image.asset(images[kit_selected()][index]),
              ),
            ));
    final controller = PageController(viewportFraction: 0.8, keepPage: true);
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
        title: Center(
            child: Text(
          widget.product_name,
          style: TextStyle(
              fontFamily: "Tektur-VariableFont_wdth,wght", fontSize: 25),
        )),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              NopSuiteCarouselSlider(
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
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: [
                    Text(
                      widget.product_name,
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      '₹${widget.Product_pice.toString()}',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Items Included in the Kit: ',
                style: TextStyle(fontFamily: "Poppins-Regular", fontSize: 22),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                product_included[kit_selected()],
                style: TextStyle(fontFamily: "Poppins-Regular"),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 50,
                child: ElevatedButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_shopping_cart_rounded,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'ADD TO CART',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            fontFamily: 'Poppins-Regular'),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.success(
                        message:
                            '${dtu_homepage_semesterkit[product_selected][0]} added to cart',
                        // icon: Icon(Icons.info_outline),
                        backgroundColor: Colors.blue,
                      ),
                    );
                    if (dtu_homepage_semesterkit[product_selected][3] == 0) {
                      dtu_homepage_semesterkit[product_selected][3]++;
                      print(cart_list.length);

                      cart_list.add(dtu_homepage_semesterkit[product_selected]);
                      print(cart_list);
                    }
                    ;
                    print('Pressed');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static List images = [
    [
      'assets/images/starter_kit.png',
    ],
    ['assets/images/semester_kit.png']
  ];
  static List<String> product_included = [
    '~ 3 X Practical File\n~ 2 X Auxillary Notebook\n~ 2 X Spiral Register\n~ 1 X Glue Stick\n~ 3 X Blue Pen \n~ 1 X Black Pen \n~ 1 X Pencil \n~ 1 X Sharpner \n~ 1 X Eraser \n~ 1 X Scale \n',
    '~ 2 X Practical File\n~ 2 X Auxillary Notebook\n~ 1 X Spiral Register\n~ 2 X Blue Pen \n'
  ];
}
