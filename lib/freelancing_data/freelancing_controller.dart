// this controller is for DTU 
// https://script.google.com/macros/s/AKfycbx4VwkDQ-7q91uBp5cKOQZkRhTCdIrHBXurVzdWh0b_6JiMvzxAL8wiI-m8a3pS3aEe/exec

import 'dart:convert' as convert;
// import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'freelancing_form.dart';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';


class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
   String URL = "https://script.google.com/macros/s/AKfycbx4VwkDQ-7q91uBp5cKOQZkRhTCdIrHBXurVzdWh0b_6JiMvzxAL8wiI-m8a3pS3aEe/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(freelancing_form feedbackForm) async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isDTU') == true) {
      URL =
          "https://script.google.com/macros/s/AKfycbx4VwkDQ-7q91uBp5cKOQZkRhTCdIrHBXurVzdWh0b_6JiMvzxAL8wiI-m8a3pS3aEe/exec";
    } else if (prefs.getBool('isNSUT') == true) {
      // URL =
      //     "https://script.google.com/macros/s/AKfycbwl3amiQRTmM7Ed5f9iAm7oalgxmBI52xQKsjaHLQfWXHfaRb-kfrh0KSou4EQKnstZZw/exec";
      URL =
          "https://script.google.com/macros/s/AKfycbwa3d4vxBcB35SixTNrmIGvSKuO5_V8gSOLm9vRRTpfo5cnKeB3zGMjBrXlhvDID65X/exec";
    }else if (prefs.getBool('isIGDTUW') == true) {
      // URL =
      //     "https://script.google.com/macros/s/AKfycbwl3amiQRTmM7Ed5f9iAm7oalgxmBI52xQKsjaHLQfWXHfaRb-kfrh0KSou4EQKnstZZw/exec";
      URL =
          "https://script.google.com/macros/s/AKfycbxkrvush0LD_mgjAU2luEPv__4FmkGdYhwFEN_TKnsd6XN1w5PnR9Jw5HPmuDmBO1i2WQ/exec";
    }else if (prefs.getBool('isIIITD') == true) {
      // URL =
      //     "https://script.google.com/macros/s/AKfycbwl3amiQRTmM7Ed5f9iAm7oalgxmBI52xQKsjaHLQfWXHfaRb-kfrh0KSou4EQKnstZZw/exec";
      URL =
          "https://script.google.com/macros/s/AKfycbwqxyL3tRnVDHzzCrx49O8r-rK4hlnj_HbgVCd5k7m1AkT5ii377rhoMn7xP8GlEn45/exec";
    }
    try{
      // await launch(URL+ feedbackForm.toParams());
      // await launch('www.google.com');
      await http.get(Uri.parse(URL + feedbackForm.toParams())).then(
          (response){
            callback(convert.jsonDecode((response.body))["status"]);
          });
    } catch(e){
      print(e);
    }
  }
}