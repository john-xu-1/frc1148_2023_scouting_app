import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/log_in.dart';
import 'package:gsheets/gsheets.dart';
import 'scouting_form.dart' as sf;
import 'teleop_form.dart' as tp;



  int speed = 0;
  int tippiness = 0;
  int roborating = 0;

  bool tip = false;
  bool defensive = false;
  bool ally = false;



class SubjectiveForm extends StatefulWidget {
  const SubjectiveForm({super.key, required this.teamName});
  final String teamName;
  @override
  _SubjectiveForm createState() => _SubjectiveForm();
}

class _SubjectiveForm extends State<SubjectiveForm> {

  void _add (score){
    if (score == "speed"){
      if (speed >= 0 && speed < 5) setState(() => speed += 1);
      print (speed);

    }
    else if (score == "tip"){
      if (tippiness >= 0 && tippiness < 5) setState(() => tippiness += 1);
      print (tippiness);
    }
    else if (score == "rating"){
      if (roborating >= 0 && roborating < 5) setState(() => roborating += 1);
      print (roborating);
    }
  }

  void _minus (score){
    if (score == "speed"){
      if (speed > 0 && speed <= 5) setState(() => speed -= 1);
      print (speed);

    }
    else if (score == "tip"){
      if (tippiness > 0 && tippiness <= 5) setState(() => tippiness -= 1);
      print (tippiness);
    }
    else if (score == "rating"){
      if (roborating > 0 && roborating <= 5) setState(() => roborating -= 1);
      print (roborating);
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

  
  


  Future<void> _submitSection() async {
    try {
      final gsheets = GSheets(_creds);
      final ss = await gsheets.spreadsheet('1C4_kygqZTOo3uue3eBxrMV9b_3UJVuDiOVZqAeGHvzE');
      final sheet = ss.worksheetByTitle('JohnTest');     

      // Writing data
      
      final firstRow = [defensive, speed, tippiness, tip, roborating, ally];
      await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 19);
      // prints [index, letter, number, label]
      print(firstRow);



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
        title: Column(
          children: [
          const Text ("Subjective Rating",),
          Text(widget.teamName),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              width: width,
              height: height/5,
              //color Colors.amber[300],
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Were they defensive?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: defensive,
                    //color Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        defensive = newValue!;
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
                  //color Colors.amber[400],
                  child: const Text("How fast were they? (0-5)", textScaleFactor: 1.5,),
                ),
                Container(
                  height: height/5,
                  width: width,
                  //color Colors.amber[400],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton (
                          onPressed: () {
                            _add("speed"); 
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size(width, height/15),
                          ),
                          icon: const Icon(Icons.arrow_upward),
                      ),
                      Container(width: width/14, height: height/15, child: FittedBox(child: Text("$speed",textScaleFactor: 3.5,),),), 
                      IconButton (
                          onPressed: () {
                            _minus("speed"); 
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
            const Divider(),
            Column(
              children: [
                Container( 
                  height: height/20,
                  alignment: AlignmentDirectional.center,
                  //color Colors.amber[400],
                  child: const Text("How tippy are they? (0-5)", textScaleFactor: 1.5,),
                ),
                Container(
                  height: height/5,
                  width: width,
                  //color Colors.amber[400],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton (
                          onPressed: () {
                            _add("tip"); 
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size(width, height/15),
                          ),
                          icon: const Icon(Icons.arrow_upward),
                      ),
                      Container(width: width/14, height: height/15, child: FittedBox(child: Text("$tippiness",textScaleFactor: 3.5,),),), 
                      IconButton (
                          onPressed: () {
                            _minus("tip"); 
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
            const Divider(),
            Container(
              width: width,
              height: height/5,
              //color Colors.amber[300],
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Did they tip?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: tip,
                    //color Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        tip = newValue!;
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
                  //color Colors.amber[400],
                  child: const Text("What rating would you give this robot (0-5)", textScaleFactor: 1.2, textAlign: TextAlign.center,),
                ),
                Container(
                  height: height/5,
                  width: width,
                  //color Colors.amber[400],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton (
                          onPressed: () {
                            _add("rating"); 
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size(width, height/15),
                          ),
                          icon: const Icon(Icons.arrow_upward),
                      ),
                      Container(width: width/14, height: height/15, child: FittedBox(child: Text("$roborating",textScaleFactor: 3.5,),),), 
                      IconButton (
                          onPressed: () {
                            _minus("rating"); 
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
            const Divider(),
            Container(
              width: width,
              height: height/5,
              //color Colors.amber[300],
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Should we ally /w them?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: ally,
                    //color Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        ally = newValue!;
                      });
                    },
                  ),
                ]
              ),
            ),
            ElevatedButton(
              onPressed: (){
                _submitSection();
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute
                    (
                      builder: (context) => const log_in(title: "test",)
                    )
                  );
                });
                
                sf.topScoreCone = 0;
                sf.midScoreCone = 0;
                sf.lowScoreCone = 0;
                sf.topScoreCube = 0;
                sf.midScoreCube = 0;
                sf.lowScoreCube = 0;
                sf.tryParkAuto = false;
                sf.missedCone = 0;
                sf.missedCube = 0;

                tp.topScoreCone = 0;
                tp.midScoreCone = 0;
                tp.lowScoreCone = 0;
                tp.topScoreCube = 0;
                tp.midScoreCube = 0;
                tp.lowScoreCube = 0;
                tp.tryParkTele = false;
                tp.messUpParkTele = false;
                tp.missedCone = 0;
                tp.missedCube = 0;

                


                
              },
              child: Text("Next"),
            )
          ]
      )   
    )
    );
  }
}
