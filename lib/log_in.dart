import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';
import 'package:gsheets/gsheets.dart';
import 'return_team.dart' as rt;
import 'subjective_form.dart' as subf;

class log_in extends StatefulWidget {
  const log_in({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _log_in createState() => _log_in();
}

class _log_in extends State<log_in> {
  final List<String> entries = <String>[
    'Enter Letter',
    'Enter "qm", Ex:5',
  ];

  @override
  void initState() {
    super.initState();
    
    fetcher();
  }



  String cellValueA = "";
  String cellValueB = "";
  String cellValueC = "";
  String cellValueD = "";
  String cellValueE = "";
  String cellValueF = "";


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

  Future<String> _fetchForm(column, row) async {
    try {
      final gsheets = GSheets(_creds);
      final ss = await gsheets.spreadsheet('1C4_kygqZTOo3uue3eBxrMV9b_3UJVuDiOVZqAeGHvzE');
      final sheet = ss.worksheetByTitle('Scouting Assignment'); // Replace with your sheet name    

      // Writing data
      final cell = await sheet?.cells.cell(column: column, row: row);
      return (cell!.value);
    } catch (e) {
      print('Error: $e');
      return "";
    }
  }



  String A = "";
  String B = "";
  String C = "";
  String D = "";
  String E = "";
  String F = "";

  List<String> AList = List.empty();
  List<String> BList = List.empty();
  List<String> CList = List.empty();
  List<String> DList = List.empty();
  List<String> EList = List.empty();
  List<String> FList = List.empty();

  void fetcher () async {
    A = (await _fetchForm(2,1));
    B = (await _fetchForm(2,2));
    C = (await _fetchForm(2,3));
    D = (await _fetchForm(2,5));
    E = (await _fetchForm(2,6));
    F = (await _fetchForm(2,7));
  }
  

  void setter( identifier ) { 
    
    if ((identifier == 'A')||(identifier == 'a')) {
      AList = A.split(', ').map((AList) => AList.trim()).toList();
    }
    if ((identifier == 'B')||(identifier == 'b')) {
      
      BList = B.split(', ').map((BList) => BList.trim()).toList();
    }
    if ((identifier == 'C')||(identifier == 'c')) {
      
      CList = C.split(', ').map((CList) => CList.trim()).toList();
    }
    if ((identifier == 'D')||(identifier == 'd')) {
      
      DList = D.split(', ').map((DList) => DList.trim()).toList();
    }
    if ((identifier == 'E')||(identifier == 'e')) {
      
      EList = E.split(', ').map((EList) => EList.trim()).toList();
    }
    if ((identifier == 'F')||(identifier == 'f')) {
      
      FList = F.split(', ').map((FList) => FList.trim()).toList();
    }
   
    // A=['frc294', 'frc294', 'frc294', 'frc4999', 'frc2710', 'frc4501', 'frc4201', 'frc8898', 'frc3473', 'frc9172', 'frc4501', 'frc7611', 'frc4470', 'frc687', 'frc846', 'frc9172', 'frc4123', 'frc8600', 'frc6833', 'frc3408', 'frc597', 'frc687', 'frc1452', 'frc7185', 'frc2710', 'frc6833', 'frc1759', 'frc5199', 'frc1159', 'frc687', 'frc7611', 'frc4123', 'frc8020', 'frc1148', 'frc5669', 'frc6904', 'frc5124', 'frc5857', 'frc7185', 'frc1197', 'frc980', 'frc3952', 'frc9172', 'frc8600', 'frc5500', 'frc2584', 'frc8020', 'frc606', 'frc7185', 'frc7230', 'frc1661', 'frc3408', 'frc597', 'frc7611', 'frc980', 'frc846', 'frc3473', 'frc4470', 'frc6658', 'frc1515', 'frc606', 'frc8898', 'frc4201', 'frc5089', 'frc5669'];
    // B=['frc4123', 'frc4123', ' frc4123', ' frc3952', ' frc4470', ' frc5669', ' frc1197', ' frc1148', ' frc980', ' frc6000', ' frc5089', ' frc3863', ' frc2584', ' frc1452', ' frc702', ' frc1197', ' frc1148', ' frc1759', ' frc846', ' frc5857', ' frc2584', ' frc6904', ' frc3952', ' frc5500', ' frc8600', ' frc1148', ' frc5669', ' frc1661', ' frc6658', ' frc5089', ' frc2584', ' frc597', ' frc7185', ' frc2710', ' frc9172', ' frc4201', ' frc207', ' frc4964', ' frc3473', ' frc5500', ' frc1452', ' frc606', ' frc4964', ' frc702', ' frc5124', ' frc4501', ' frc207', ' frc687', ' frc980', ' frc1197', ' frc4123', ' frc5500', ' frc1452', ' frc5199', ' frc8898', ' frc4964', ' frc4201', ' frc294', ' frc5199', ' frc8020', ' frc6904', ' frc7230', ' frc2710', ' frc980', ' frc6000'];
    // C=[' frc1452', ' frc1452', ' frc1452', ' frc1759', ' frc687', ' frc5124', ' frc6658', ' frc1159', ' frc3408', ' frc6904', ' frc2710', ' frc606', ' frc8898', ' frc3408', ' frc5857', ' frc294', ' frc4964', ' frc1159', ' frc5124', ' frc4999', ' frc1197', ' frc1515', ' frc1159', ' frc606', ' frc7230', ' frc5500', ' frc5857', ' frc6833', ' frc702', ' frc4201', ' frc7230', ' frc4501', ' frc3863', ' frc5124', ' frc846', ' frc294', ' frc6000', ' frc597', ' frc7611', ' frc207', ' frc5199', ' frc8020', ' frc4999', ' frc5669', ' frc4123', ' frc1515', ' frc5199', ' frc2584', ' frc1759', ' frc4470', ' frc8600', ' frc6658', ' frc207', ' frc1515', ' frc3952', ' frc7230', ' frc1661', ' frc6658', ' frc4501', ' frc3408', ' frc702', ' frc7185', ' frc5500', ' frc4999', ' frc4964'];
    // D=['frc5199', 'frc5199', 'frc5199', 'frc1515', 'frc4964', 'frc5199', 'frc207', 'frc1452', 'frc7230', 'frc6833', 'frc5669', 'frc846', 'frc5199', 'frc4999', 'frc597', 'frc6658', 'frc702', 'frc5500', 'frc5669', 'frc3863', 'frc4470', 'frc1661', 'frc4964', 'frc294', 'frc8020', 'frc5089', 'frc207', 'frc6904', 'frc4999', 'frc6000', 'frc3952', 'frc1197', 'frc1452', 'frc606', 'frc8898', 'frc3408', 'frc6904', 'frc6833', 'frc3863', 'frc7230', 'frc2710', 'frc1148', 'frc294', 'frc3863', 'frc5857', 'frc6000', 'frc3473', 'frc8600', 'frc4201', 'frc6904', 'frc5089', 'frc702', 'frc6000', 'frc1159', 'frc5857', 'frc1759', 'frc2710', 'frc687', 'frc1661', 'frc5124', 'frc4501', 'frc1159', 'frc5199', 'frc2584', 'frc1197'];
    // E=[' frc6833', ' frc6833', ' frc6833', ' frc5669', ' frc6833', ' frc294', ' frc8600', ' frc2584', ' frc702', ' frc4123', ' frc7185', ' frc4201', ' frc5124', ' frc7230', ' frc2710', ' frc980', ' frc1515', ' frc3952', ' frc4201', ' frc5199', ' frc7611', ' frc702', ' frc6658', ' frc6000', ' frc4501', ' frc1159', ' frc3408', ' frc846', ' frc4470', ' frc3473', ' frc8600', ' frc1759', ' frc1515', ' frc207', ' frc687', ' frc1159', ' frc3863', ' frc6658', ' frc4501', ' frc1515', ' frc6000', ' frc1661', ' frc3408', ' frc1159', ' frc687', ' frc6658', ' frc597', ' frc7185', ' frc1148', ' frc8898', ' frc5124', ' frc6833', ' frc8020', ' frc606', ' frc7185', ' frc5089', ' frc4999', ' frc3863', ' frc8898', ' frc7611', ' frc5857', ' frc597', ' frc3952', ' frc3863', ' frc3473'];
    // F=[' frc687', ' frc687', ' frc687', ' frc4470', ' frc606', ' frc7185', ' frc5857', ' frc1661', ' frc3952', ' frc8020', ' frc597', ' frc207', ' frc5857', ' frc1661', ' frc294', ' frc8020', ' frc3473', ' frc6000', ' frc8898', ' frc5089', ' frc9172', ' frc980', ' frc3473', ' frc4123', ' frc1148', ' frc7611', ' frc9172', ' frc980', ' frc5124', ' frc8898', ' frc294', ' frc4964', ' frc5500', ' frc4999', ' frc702', ' frc2584', ' frc4964', ' frc8600', ' frc4470', ' frc4123', ' frc1759', ' frc5089', ' frc846', ' frc6833', ' frc7611', ' frc1452', ' frc3952', ' frc1197', ' frc606', ' frc2710', ' frc9172', ' frc4501', ' frc687', ' frc5669', ' frc6904', ' frc2584', ' frc1197', ' frc1148', ' frc8020', ' frc8600', ' frc1452', ' frc846', ' frc9172', ' frc4123', ' frc1148'];
  }

  void updateResults (String result){
    setState(() {
      results = result;
    });
  }

  void teamAsker (rt.return_team test){
    // print (id);
    // print (mnum);
    test.setIdentifier(id);
    test.setIndex(int.parse(mnum));
    // print( test.identifier);
    // print( test.index);
    setter(id);
    test.setLists(AList,BList,CList,DList,EList,FList);
    results = test.setStringValue();
    print (results);
    updateResults(results);
  }

  String results = "";

  String id = "";
  String mnum = "";

  
   @override
  Widget build(BuildContext context) {
    var test =  rt.return_team(AList,BList,CList,DList,EList,FList);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("log in", textScaleFactor: 1.5,),
        elevation: 21,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: height / 3.5,
              width: width/3,
              //color: Colors.red[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(entries[0],textScaleFactor: 1.5,),
                    TextField(
                      onChanged: (String value) {
                        id = value;
                        print ("$value");
                      },
                      // decoration: const InputDecoration(
                      //   enabledBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.red)
                      //   ),
                      //   disabledBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.red)
                      //   ),
                      //   focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide( )
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: height/3.5,
              width: width/3,
              //color: Colors.red[400],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(entries[1],textScaleFactor: 1.5,),
                    TextField(
                      //int.parse(value)
                      onChanged: (String value) {
                        setState(() {
                          mnum = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Container (
            //   height: height / 10,
            //   width: width,
            //   //color: Colors.red ,
            //   alignment: Alignment.center,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text("Your team is: "),
            //       Text("$results"),
            //       IconButton(
            //         onPressed: (){
            //           teamAsker(test);
            //         }, 
            //         icon: const Icon (Icons.refresh)
            //       )
            //     ],
            //   )
            // ),
            
            
            ElevatedButton(
              onPressed: () {
                teamAsker(test);
                final String out = "q$mnum $results";
                print (out);
                Navigator.push(
                  context, 
                  MaterialPageRoute
                  (
                    builder: (context) => ScoutingForm(teamName: out)
                  )
                );

              },
              child: const Icon(Icons.send),
            )
          ],
        )
      ),
    );
  }
}