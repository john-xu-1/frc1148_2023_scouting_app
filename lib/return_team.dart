import 'package:flutter/material.dart';

class return_team {
    //the string lists will be the blue and red teams in order of matches
  
  List<String> b1;
  List<String> b2;
  List<String> b3;
  List<String> r1;
  List<String> r2;
  List<String> r3;


  String parser(){

    

    return "";
  }



  return_team(this.b1, this.b2, this.b3, this.r1, this.r2, this.r3){


  }

  String identifier = "";
  int index = 0;

  void setLists (b1, b2, b3, r1, r2, r3){
    this.b1 = b1;
    this.b2 = b2;
    this.b3 = b3;
    this.r1 = r1;
    this.r2 = r2;
    this.r3 = r3;
  }

  void setIdentifier (String identifier){
    this.identifier = identifier;
  }

  void setIndex (int index){
    this.index = index;
  }

  //void setStringValue(String identifier, int index) {
  String setStringValue() {
    //after the q number and identifier are input changes the identifier's value
    String result = "";
    if (index < 1) {
      return ""; // Invalid index
    }

    

    if ((identifier == 'A')||(identifier == 'a')) {
      if (index <= b1.length) {
        result = b1[index - 1];
      }
    } else if ((identifier == 'B')||(identifier == 'b')) {
      if (index <= b2.length) {
        result = b2[index - 1];
      }
    } else if ((identifier == 'C')||(identifier == 'c')) {
      if (index <= b3.length) {
        result = b3[index - 1];
      }
    } else if ((identifier == 'D')||(identifier == 'd')) {
      if (index <= r1.length) {
        result = r1[index - 1];
      }
    } else if ((identifier == 'E')||(identifier == 'e')) {
      if (index <= r2.length) {
        result = r2[index - 1];
      }
    } else if ((identifier == 'F')||(identifier == 'f')) {
      if (index <= r3.length) {
        result = r3[index - 1];
      }
    }
    //print (result);
    return result;
  }
}
