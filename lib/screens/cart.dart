// import 'package:college_mart/screens/homescreen.dart';
// import 'package:college_mart/screens/homescreen.dart';
import 'package:college_mart/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_icons/line_icons.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../shopping_data/controller.dart';
import '../shopping_data/form.dart';
import 'homescreen.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

// ignore: camel_case_types
class _cartState extends State<cart> {
  ////////user data collect form////////////
  ///
  final _formKey = GlobalKey<FormState>();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(nameController.text,
          emailController.text, mobileNoController.text, finalProducts());

      FormController formController = FormController((String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: const Text("CONGRATULATIONS  🎉"),
              content: const Text(
                  "Your order has been placed \nSoon our team will contact you  \nThanks \nTeam COLLEGE MART"),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    onPressed: () {
setState(() {
                                      for(int i=0;cart_list.length!=0;){
                                        deletee(i);
                                      }
                                    });
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.green,
                      ),
                      padding: const EdgeInsets.all(14),
                      child: const Text(
                        "DONE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
          //
          // _showSnackbar("Feedback Submitted");
        } else {
          _showSnackbar("SOMETHING WENT WRONG , TRY AGAIN LATER   ");
        }
      });

      _showSnackbar("Placing Order ...");

      // Submit 'feedbackForm' and save it in Google Sheet

