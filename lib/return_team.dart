import 'package:flutter/material.dart';

class return_team {
 String A = "";
  String B = "";
  String C = "";
  String D = "";
  String E = "";
  String F = "";
  
  //the string lists will be the blue and red teams in order of matches
  List<String> b1 = ["5", ""];
  List<String> b2 = ["", ""];
  List<String> b3 = ["", ""];
  List<String> r1 = ["", ""];
  List<String> r2 = ["", ""];
  List<String> r3 = ["", ""];

  void setStringValue(String identifier, int index) {
    //after the q number and identifier are input changes the identifier's value
    if (index < 1) {
      return; // Invalid index
    }

    if (identifier == 'A') {
      if (index <= b1.length) {
        A = b1[index - 1];
      }
    } else if (identifier == 'B') {
      if (index <= b2.length) {
        B = b2[index - 1];
      }
    } else if (identifier == 'C') {
      if (index <= b3.length) {
        C = b3[index - 1];
      }
    } else if (identifier == 'D') {
      if (index <= r1.length) {
        D = r1[index - 1];
      }
    } else if (identifier == 'E') {
      if (index <= r2.length) {
        E = r2[index - 1];
      }
    } else if (identifier == 'F') {
      if (index <= r3.length) {
        F = r3[index - 1];
      }
    }
  }
}
