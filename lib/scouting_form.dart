import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/teleop_form.dart';
import 'sheets_helper.dart';

int topScoreCone = 0;
int midScoreCone = 0;
int lowScoreCone = 0;

int topScoreCube = 0;
int midScoreCube = 0;
int lowScoreCube = 0;

bool tryParkAuto = false;

int missedCone = 0;
int missedCube = 0;

class ScoutingForm extends StatefulWidget {
  const ScoutingForm({super.key, required this.teamName});
  final String teamName;
  @override
  State<ScoutingForm> createState() => _ScoutingForm();
}

class _ScoutingForm extends State<ScoutingForm> {    

  void _addCone (score){
    if (score == "top"){
      if (topScoreCone >= 0) setState(() => topScoreCone += 1);
      print (topScoreCone);

    }
    else if (score == "mid"){
      if (midScoreCone >= 0) setState(() => midScoreCone += 1);
      print (midScoreCone);
    }
    else if (score == "low"){
      if (lowScoreCone >= 0) setState(() => lowScoreCone += 1);
      print (lowScoreCone);
    }
    else if (score == "missed"){
      if (missedCone >= 0) setState(() => missedCone += 1);
    }
    
  }

  void _minusCone (score){
    if (score == "top"){
      if (topScoreCone > 0) setState(() => topScoreCone -= 1);
      print (topScoreCone);

    }
    else if (score == "mid"){
      if (midScoreCone > 0) setState(() => midScoreCone -= 1);
      print (midScoreCone);
    }
    else if (score == "low"){
      if (lowScoreCone > 0) setState(() => lowScoreCone -= 1);
      print (lowScoreCone);
    }
    else if (score == "missed"){
      if (missedCone > 0) setState(() => missedCone -= 1);
    }
  }

  void _addCube (score){
    if (score == "top"){
      if (topScoreCube >= 0) setState(() => topScoreCube += 1);
      print (topScoreCube);

    }
    else if (score == "mid"){
      if (midScoreCube >= 0) setState(() => midScoreCube += 1);
      print (midScoreCube);
    }
    else if (score == "low"){
      if (lowScoreCube >= 0) setState(() => lowScoreCube += 1);
      print (lowScoreCube);
    }
    else if (score == "missed"){
      if (missedCube >= 0) setState(() => missedCube += 1);
    }
    
  }

  void _minusCube (score){
    if (score == "top"){
      if (topScoreCube > 0) setState(() => topScoreCube -= 1);
      print (topScoreCube);

    }
    else if (score == "mid"){
      if (midScoreCube > 0) setState(() => midScoreCube -= 1);
      print (midScoreCube);
    }
    else if (score == "low"){
      if (lowScoreCube > 0) setState(() => lowScoreCube -= 1);
      print (lowScoreCube);
    }
    else if (score == "missed"){
      if (missedCube > 0) setState(() => missedCube -= 1);
    }
  }
  

  
  


  
  


