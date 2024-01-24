
import 'package:flutter/material.dart';
import 'teleop_form.dart';
import 'sheets_helper.dart';
SheetsHelper sh = SheetsHelper();


class AutoForm extends StatefulWidget {
  const AutoForm({super.key, required this.teamName});
  final String teamName;
  @override
  State<AutoForm> createState() => _AutoForm();
}

class _AutoForm extends State<AutoForm> { 

  Future<void> _submitSection() async {
    try {

      final sheet = await sh.sheetSetup("JohnTest"); 

      // Writing data
      final firstRow = [autoPath];
      await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 2);
      // prints [index, letter, number, label]
      print(autoPath);



    } catch (e) {
      print('Error: $e');
    }
  }

  String autoPath = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 222, 222),
      appBar: AppBar(
        title:Column(
          children: [
            const Text ("Auto Phase",),
            Text(widget.teamName),
          ],
        ),
        actions:[
          IconButton(
            onPressed: (){
              autoPath = "";
            }, 
            icon: const Icon(Icons.delete_outlined)
          ),
        ]
      ),
      body: Center(
        child: Stack(
          children: <Widget> [
            //alliance rings
            TopLeftFieldElement(Image.asset("ring.png"), 50, width / 20 * 10, height / 2 - (height / 2)  / 3 * 3 + 50, autoPathWriter, "alliance1"),
            TopLeftFieldElement(Image.asset("ring.png"), 50, width / 20 * 10, height / 2 - (height / 2)  / 3 * 2 + 50, autoPathWriter, "alliance2"),
            TopLeftFieldElement(Image.asset("ring.png"), 50, width / 20 * 10, height / 2 - (height / 2)  / 3 * 1 + 50, autoPathWriter, "alliance3"),

            // amp
            TopLeftFieldElement(const Icon(Icons.amp_stories), 50, width / 20 * 6, height - height, autoPathWriter, "Amplifier"),
            //speaker
            TopLeftFieldElement(const Icon(Icons.speaker), 50, width / 20, height / 6, autoPathWriter, "Speaker"),

            //middle rings
            TopRightFieldElement(Image.asset("ring.png"), 50, width/20, height - height, autoPathWriter, "mid1"),
            TopRightFieldElement(Image.asset("ring.png"), 50, width/20, height - height/5 * 4, autoPathWriter, "mid2"),
            TopRightFieldElement(Image.asset("ring.png"), 50, width/20, height - height/5 * 3, autoPathWriter, "mid3"),
            TopRightFieldElement(Image.asset("ring.png"), 50, width/20, height - height/5 * 2, autoPathWriter, "mid4"),
            TopRightFieldElement(Image.asset("ring.png"), 50, width/20, height - height/5 * 1, autoPathWriter, "mid5"),
            Positioned(
              width: width,
              bottom: 0,
              child: ElevatedButton(
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
                child: const Text("Next"),
              )
            )
          ]
        ),
        
        
      ),
      //floatingActionButton: FloatingActionButton(onPressed: (){print(autoPath);}),

    );
  }

  void autoPathWriter(String fieldElement){
    autoPath += "$fieldElement ";
  }
}

class TopLeftFieldElement extends StatelessWidget{
  final Widget icon;
  final double left;
  final double top;
  final Function onClickBehavior;
  final String path;
  final double iconSize;

  const TopLeftFieldElement(this.icon, this.iconSize, this.left, this.top, this.onClickBehavior, this.path, {super.key});

  @override
  Widget build (BuildContext context){
    return Positioned(
      top: top,
      left: left,
      child: Column(
        children: [
          IconButton(
            icon: icon,
            iconSize: iconSize,
            onPressed: (){
              onClickBehavior(path);
            },
          ),
          Text(
            path,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class TopRightFieldElement extends StatelessWidget{
  final Widget icon;
  final double right;
  final double top;
  final Function onClickBehavior;
  final String path;
  final double iconSize;

  const TopRightFieldElement(this.icon, this.iconSize, this.right, this.top, this.onClickBehavior, this.path, {super.key});

  @override
  Widget build (BuildContext context){
    return Positioned(
      top: top,
      right: right,
      child: Column(
        children: [
          IconButton(
            icon: icon,
            iconSize: iconSize,
            onPressed: (){
              onClickBehavior(path);
            },
          ),
          Text(
            path,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
      
    );
  }
}
