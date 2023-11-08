import 'package:flutter/material.dart';
import 'FeedbackForm.dart';
import 'form_controller.dart';
import 'package:gsheets/gsheets.dart';
import 'scouting_form.dart' as sf;


  int topScoreCone = 0;
  int midScoreCone = 0;
  int lowScoreCone = 0;

  int topScoreCube = 0;
  int midScoreCube = 0;
  int lowScoreCube = 0;

  bool tryParkAuto = false;

  int missedCone = 0;
  int missedCube = 0;



class TeleopForm extends StatefulWidget {
  const TeleopForm({super.key, required this.title});
  final String title;
  @override
  _TeleopForm createState() => _TeleopForm();
}

class _TeleopForm extends State<TeleopForm> {
  final List<String> entries = <String>[
    'Question #1',
    'Quesetion #2',
    'Question #3',
  ];

  

  void _addCone (score){
    if (score == "top"){
      setState(() => topScoreCone += 1);
      print (topScoreCone);

    }
    else if (score == "mid"){
      setState(() => midScoreCone += 1);
      print (midScoreCone);
    }
    else if (score == "low"){
       setState(() => lowScoreCone += 1);
      print (lowScoreCone);
    }
    else if (score == "missed"){
      setState(() => missedCone += 1);
    }
    
  }

  void _minusCone (score){
    if (score == "top"){
      setState(() => topScoreCone -= 1);
      print (topScoreCone);

    }
    else if (score == "mid"){
      setState(() => midScoreCone -= 1);
      print (midScoreCone);
    }
    else if (score == "low"){
      setState(() => lowScoreCone -= 1);
      print (lowScoreCone);
    }
    else if (score == "missed"){
      setState(() => missedCone -= 1);
    }
  }

  void _addCube (score){
    if (score == "top"){
      setState(() => topScoreCube += 1);
      print (topScoreCube);

    }
    else if (score == "mid"){
      setState(() => midScoreCube += 1);
      print (midScoreCube);
    }
    else if (score == "low"){
       setState(() => lowScoreCube += 1);
      print (lowScoreCube);
    }
    else if (score == "missed"){
      setState(() => missedCube += 1);
    }
    
  }

  void _minusCube (score){
    if (score == "top"){
      setState(() => topScoreCube -= 1);
      print (topScoreCube);

    }
    else if (score == "mid"){
      setState(() => midScoreCube -= 1);
      print (midScoreCube);
    }
    else if (score == "low"){
      setState(() => lowScoreCube -= 1);
      print (lowScoreCube);
    }
    else if (score == "missed"){
      setState(() => missedCube -= 1);
    }
  }
  

  
  
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
      final sheet = ss.worksheetByTitle('AppTesting'); // Replace with your sheet name    

