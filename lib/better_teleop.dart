import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/subjective_form.dart';
import 'sheets_helper.dart';
import 'color_scheme.dart';

// PrimitiveWrapper playerPointsToAdd = PrimitiveWrapper(0);
// PrimitiveWrapper numberOfPasses = PrimitiveWrapper(0);

PrimitiveWrapper speakerCount = PrimitiveWrapper(0);
PrimitiveWrapper ampCount = PrimitiveWrapper(0);
PrimitiveWrapper passCount = PrimitiveWrapper(0);

PrimitiveWrapper missedS = PrimitiveWrapper(0);
PrimitiveWrapper missedA = PrimitiveWrapper(0);
PrimitiveWrapper missedP = PrimitiveWrapper(0);

// bool tryParkTele = false;
// bool messUpParkTele = false;
// int cycleCounter = 0;

class BetterTeleop extends StatefulWidget {
  const BetterTeleop({super.key, required this.teamName});
  final String teamName;
  @override
  State<BetterTeleop> createState() => _BetterTeleop();
}

class _BetterTeleop extends State<BetterTeleop> {
  Future<void> _submitSection() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("App results");

      // Writing data
      final firstRow = [
        speakerCount.value,
        ampCount.value,
        passCount.value,
        missedS.value,
        missedA.value,
        missedP.value,
      ];
      if (widget.teamName.contains("frc")) {
        await sheet!.values
            .insertRowByKey(widget.teamName, firstRow, fromColumn: 3);
      } else {
        await sheet!.values.insertRowByKey(id, firstRow, fromColumn: 3);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void update(PrimitiveWrapper variable, int inc) {
    setState(() {
      if ((variable.value + inc) >= 0) {
        variable.value += inc;
      }
      // if (variable == speakerPoints && inc == 5) {
      //   speakerAmpedCounter.value += 1;
      // } else if (variable == speakerPoints && inc == -5) {
      //   if (speakerAmpedCounter.value - 1 >= 0) {
      //     speakerAmpedCounter.value -= 1;
      //   }
      // }
      // if (variable == speakerPoints && inc == 2) {
      //   speakerNotAmpedCounter.value += 1;
      // } else if (variable == speakerPoints && inc == -2) {
      //   if (speakerNotAmpedCounter.value - 1 >= 0) {
      //     speakerNotAmpedCounter.value -= 1;
      //   }
      // }
    });
  }

  String id = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              const Text(
                "Teleop Phase",
              ),
              Text(widget.teamName),
            ],
          ),
        ),
        body: Center(
            child: ListView(children: <Widget>[
          Row(
            children: [
              const Text(
                "Team change in case error: ",
              ),
              SizedBox(
                width: width / 3,
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      id = value;
                    });
                  },
                  //cursorColor: colors.myOnSurface,
                ),
              ),
            ],
          ),
          const Divider(color: colors.mySecondaryColor),

          CategoryTracker(update, "Speaker", speakerCount, missedS, true),

          const Divider(color: colors.mySecondaryColor),

          CategoryTracker(update, "Amp", ampCount, missedA, true),

          const Divider(color: colors.mySecondaryColor),

          CategoryTracker(update, "Passes", passCount, missedP, false),

          const Divider(color: colors.mySecondaryColor),

          ElevatedButton(
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SubjectiveForm(teamName: widget.teamName)));
              });
              _submitSection();
            },
            child: const Text(
              "Next",
              style: TextStyle(color: colors.myOnPrimary),
            ),
          )
        ])));
  }
}

class ScoreDisplay extends StatelessWidget {
  final int points;
  final String lable;
  const ScoreDisplay(this.points, this.lable, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          lable,
          textScaleFactor: 1,
        ),
        SizedBox(width: width / 20),
        FittedBox(
            child: Text("$points",
                textScaleFactor: 3.5,
                style: const TextStyle(color: colors.myOnPrimary))),
      ],
    );
  }
}

class CategoryTracker extends StatelessWidget {
  final Function update;
  final String name;
  final PrimitiveWrapper counter;
  final PrimitiveWrapper misses;
  final bool isAdding;
  const CategoryTracker(this.update, this.name, this.counter, this.misses, this.isAdding, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          Row(children: [
            Text(name, textScaleFactor: 4),
            const SizedBox(width: 60),
            Container(
                alignment: Alignment.center,
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text("${counter.value + misses.value}",
                    textScaleFactor: 3)),
          ]),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
                alignment: Alignment.center,
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: IconButton(
                    onPressed: () {
                      update(counter, isAdding ? 1 : -1);
                    },
                    icon: Icon(isAdding ? Icons.add : Icons.remove),
                    iconSize: 60)),
            const SizedBox(width: 40),
            Container(
                alignment: Alignment.center,
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: IconButton(
                    onPressed: () {
                      update(misses, isAdding ? 1 : -1);
                    },
                    icon: Icon(isAdding ? Icons.add : Icons.remove),
                    iconSize: 60)),
          ]),
        ]),
      ],
    );
  }
}

class CounterButton extends StatelessWidget {
  final Function func;
  final PrimitiveWrapper prim;
  final int inc;
  final Widget child;
  const CounterButton(this.func, this.prim, this.inc, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          func(prim, inc);
        },
        icon: child);
  }
}

class PrimitiveWrapper {
  int value = 0;
  PrimitiveWrapper(this.value);
}
