import 'package:flutter/material.dart';
import 'FeedbackForm.dart';
import 'form_controller.dart';
import 'package:gsheets/gsheets.dart';
import 'return_team.dart';

class log_in extends StatefulWidget {
  const log_in({super.key, required this.title});
  final String title;
  @override
  _log_in createState() => _log_in();
}
  
class _log_in extends State<log_in> {
  final List<String> entries = <String>[
    'Enter Name',
    'Enter "qm", Ex:5'
  ];
  

  //will use returnteam.dart to return team based on teh entries above
  


  final _creds = r'''
  {
    "type": "service_account",
    "project_id": "frc-scouting-spreadsheet",
    "private_key_id": "4a410535737fbe6d456b5863fa974c5f926a6aa0",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQClPnkQUZqc1PfQ\nWhxH0CDYUBSjXGkVskrNUsZL0JQxfDCv9F7m0VKpDypj5DTIpnt6Ew9C14qzVvPv\nGukDzSZjcpgujd1ajvVI3X7owhYzF35WfoCOOwRWo9ceMRD4Y+tJvlyU3DwBmsM2\n/QIOHr3E8oCdEVxeOjsMd6MJjfhGGuE6/iPJV2o45xyrfTYmo66p993Hx3QrzmFm\nbZJxrxuwTmbF/hv1mH+KQ5NyZd/r51PA2kFRjeGqaNBvbX55vF1N9+c6QkrSlD4q\nnzDB7AislRAktxRTIFUN2QOptj+pViowdv7U73XAyxVAEhFoqmaLEXneESW50GkJ\nsZLA4q4DAgMBAAECggEAB27AcPX4CjmKw1ySQhQAA4rSlX3Yx4jjVB9MMRPQM/ZI\nla7cZ+3JazZLQKlT9c8wkE9JfpxbA5xpJiZOjdpinCgxj9fXZDU4SOSW9UQ++GGu\n+pf/vftfQ2sPiC71JZ8PnHELZrIN9uqDAQxZ/9BCgUMr0CTRmUwYOi7VbrQWk0dG\ntmC+ahhHi6wMAFdc/vNLmAYjBPVOC4XDd4zCfnYUYQN1dzD2Q0r1BJsCfXYO/iUi\nJqz+KM9Q2yUtrAeTQMHcjo73R2YY0kiaDF1NGBpMaZmrN6Blp0koJn4xb6xZAh0C\nME4s4ehMra6ksAgkXhsZXsz37N8FucSh25XQQc2WxQKBgQDZBrNNMlda05cOzq+h\nbzQzNzrgrK2LxGRgRx/ZuPYDFXLJcMAM70PCzL2wqjPfYUgV5Gx2DhpWQ1DHnQsO\nroec/xb88YUHZMNITvM49TH0yic/WNNFRvHl9L5b/V+MlOYC+ys1L2+JLN6w9/2f\n5hPREHhF8RtLXhM3T+Xc5spODwKBgQDC6zPxrz3dslIB7maOKVz+xWwPslNL7VQt\nu4tRlxu0zJqzb6J32gHck9XyfR1smbjKlBccDztMi8DYVKSHak7KmyO9qInVPCm2\n6fwr5k/D9+az+3Dyz6sAgSCRBMdOJGa/cklTRY0D+9UkudSi/UWecmuTcDqREPNC\nASbWWacUzQKBgBp7a9OmqewmV49x/xJm3GrHeYLC72ZXr5vj8eoCXNqhemFERdsO\nMymJDDiLfErstvwc5HM/Y01VZ30EF75R47BvnCF/Yyk0zXN8VseDe/YP2Nws/ZK9\nhnT1+WiGMWuZG7wPZAVYZXbKp93WVPd2/sILDXITaq42q4ebU0QyUUtXAoGARw2a\nJ9XrxW8FefK/q77kSXMKC0bEGn9vGiStipZ84RFcq2BcZzgvSYsSiIyXN0lqFV6a\ndf4Pbb3cFH/2Ye6cvjqDctWHORXvVuBArngMR7GMhbt41upguZRYnMSTKqcWVV+B\n3zsRRox8jCC5pJiS0kl/cYWNs+fr5PmqgKS5xVkCgYBiohNqvMFa43DoUWzPiXqA\nOfNn6zcreAsCmZ2+EJqirQAsCALcS2HCs49VJCRMrkU3nXh3ywSzWSRzrTTJ6xdy\n3JolxDBHXyVXdZ9d9gXbXwjpVNSukAQjGeb9mMj/82c1jHbWGk9WQ/AD47noSoBm\n0tuqMeC4m7x8uKNjai2a0w==\n-----END PRIVATE KEY-----\n",
    "client_email": "frc1148scouting@frc-scouting-spreadsheet.iam.gserviceaccount.com",
    "client_id": "118011931117933330334",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/frc1148scouting%40frc-scouting-spreadsheet.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
  ''';
  