  Future<void> _submitSection() async {
    try {

      final sheet = await SheetsHelper.sheetSetup("JohnTest"); 

      // Writing data
      final firstRow = [topScoreCone, midScoreCone, lowScoreCone, topScoreCube, midScoreCube, lowScoreCube, tryParkAuto, missedCube];
      await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 2);
      // prints [index, letter, number, label]
      print(await sheet.values.row(1));



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
          const Text ("Auto Phase",),
          Text(widget.teamName),
          ],
        ),
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
                      width: width * 0.5,
                      //color: Colors.red[100],
                      child: Text("Cone", textScaleFactor: 2.5,),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      child: const Divider(),
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.5,
                      //color: Colors.red[600],
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
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      child: const Divider(),
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.5,
                      //color: Colors.red[400],
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
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      child: const Divider(),
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.5,
                      //color: Colors.red[300],
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
                Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Container( 
                      height: height/10,
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      //color: Colors.red[100],
                      child: Text("Cube", textScaleFactor: 2.5,),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      child: const Divider(),
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.5,
                      //color: Colors.red[600],
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
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      child: const Divider(),
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.5,
                      //color: Colors.red[400],
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
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      child: const Divider(),
                    ),
                    Container(
                      height: height/3,
                      width: width * 0.5,
                      //color: Colors.red[300],
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
              //color: Colors.red[300],
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Try Parking?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: tryParkAuto,
                    //color: Colors.red[700],
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
                  //color: Colors.red[400],
                  child: const Text("Missed", textScaleFactor: 1.5,),
                ),
                Container(
                  height: height/5,
                  width: width,
                  //color: Colors.red[400],
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
                      builder: (context) => TeleopForm(teamName: widget.teamName)
                    )
                  );
                });
                _submitSection();
              },
              child: Text("Next"),
            )

            
            
          ]
      )   
    )
        // child: ListView.separated(
        //   padding: const EdgeInsets.all(8),
        //   itemCount: a.length,
        //   itemBuilder: (BuildContext context, int index) 
        //   {
        //     return Container(
        //       height: 150,
        //       color: Colors.deepPurple.shade50,
        //       child: Center(
        //         child: a[index]
        //         // child: Column(
        //         //   children: <Widget>[
        //         //     Text(entries[index]),
        //         //     TextField(
        //         //       controller: TextEditingController(),
        //         //       onSubmitted: (String value) async {
        //                 // await showDialog<void>(
        //                 //   context: context,
        //                 //   builder: (BuildContext context) {
        //                 //     return AlertDialog(
        //                 //       title: const Text('Thanks!'),
        //                 //       content: Text(
        //                 //           'You typed "$value", which has length ${value.characters.length}.'),
        //                 //       actions: <Widget>[
        //                 //         TextButton(
        //                 //           onPressed: () {
        //                 //             Navigator.pop(context);
        //                 //           },
        //                 //           child: const Text('OK'),
        //                 //         ),
        //                 //       ],
        //                 //     );
        //                 //   },
        //                 // );

        //         //       },
        //         //     ),
        //         //     ElevatedButton(
        //         //       onPressed: _submitForm,
        //         //       child: Text("test"))
        //         //   ],
        //         // )
        //       )
        //     );
        //   },
        //   separatorBuilder: (BuildContext context, int index) => const Divider(),
          
        // )


    );

    // return Scaffold(
    //   key: _scaffoldKey,  
      
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           Form(
    //             key: _formKey,
    //             child:
    //               Padding(padding: EdgeInsets.all(16),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   TextFormField(
    //                     controller: TextEditingController(),
    //                     validator: (value) {
    //                       if (value!.isEmpty) {
    //                         return 'Enter Valid Name';
    //                       }
    //                       return null;
    //                     },
    //                     decoration: InputDecoration(
    //                       labelText: 'Name'
    //                     ),
    //                   ),
    //                   TextFormField(
    //                     controller: TextEditingController(),
    //                     validator: (value) {
    //                       if (!value!.contains("@")) {
    //                         return 'Enter Valid Email';
    //                       }
    //                       return null;
    //                     },
    //                     keyboardType: TextInputType.emailAddress,
    //                     decoration: InputDecoration(
    //                       labelText: 'Email'
    //                     ),
    //                   ),
    //                   TextFormField(
    //                     controller: TextEditingController(),
    //                     validator: (value) {
    //                       if (value!.trim().length != 10) {
    //                         return 'Enter 10 Digit Mobile Number';
    //                       }
    //                       return null;
    //                     },
    //                     keyboardType: TextInputType.number,
    //                     decoration: InputDecoration(
    //                       labelText: 'Mobile Number',
    //                     ),
    //                   ),
    //                   TextFormField(
    //                     controller: TextEditingController(),
    //                     validator: (value) {
    //                       if (value!.isEmpty) {
    //                         return 'Enter Valid Feedback';
    //                       }
    //                       return null;
    //                     },
    //                     keyboardType: TextInputType.multiline,
    //                     decoration: InputDecoration(
    //                       labelText: 'Feedback'
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ) 
    //           ),
    //           ElevatedButton(
    //             onPressed:_submitForm,
    //             child: Text('Submit Feedback'),
    //           ),
    //         ],
    //       ),
    //     ),
    // );
  }
}
