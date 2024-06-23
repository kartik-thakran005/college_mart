import 'package:college_mart/freelancing_data/freelancing_form.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../freelancing_data/freelancing_controller.dart';

class freellancing extends StatelessWidget {
  const freellancing({super.key});


  @override
  Widget build(BuildContext context) {
    // double height=2.7;
    int selectedIndex=0;
    final _formKey = GlobalKey<FormState>();
      _showSnackbar(String message) {
   showTopSnackBar(
                        Overlay.of(context),
                         CustomSnackBar.success(
                          message:
                              message,
                        ),
                      );
  }
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  // TextEditingController feedbackController = TextEditingController();

  void _submitForm() {
    if(_formKey.currentState!.validate()){
      freelancing_form feedbackForm = freelancing_form(
          nameController.text,
          emailController.text,
         mobileNoController.text,
        '${freelacing_list[selectedIndex][0]}'

      );

      FormController formController = FormController((String response){
        print("Response: $response");
        if(response == FormController.STATUS_SUCCESS){

          showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  title: const Text("CONGRATULATIONS  🎉"),
                  content: const Text("Your order has been placed \nSoon our team will contact you  \nThanks \nTeam COLLEGE MART"),
                  actions: <Widget>[
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),                          color: Colors.green,),

                          padding: const EdgeInsets.all(14),
                          child: const Text("DONE",style: TextStyle(color: Colors.white),),
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

  //end of storing data

  int selectedIndexfunc(int index){
    selectedIndex=index;

    return selectedIndex;
  }


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        title: Center(
            child: Text(
          'FREELANCING',
          style: TextStyle(
              fontFamily: "Tektur-VariableFont_wdth,wght", fontSize: 25),
        )),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio:0.8,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: freelacing_list.length, itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  onTap: (){selectedIndexfunc(index);showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey.withOpacity(0.8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      scrollable: true,
                      title: Center(child: Text('Details')),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: nameController,
                        validator: (String? value){
                          if(value!.isEmpty){
                            return "Enter Valid Name";
                          }
                          return null;
                        },
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  icon: Icon(Icons.person),
                                ),
                              ),
                              TextFormField(
                                                                textInputAction: TextInputAction.next,
                                controller: emailController,
                        validator: (String? value){
                          if(value!.isEmpty){
                            return "Enter Valid Roll Number";
                          }
                          return null;
                        },
                                decoration: InputDecoration(
                                  labelText: 'Roll No',
                                  icon: Icon(Icons.format_indent_increase_outlined),
                                ),
                              ),
                              TextFormField(
                                                                textInputAction: TextInputAction.done,
                                controller: mobileNoController,
                        validator: (String? value ){
                          if(value!.isEmpty||value.length<10){
                            return "Enter Valid Phone Number";
                          }
                          return null;
                        },
                                maxLength: 10,
                                keyboardType:TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Phone No.',
              
                                  icon: Icon(Icons.phone ),
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
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),onTap: () {
                        _submitForm();
                            if(_formKey.currentState!.validate()){
                                                      Navigator.pop(context);
                            }

   
                      },),
                      SizedBox(height: 10,),
              
                      ],
                    );
                  });},
                  child: Container(
                  
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [Image.asset(freelacing_list[index][1]),
                        Text(
                          freelacing_list[index][0],
                          style: TextStyle( fontSize: 20,fontFamily: "Poppins-Regular"),
                        ),
                      ],
                    ),
                  ),
                );
              }),
      ),
    );
  }
}

List freelacing_list=[['WRITING','assets/images/1.png'],['DRAWING','assets/images/4.png'],['DEVELOPMENT','assets/images/3.png'],['OTHER','assets/images/2.png']];