// class FeedbackForm {
//   String name;
//   String email;
//   String mobileNo;
//   String feedback;

//   FeedbackForm(this.name, this.email, this.mobileNo, this.feedback);

//   factory FeedbackForm.fromJson(dynamic json) {
//     return FeedbackForm("${json['name']}", "${json['email']}",
//         "${json['mobileNo']}", "${json['feedback']}");
//   }

//   // Method to make GET parameters.
//   Map toJson() => {
//         'name': name,
//         'email': email,
//         'mobileNo': mobileNo,
//         'feedback': feedback
//       };
// }
class FeedbackForm {
  String name;
  String email;
  String mobileNo;
  String feedback;
  int qmNumber; // Add qmNumber property

  FeedbackForm({
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.feedback,
    required this.qmNumber,
  });

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
      name: "${json['name']}",
      email: "${json['email']}",
      mobileNo: "${json['mobileNo']}",
      feedback: "${json['feedback']}",
      qmNumber: json['qmNumber'], // Parse qmNumber from JSON
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'email': email,
        'mobileNo': mobileNo,
        'feedback': feedback,
        'qmNumber': qmNumber, // Include qmNumber in the JSON
      };
}