      // Writing data
      await sheet?.values.insertValue('New Data', column: 1, row: 2);
    } catch (e) {
      print('Error: $e');
    }
  }



  
  

  
  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Driving"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Container( 
                      height: height/10,
                      alignment: AlignmentDirectional.center,
                      width: width * 0.49,
                      color: Colors.amber[100],
                      child: Text("Cone", textScaleFactor: 2.5,),
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.49,
                      color: Colors.amber[600],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _addCone("top"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                              ),
                            icon: const Icon(Icons.arrow_upward)
                          ) ,
                          SizedBox(width: width/14, height: height/75),
                          Container(width: width/14, height: height/10, child: FittedBox(child: Text("$topScoreCone",textScaleFactor: 3.5,),),), 
                          SizedBox(width: width/14, height: height/75),
                          IconButton(
                            onPressed: () {
                              _minusCone("top"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                              ),
                            icon: const Icon(Icons.arrow_downward),
                          )
                        ]
                      )
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.49,
                      color: Colors.amber[400],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton (
                              onPressed: () {
                                _addCone("mid"); 
                              },
                              style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                              ),
                              icon: const Icon(Icons.arrow_upward),
                          ),
                          Container(width: width/14, height: height/10, child: FittedBox(child: Text("$midScoreCone",textScaleFactor: 3.5,),),), 
                          IconButton (
                              onPressed: () {
                                _minusCone("mid"); 
                              },
                              style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                              ),
                              icon: const Icon(Icons.arrow_downward),
                          )
                        ]
                      )
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.49,
                      color: Colors.amber[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _addCone("low"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                              ),
                            icon: const Icon(Icons.arrow_upward)
                          ) ,
                          Container(width: width/14, height: height/10, child: FittedBox(child: Text("$lowScoreCone",textScaleFactor: 3.5,),),), 
                          ButtonTheme(
                            minWidth: width/14,
                            height: height/5,
                            child: IconButton(
                            onPressed: () {
                              _minusCone("low"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                            ),
                            icon: const Icon(Icons.arrow_downward),
                          )
                          ),
                          
                        ]
                      )
                    ),
                  ]
                ),
                VerticalDivider(width: width*0.02, color: Colors.amberAccent,),
                Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Container( 
                      height: height/10,
                      alignment: AlignmentDirectional.center,
                      width: width * 0.49,
                      color: Colors.amber[100],
                      child: Text("Cube", textScaleFactor: 2.5,),
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.49,
                      color: Colors.amber[600],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _addCube("top"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                              ),
                            icon: const Icon(Icons.arrow_upward)
                          ) ,
                          SizedBox(width: width/14, height: height/75),
                          Container(width: width/14, height: height/10, child: FittedBox(child: Text("$topScoreCube",textScaleFactor: 3.5,),),), 
                          SizedBox(width: width/14, height: height/75),
                          IconButton(
                            onPressed: () {
                              _minusCube("top"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                              ),
                            icon: const Icon(Icons.arrow_downward),
                          )
                        ]
                      )
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.49,
                      color: Colors.amber[400],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton (
                              onPressed: () {
                                _addCube("mid"); 
                              },
                              style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                              ),
                              icon: const Icon(Icons.arrow_upward),
                          ),
                          Container(width: width/14, height: height/10, child: FittedBox(child: Text("$midScoreCube",textScaleFactor: 3.5,),),), 
                          IconButton (
                              onPressed: () {
                                _minusCube("mid"); 
                              },
                              style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                              ),
                              icon: const Icon(Icons.arrow_downward),
                          )
                        ]
                      )
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.49,
                      color: Colors.amber[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _addCube("low"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                              ),
                            icon: const Icon(Icons.arrow_upward)
                          ) ,
                          Container(width: width/14, height: height/10, child: FittedBox(child: Text("$lowScoreCube",textScaleFactor: 3.5,),),), 
                          ButtonTheme(
                            minWidth: width/14,
                            height: height/5,
                            child: IconButton(
                            onPressed: () {
                              _minusCube("low"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/2, height/10),
                            ),
                            icon: const Icon(Icons.arrow_downward),
                          )
                          ),
                        ]
                      )
                    ),
                  ]
                ),
              ],
            ),
            const Divider(),
            Container(
              width: width,
              height: height/5,
              color: Colors.amber[300],
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Try Parking?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: tryParkAuto,
                    activeColor: Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        tryParkAuto = newValue!;
                      });
                    },
                  ),
                ]
              ),
            ),
            const Divider(),
            Column(
              children: [
                Container( 
                  height: height/20,
                  alignment: AlignmentDirectional.center,
                  color: Colors.amber[400],
                  child: const Text("Missed", textScaleFactor: 1.5,),
                ),
                Container(
                  height: height/5,
                  width: width,
                  color: Colors.amber[400],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton (
                          onPressed: () {
                            _addCube("missed"); 
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size(width, height/15),
                          ),
                          icon: const Icon(Icons.arrow_upward),
                      ),
                      Container(width: width/14, height: height/15, child: FittedBox(child: Text("$missedCube",textScaleFactor: 3.5,),),), 
                      IconButton (
                          onPressed: () {
                            _minusCube("missed"); 
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size(width, height/15),
                          ),
                          icon: const Icon(Icons.arrow_downward),
                      )
                    ]
                  )
                ),

              ],
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute
                    (
                      builder: (context) => TeleopForm(title: "test")
                    )
                  );
                });
              },
              child: Text("Next"),
            )
            
          ]
      )   
    )
    );
  }
}
