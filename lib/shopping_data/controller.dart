import 'dart:convert' as convert;
// import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'form.dart';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';

class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
  //"https://script.google.com/macros/s/AKfycbxsSvX0c0XM6RHicz_9EWPmBYnLKpybuGe5jGG54EWRye0Xtgb37iXmP_pPqkiySMbE/exec"

  String URL = "";
  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isDTU') == true) {
      URL =
          "https://script.google.com/macros/s/AKfycbwl3amiQRTmM7Ed5f9iAm7oalgxmBI52xQKsjaHLQfWXHfaRb-kfrh0KSou4EQKnstZZw/exec";
    } else if (prefs.getBool('isNSUT') == true) {
      // URL =
      //     "https://script.google.com/macros/s/AKfycbwl3amiQRTmM7Ed5f9iAm7oalgxmBI52xQKsjaHLQfWXHfaRb-kfrh0KSou4EQKnstZZw/exec";
      URL =
          "https://script.google.com/macros/s/AKfycbxLMuof0p7N-a_PAHxhcHfergvYV9SHjVv4kI3kJC1jafZnZYYFMoANG_-PiW3622kf/exec";
    }else if (prefs.getBool('isIGDTUW') == true) {
      // URL =
      //     "https://script.google.com/macros/s/AKfycbwl3amiQRTmM7Ed5f9iAm7oalgxmBI52xQKsjaHLQfWXHfaRb-kfrh0KSou4EQKnstZZw/exec";
      URL =
          "https://script.google.com/macros/s/AKfycbz9Tp5oP0YV-vPKifZG1sNHT6abxdQI-GuTJxb_jW-qkNcbnpO6xfzkviOfiQoWUU-E/exec";
    }else if (prefs.getBool('isIIITD') == true) {
      // URL =
      //     "https://script.google.com/macros/s/AKfycbwl3amiQRTmM7Ed5f9iAm7oalgxmBI52xQKsjaHLQfWXHfaRb-kfrh0KSou4EQKnstZZw/exec";
      URL =
          "https://script.google.com/macros/s/AKfycbzCau4sFZZtOtTDqqtkHRWeusEZZHURAmXxk4ZyM6JYhEjhNINllqlQmPGA5jtoSlY/exec";
    }
    
    try {
      // await launch(URL+ feedbackForm.toParams());
      // await launch('www.google.com');
      print(URL);
      await http.get(Uri.parse(URL + feedbackForm.toParams())).then((response) {
        callback(convert.jsonDecode((response.body))["status"]);
      });
    } catch (e) {
      print(e);
    }
  }
}
