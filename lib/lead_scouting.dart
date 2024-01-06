import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';
import 'package:gsheets/gsheets.dart';
import 'package:flutter/material.dart';

String effectiveness1 = "";
String effectiveness2 = "";
String effectiveness3 = "";

String relPsdEffectiveness1 = "";
String relPsdEffectiveness2 = "";
String relPsdEffectiveness3 = "";

String notes1 = "";
String notes2 = "";
String notes3 = "";

class lead_scouting extends StatefulWidget {
 const lead_scouting({super.key, required this.teamName});
  final String teamName;
  @override
  _lead_scouting createState() => _lead_scouting();
}

class _lead_scouting extends State<lead_scouting> {
  final List<String> entries = <String>[
    'Enter Robot effectivness 5 is highest (1-5)',
    'Enter relative effectivness 1 is highest (1-3)',
    'Enter Notes on robot (strengths weaknesses ect.)',
  ];


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
  
  Future<void> _submitForm(column, row) async {
    try {
      final gsheets = GSheets(_creds);
      final ss = await gsheets.spreadsheet('1C4_kygqZTOo3uue3eBxrMV9b_3UJVuDiOVZqAeGHvzE');
      final sheet = ss.worksheetByTitle('Scouting Lead Notes'); // Replace with your sheet name    

       // Writing data
      final firstRow = [effectiveness1, notes1, effectiveness2, notes2, effectiveness3, notes3, relPsdEffectiveness1, relPsdEffectiveness2 ,relPsdEffectiveness3];
      await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 2);
      // prints [index, letter, number, label]
      print(await sheet.values.row(1));
  }catch (e) {
      print('Error: $e');
    }
  }


  // void _takePicture() async {
  //   final cameras = await availableCameras();
  //   final firstCamera = cameras.first;

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => tp.take_picture(camera: firstCamera),
  //     ),
  //   );
  // }
  
   @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Scouting", textScaleFactor: 1.5,),
        elevation: 21,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(width: 0, height: 60, color: Colors.white10,),

            
  Container(
  height: height / 3.5,
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(entries[0], textScaleFactor: 1.5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: width / 3.5, // Adjust the width as needed
              child: TextField(
                onChanged: (String value) {
                  effectiveness1 = value;
                  print("$value");
                },
              ),
            ),
            Container(
              width: width / 3.5, // Adjust the width as needed
              child: TextField(
                onChanged: (String value) {
                  effectiveness2 = value;
                  print("$value");                },
              ),
            ),
            Container(
              width: width / 3.5, // Adjust the width as needed
              child: TextField(
                onChanged: (String value) {
                  effectiveness3 = value;
                  print("$value");
                },
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),

Container(
  height: height / 3.5,
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(entries[1], textScaleFactor: 1.5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: width / 3.5, // Adjust the width as needed
              child: TextField(
                onChanged: (String value) {
                  relPsdEffectiveness1 = value;
                  print("$value");
                },
              ),
            ),
            Container(
              width: width / 3.5, // Adjust the width as needed
              child: TextField(
                onChanged: (String value) {
                  relPsdEffectiveness2 = value;
                  print("$value");                },
              ),
            ),
            Container(
              width: width / 3.5, // Adjust the width as needed
              child: TextField(
                onChanged: (String value) {
                  relPsdEffectiveness3 = value;
                  print("$value");
                },
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),

 Container(
  height: height / 3.5,
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(entries[2], textScaleFactor: 1.5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: width / 3.5, // Adjust the width as needed
              child: TextField(
                onChanged: (String value) {
                  notes1 = value;
                  print("$value");
                },
                maxLines: null, // Setting maxLines to null allows multiple lines

              ),
            ),
            Container(
              width: width / 3.5, // Adjust the width as needed
              child: TextField(
                onChanged: (String value) {
                  notes2 = value;
                  print("$value");                
                },
                maxLines: null, // Setting maxLines to null allows multiple lines
              ),
            ),
            Container(
              width: width / 3.5, // Adjust the width as needed
              child: TextField(
                onChanged: (String value) {
                  notes3 = value;
                  print("$value");
                },
                maxLines: null, // Setting maxLines to null allows multiple lines
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),

            ElevatedButton(
              onPressed: () {
                _submitForm(0,0);

              },
              child: const Icon(Icons.send),
            )
          ],
        )
      ),
    );
  }
}