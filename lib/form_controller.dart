import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'FeedbackForm.dart';
import 'return_team.dart';



/// FormController is a class which does work of saving FeedbackForm in Google Sheets using 
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {

  // Google App Script Web URL.
  static Uri url = Uri.parse("https://script.google.com/macros/s/AKfycbxbwoJQQVD58HSwihoVPaT8tXVMYmJZeYjWaI4VOGsRBHqVFj6B8crzucnQ8F3dS0Yq/exec");
  
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

// submitFormm(FeedbackForm feedbackForm, Function(String) callback) async {
//   try {
//     print(url);
//     final response = await http.post(url, body: feedbackForm.toJson());
//     // qmNumber: extractQmNumber(entries),
//     // namee: extractName(entries),
//     if (response.statusCode == 200) {
//       final jsonResponse = convert.jsonDecode(response.body);
//       final status = jsonResponse['status'];

//       // Check the response status and handle it accordingly
//       if (status == FormController.STATUS_SUCCESS) {
//         // Handle success
//         print("Form submitted successfully.");
//       } else {
//         // Handle any other status if needed
//         print("Form submission failed with status: $status");
//       }
//     } else {
//       // Handle HTTP request error
//       print("HTTP request failed with status code: ${response.statusCode}");
//     }
//   } catch (e) {
//     // Handle any exceptions that may occur during the process
//     print("Error: $e");
//   }
// }

// // Implement your logic to extract name and qmNumber from entries
// String extractName(List<String> entries) {
//   // Assuming the name entry is the first item in the list
//   if (entries.isNotEmpty) {
//     return entries[0]; // You can add additional validation if needed
//   }
//   return "";
// }

// int extractQmNumber(List<String> entries) {
//   // Assuming the qm number entry is the second item in the list
//   if (entries.length > 1) {
//     final qmEntry = entries[1];
//     // Extract the qm number (assuming it's a number, you may need additional validation)
//     final qmNumber = int.tryParse(qmEntry.replaceAll('Enter "qm", Ex:', ''));
//     if (qmNumber != null) {
//       return qmNumber;
//     }
//   }
//   return 0; // Return a default value if not found or invalid
// }



  // Async function which saves feedback, parses [feedbackForm] parameters
  // and sends HTTP GET request on [URL]. On successful response, [callback] is called.
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