      formController.submitForm(feedbackForm);
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
      ),
    );
    // final snackBar = SnackBar(content: Text(message));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  ////////end of user data collect forum///////////
  void deletee(int index) {
    for (int i = 0; i < dtu_homepage_semesterkit.length; i++) {
      if (cart_list[index][0] == dtu_homepage_semesterkit[i][0]) {
        dtu_homepage_semesterkit[i][3] = 0;
        break;
      }
    }
    for(int i=0;i<dtu_homepage_secondhand.length;i++){
      if (cart_list[index][0] == dtu_homepage_secondhand[i][0]) {
        dtu_homepage_secondhand[i][3] = 0;
        break;
      }
    }
        for(int i=0;i<dtu_homepage_products.length;i++){
      if (cart_list[index][0] == dtu_homepage_products[i][0]) {
        dtu_homepage_products[i][3] = 0;
        break;
      }
    }
        for(int i=0;i<dtu_homepage_stationary.length;i++){
      if (cart_list[index][0] == dtu_homepage_stationary[i][0]) {
        dtu_homepage_stationary[i][3] = 0;
        break;
      }
    }
    setState(() {
      cart_list.removeAt(index);
    });
  }

  String products = "";
  String finalProducts() {
    for (int i = 0; i < cart_list.length; i++) {
      products += '${cart_list[i][0]}*${cart_list[i][3]} ,';
    }
    return products;
  }

  int price = 0;
  // ignore: non_constant_identifier_names
  int Delievery_charges = 20;

  // ignore: non_constant_identifier_names
  String total_price() {
    setState(() {
      for (int i = 0; i < cart_list.length; i++) {
        int variable1 = cart_list[i][2];
        int variable2 = cart_list[i][3];
        price += variable2 * variable1;
      }
      ;
      if (price >= 200 || price == 0) {
        setState(() {
          Delievery_charges = 0;
        });
      }
    });
    return price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        title: const Center(
            child: Text(
          'CART',
          style: TextStyle(
              fontFamily: "Tektur-VariableFont_wdth,wght", fontSize: 25),
        )),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.68,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                endIndent: 20,
                indent: 20,
              ),
              // padding: EdgeInsets.only(top: 50),
              shrinkWrap: true,
              itemCount: cart_list.length,
              itemBuilder: (BuildContext context, int index) {
                const Padding(padding: EdgeInsets.only(bottom: 0));
                return Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: cart_item(
                    item_name: cart_list[index][0],
                    item_cost: cart_list[index][2],
                    item_quantity: cart_list[index][3],
                    item_number: index,
                    deleteitem: (context) => deletee(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SlideAction(
              borderRadius: 12,
              elevation: 0,
              outerColor: Colors.blue[500],
              text: 'Slide to Get Price',
              sliderRotate: false,
              onSubmit: () {
                setState(() {
                  showModalBottomSheet(
                      useRootNavigator: true,
                      showDragHandle: true,
                      context: context,
                      builder: (builder) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 12, right: 12, bottom: 8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Total Cost : ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text('₹${price}',
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.green))
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Delievery Charges : ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text('₹${Delievery_charges}',
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.green))
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {if(cart_list.length!=0){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.8),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            scrollable: true,
                                            title:
                                                const Center(child: Text('Details')),
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Form(
                                                key: _formKey,
                                                child: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          nameController,
                                                      validator:
                                                          (String? value) {
                                                        if (value!.isEmpty) {
                                                          return "Enter Valid Name";
                                                        }
                                                        return null;
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Name',
                                                        icon:
                                                            Icon(Icons.person),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          emailController,
                                                      validator:
                                                          (String? value) {
                                                        if (value!.isEmpty) {
                                                          return "Enter Valid Roll number";
                                                        }
                                                        return null;
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'Roll number',
                                                        icon: Icon(Icons
                                                            .format_indent_increase_outlined),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      controller:
                                                          mobileNoController,
                                                      validator:
                                                          (String? value) {
                                                        if (value!.isEmpty ||
                                                            value.length < 10) {
                                                          return "Enter Valid Phone Number";
                                                        }
                                                        return null;
                                                      },
                                                      maxLength: 10,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Phone No.',
                                                        icon: Icon(Icons.phone),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              InkWell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue[600],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: const Center(
                                                      child: Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  _submitForm();
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          );
                                        });
                                  }else{    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Cart is Empty',
      ),
    );};
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: const Center(
                                        child: Text(
                                      'Place Order',
                                      style: TextStyle(
                                        fontFamily: "Poppins-Regular",
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.red[500],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: const Center(
                                        child: Text(
                                      'Empty Cart',
                                      style: TextStyle(
                                        fontFamily: "Poppins-Regular",
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      for(int i=0;cart_list.length!=0;){
                                        deletee(i);
                                      }
                                    });
                                  },
                                ),const SizedBox(height: 10,),const Text('** To Delete a Particular Item just Slide the Item to Left side and click on the Delete Icon ',style: TextStyle(color: Colors.grey,fontFamily: "Poppins-Regular"),)
                              ],
                            ),
                          ),
                        );
                      });
                  total_price();
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class cart_item extends StatefulWidget {
  String item_name;
  int item_cost;
  int item_quantity;
  int item_number;
  Function(BuildContext)? deleteitem;
  cart_item({
    super.key,
    required this.item_name,
    required this.item_cost,
    required this.item_quantity,
    required this.item_number,
    required this.deleteitem,
  });

  @override
  State<cart_item> createState() => _cart_itemState();
}

class _cart_itemState extends State<cart_item> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        children: [
          Padding(
            // padding: const EdgeInsets.only(left: 8,right: 8,bottom: 14),
            padding: const EdgeInsets.all(0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.4,
                children: [
                  SlidableAction(
                    // onPressed: ((context) {
                    //   setState(() {
                    //     print(widget.item_number);
                    //     cart_list[widget.item_number][2] = 0;
                    //     if (cart_list[widget.item_number][2] == 0) {
                    //       print(cart_list[widget.item_number]);
                    //       print(cart_list.indexOf([widget.item_number]));

                    //       // cart_list.removeAt(widget.item_number);
                    //     }
                    //   });
                    //   print(cart_list);

                    //   print('Item deleted');
                    // }),
                    onPressed: widget.deleteitem,
                    icon: Icons.delete_rounded,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    label: 'Delete',
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                    // color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: MediaQuery.of(context).size.width / 4.8 + 28,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width / 4.8,
                        width: MediaQuery.of(context).size.width / 4.8,
                        decoration: const BoxDecoration(
                            // color: Colors.blue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        child: Image.asset(cart_list[widget.item_number][1])

                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.item_name,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontFamily: "Poppins-Regular",
                                  fontWeight: FontWeight.w700,
                                ),overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                '₹${widget.item_cost}',
                                style:
                                    const TextStyle(color: Colors.grey, fontSize: 20),
                              )
                            ],
                          ),

                          // SizedBox(
                          //   height: 3,
                          // ),
                          Row(
                            children: [
                              Text(
                                'Qty:',
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              RoundedIconButton(
                                  icon: LineIcons.minus,
                                  onPress: () {
                                    if (cart_list[widget.item_number][3] > 1) {
                                      setState(() {
                                        cart_list[widget.item_number][3]--;
                                      });
                                    }
                                  },
                                  iconSize: 30),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                cart_list[widget.item_number][3].toString(),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              RoundedIconButton(
                                  icon: LineIcons.plus,
                                  onPress: () {
                                    if (cart_list[widget.item_number][3] < 5) {
                                      setState(() {
                                        cart_list[widget.item_number][3]++;
                                      });
                                    }
                                  },
                                  iconSize: 30)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// List<int> qty = [1, 2, 3]; //stores quantity of every product

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton(
      {required this.icon, required this.onPress, required this.iconSize});

  final IconData icon;
  final onPress;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: iconSize, height: iconSize),
      elevation: 0.0,
      onPressed: onPress,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(iconSize * 0.2)),
      fillColor: Colors.blue[500],
      child: Icon(
        icon,
        color: Colors.white,
        size: iconSize * 0.8,
      ),
    );
  }
}
