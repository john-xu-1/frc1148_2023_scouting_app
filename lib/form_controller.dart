import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'FeedbackForm.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using 
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  
  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycbyAaNh-1JK5pSrUnJ34Scp3889mTMuFI86DkDp42EkWiSOOycE/exec";
  
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
   void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      await http.post(Uri(path: 
        'https://script.google.com/a/macros/hwemail.com/s/AKfycbzi3BsSQJ5M4TH7nzpXOP0EwCM5b6FWQgXizwqIh_BvRrfMY8TmsGUAv4zLvO6OrZX-/exec'), 
        body: feedbackForm.toJson()).then((response) 
        async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri(path: 
        'https://script.google.com/a/macros/hwemail.com/s/AKfycbzi3BsSQJ5M4TH7nzpXOP0EwCM5b6FWQgXizwqIh_BvRrfMY8TmsGUAv4zLvO6OrZX-/exec')).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}