  Future<void> _submitForm() async {
  try {
    final gsheets = GSheets(_creds);
    final ss = await gsheets.spreadsheet('1C4_kygqZTOo3uue3eBxrMV9b_3UJVuDiOVZqAeGHvzE');
    final sheet = ss.worksheetByTitle('Scouting Assignment'); // Replace with your sheet name    

    // Writing data
    //await sheet?.values.insertValue('qm1', column: 1, row: 2);
  } catch (e) {
    print('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) 
          {
            return Container(
              height: 150,
              color: Colors.deepPurple.shade50,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(entries[index]),
                    TextField(
                      controller: TextEditingController(),
                      onSubmitted: (String value) async {
                        await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Thanks!'),
                              content: Text(
                                  'You typed "$value", which has length ${value.characters.length}.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text("test"))
                  ],
                )
              )
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          
        )
      ),


    );
  }
}
// import 'package:flutter/material.dart';
// import 'FeedbackForm.dart';
// import 'form_controller.dart';
// import 'package:gsheets/gsheets.dart';
// import 'return_team.dart';

// class log_in extends StatefulWidget {
//   const log_in({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _log_in createState() => _log_in();
// }

// class _log_in extends State<log_in> {
//   final List<String> entries = <String>[
//     'Enter Name',
//     'Enter "qm", Ex:5',
//   ];

//   final _creds = r'''
//   {
//     "type": "service_account",
//     "project_id": "frc-scouting-spreadsheet",
//     "private_key_id": "4a410535737fbe6d456b5863fa974c5f926a6aa0",
//     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQClPnkQUZqc1PfQ\nWhxH0CDYUBSjXGkVskrNUsZL0JQxfDCv9F7m0VKpDypj5DTIpnt6Ew9C14qzVvPv\nGukDzSZjcpgujd1ajvVI3X7owhYzF35WfoCOOwRWo9ceMRD4Y+tJvlyU3DwBmsM2\n/QIOHr3E8oCdEVxeOjsMd6MJjfhGGuE6/iPJV2o45xyrfTYmo66p993Hx3QrzmFm\nbZJxrxuwTmbF/hv1mH+KQ5NyZd/r51PA2kFRjeGqaNBvbX55vF1N9+c6QkrSlD4q\nnzDB7AislRAktxRTIFUN2QOptj+pViowdv7U73XAyxVAEhFoqmaLEXneESW50GkJ\nsZLA4q4DAgMBAAECggEAB27AcPX4CjmKw1ySQhQAA4rSlX3Yx4jjVB9MMRPQM/ZI\nla7cZ+3JazZLQKlT9c8wkE9JfpxbA5xpJiZOjdpinCgxj9fXZDU4SOSW9UQ++GGu\n+pf/vftfQ2sPiC71JZ8PnHELZrIN9uqDAQxZ/9BCgUMr0CTRmUwYOi7VbrQWk0dG\ntmC+ahhHi6wMAFdc/vNLmAYjBPVOC4XDd4zCfnYUYQN1dzD2Q0r1BJsCfXYO/iUi\nJqz+KM9Q2yUtrAeTQMHcjo73R2YY0kiaDF1NGBpMaZmrN6Blp0koJn4xb6xZAh0C\nME4s4ehMra6ksAgkXhsZXsz37N8FucSh25XQQc2WxQKBgQDZBrNNMlda05cOzq+h\nbzQzNzrgrK2LxGRgRx/ZuPYDFXLJcMAM70PCzL2wqjPfYUgV5Gx2DhpWQ1DHnQsO\nroec/xb88YUHZMNITvM49TH0yic/WNNFRvHl9L5b/V+MlOYC+ys1L2+JLN6w9/2f\n5hPREHhF8RtLXhM3T+Xc5spODwKBgQDC6zPxrz3dslIB7maOKVz+xWwPslNL7VQt\nu4tRlxu0zJqzb6J32gHck9XyfR1smbjKlBccDztMi8DYVKSHak7KmyO9qInVPCm2\n6fwr5k/D9+az+3Dyz6sAgSCRBMdOJGa/cklTRY0D+9UkudSi/UWecmuTcDqREPNC\nASbWWacUzQKBgBp7a9OmqewmV49x/xJm3GrHeYLC72ZXr5vj8eoCXNqhemFERdsO\nMymJDDiLfErstvwc5HM/Y01VZ30EF75R47BvnCF/Yyk0zXN8VseDe/YP2Nws/ZK9\nhnT1+WiGMWuZG7wPZAVYZXbKp93WVPd2/sILDXITaq42q4ebU0QyUUtXAoGARw2a\nJ9XrxW8FefK/q77kSXMKC0bEGn9vGiStipZ84RFcq2BcZzgvSYsSiIyXN0lqFV6a\ndf4Pbb3cFH/2Ye6cvjqDctWHORXvVuBArngMR7GMhbt41upguZRYnMSTKqcWVV+B\n3zsRRox8jCC5pJiS0kl/cYWNs+fr5PmqgKS5xVkCgYBiohNqvMFa43DoUWzPiXqA\nOfNn6zcreAsCmZ2+EJqirQAsCALcS2HCs49VJCRMrkU3nXh3ywSzWSRzrTTJ6xdy\n3JolxDBHXyVXdZ9d9gXbXwjpVNSukAQjGeb9mMj/82c1jHbWGk9WQ/AD47noSoBm\n0tuqMeC4m7x8uKNjai2a0w==\n-----END PRIVATE KEY-----\n",
//     "client_email": "frc1148scouting@frc-scouting-spreadsheet.iam.gserviceaccount.com",
//     "client_id": "118011931117933330334",
//     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//     "token_uri": "https://oauth2.googleapis.com/token",
//     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/frc1148scouting%40frc-scouting-spreadsheet.iam.gserviceaccount.com",
//     "universe_domain": "googleapis.com"
//   }
//   ''';

//   Future<void> _submitFormm() async {
//     try {
//       final gsheets = GSheets(_creds);
//       final ss = await gsheets.spreadsheet('1C4_kygqZTOo3uue3eBxrMV9b_3UJVuDiOVZqAeGHvzE');
//       final sheet = ss.worksheetByTitle('Scouting Assignment'); // Replace with your sheet name

//       for (String entry in entries) {
//         if (entry.startsWith('Enter Name')) {
//           // Extract the name and qm number here
//           final name = entry; // Replace with your method of extracting the name
//           final qmNumber = 0; // Replace with your method of extracting the qm number

//           // Call setStringValue with the extracted values
//           return_team().setStringValue(name, qmNumber);
//         }
//       }

//       // Writing data
//       // await sheet?.values.insertValue('New Data', column: 1, row: 2);
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ListView.separated(
//           padding: const EdgeInsets.all(8),
//           itemCount: entries.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               height: 150,
//               color: Colors.deepPurple.shade50,
//               child: Center(
//                 child: Column(
//                   children: <Widget>[
//                     Text(entries[index]),
//                     TextField(
//                       controller: TextEditingController(),
//                       onSubmitted: (String value) async {
//                         await showDialog<void>(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Thanks!'),
//                               content: Text(
//                                 'You typed "$value", which has length ${value.characters.length}.',
//                               ),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: const Text('OK'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                     ElevatedButton(
//                       onPressed: _submitFormm,
//                       child: Text("Enter"),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) => const Divider(),
//         ),
//       ),
//     );
//   }
// }
