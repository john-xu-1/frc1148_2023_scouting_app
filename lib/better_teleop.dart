import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/subjective_form.dart';
import 'sheets_helper.dart';
import 'color_scheme.dart';

PrimitiveWrapper playerPointsToAdd = PrimitiveWrapper(0);
PrimitiveWrapper numberOfPasses = PrimitiveWrapper(0);

PrimitiveWrapper speakerCounter = PrimitiveWrapper(0);

PrimitiveWrapper ampPoints = PrimitiveWrapper(0);
PrimitiveWrapper trapPoints = PrimitiveWrapper(0);

PrimitiveWrapper missedS = PrimitiveWrapper(0);
PrimitiveWrapper missedA = PrimitiveWrapper(0);
PrimitiveWrapper missedT = PrimitiveWrapper(0);

bool tryParkTele = false;
bool messUpParkTele = false;
int cycleCounter = 0;

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
        speakerCounter.value,
        ampPoints.value,
        trapPoints.value,
        missedS.value,
        missedA.value,
        missedT.value,
        tryParkTele,
        messUpParkTele,
        numberOfPasses.value
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
      if (variable.value + inc >= 0) {
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
              const Text("Team change in case error: "),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                Row(children: [
                  const Text("Speaker"),
                  const SizedBox(width: 100),
                  Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text("${numberOfPasses.value}")),
                ]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Text("+")),
                    const SizedBox(width: 40),
                    Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Text("+")),
                ]),
                // ScoreDisplay(numberOfPasses.value, "Passes: "),
                // CounterButton(
                //     update,
                //     numberOfPasses,
                //     1,
                //     const Text(
                //       '+',
                //       textScaleFactor: 2,
                //     )),
                // CounterButton(
                //     update,
                //     numberOfPasses,
                //     -1,
                //     const Text(
                //       '-',
                //       textScaleFactor: 2.5,
                //     )),
              ]),
            ],
          ),
          // ScoreDisplay(numberOfPasses.value, "Passes: "),
          // CounterButton(
          //     update,
          //     numberOfPasses,
          //     1,
          //     const Text(
          //       '+',
          //       textScaleFactor: 2,
          //     )),
          // CounterButton(
          //     update,
          //     numberOfPasses,
          //     -1,
          //     const Text(
          //       '-',
          //       textScaleFactor: 2.5,
          //     )),
          const Divider(color: colors.mySecondaryColor),
          Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ScoreDisplay(ampPoints.value, "Speaker Pts: "),
                Row(
                  children: [
                    SizedBox(
                        height: height / 3,
                        width: width * 0.25,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Amplified", textScaleFactor: 1.5),
                              CounterButton(
                                  update,
                                  ampPoints,
                                  5,
                                  const Text(
                                    '+',
                                    textScaleFactor: 2,
                                  )),
                              CounterButton(
                                  update,
                                  ampPoints,
                                  -5,
                                  const Text(
                                    '-',
                                    textScaleFactor: 2.5,
                                  )),
                            ])),
                    SizedBox(
                        height: height / 3,
                        width: width * 0.25,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Regular", textScaleFactor: 1.5),
                              CounterButton(
                                  update,
                                  ampPoints,
                                  2,
                                  const Text(
                                    '+',
                                    textScaleFactor: 2,
                                  )),
                              CounterButton(
                                  update,
                                  ampPoints,
                                  -2,
                                  const Text(
                                    '-',
                                    textScaleFactor: 2.5,
                                  )),
                            ])),
                  ],
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  width: width * 0.45,
                  child: const Divider(color: colors.mySecondaryColor),
                ),
                ScoreDisplay(missedS.value, "Missed Speaker: "),
                CounterButton(
                    update,
                    missedS,
                    1,
                    const Text(
                      '+',
                      textScaleFactor: 2,
                    )),
                CounterButton(
                    update,
                    missedS,
                    -1,
                    const Text(
                      '-',
                      textScaleFactor: 2.5,
                    )),
              ],
            ),
            SizedBox(
              height: height * 0.9,
              child: const VerticalDivider(
                color: colors.mySecondaryColor,
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScoreDisplay(ampPoints.value, "Amp pts: "),
                  CounterButton(
                      update,
                      ampPoints,
                      1,
                      const Text(
                        '+',
                        textScaleFactor: 2,
                      )),
                  CounterButton(
                      update,
                      ampPoints,
                      -1,
                      const Text(
                        '-',
                        textScaleFactor: 2.5,
                      )),
                  const SizedBox(
                    height: 165,
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    width: width * 0.45,
                    child: const Divider(color: colors.mySecondaryColor),
                  ),
                  ScoreDisplay(missedA.value, "Missed Amps: "),
                  CounterButton(
                      update,
                      missedA,
                      1,
                      const Text(
                        '+',
                        textScaleFactor: 2,
                      )),
                  CounterButton(
                      update,
                      missedA,
                      -1,
                      const Text(
                        '-',
                        textScaleFactor: 2.5,
                      )),
                ]),
          ]),
          Container(
            height: height / 10,
            alignment: AlignmentDirectional.center,
            width: width * 0.4,
            //color: Colors.amber[100],
            child: const Text(
              "Trap",
              textScaleFactor: 2.5,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                ScoreDisplay(trapPoints.value, "Points:"),
                CounterButton(
                    update,
                    trapPoints,
                    5,
                    const Text(
                      '+',
                      textScaleFactor: 2,
                    )),
                CounterButton(
                    update,
                    trapPoints,
                    -5,
                    const Text(
                      '-',
                      textScaleFactor: 2.5,
                    )),
              ]),
              const SizedBox(
                width: 50,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                ScoreDisplay(missedT.value, "missed:"),
                CounterButton(
                    update,
                    missedT,
                    1,
                    const Text(
                      '+',
                      textScaleFactor: 2,
                    )),
                CounterButton(
                    update,
                    missedT,
                    -1,
                    const Text(
                      '-',
                      textScaleFactor: 2.5,
                    )),
              ]),
            ],
          ),
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
