import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'FeedbackForm.dart';


/// FormController is a class which does work of saving FeedbackForm in Google Sheets using 
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  
  // Google App Script Web URL.
  static Uri url = Uri.parse("https://script.google.com/macros/s/AKfycbxbwoJQQVD58HSwihoVPaT8tXVMYmJZeYjWaI4VOGsRBHqVFj6B8crzucnQ8F3dS0Yq/exec");
  
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
   void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      print (url);
      //https://script.google.com/macros/s/AKfycbxbwoJQQVD58HSwihoVPaT8tXVMYmJZeYjWaI4VOGsRBHqVFj6B8crzucnQ8F3dS0Yq/exec
      await http.post(url, body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var urll = response.headers['location'];
          
          await http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print ("tester test");
      print(e);
    }
  }
}