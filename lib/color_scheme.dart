import 'package:flutter/material.dart';

class colors extends ColorScheme {
  // Define your custom colors here
  static const Color myPrimaryColor = Color.fromARGB(255, 255, 255, 255);
  static const Color myOnPrimary = Color.fromRGBO(189, 46, 46, 1);
  static const Color mySecondaryColor = Color.fromARGB(255, 58, 58, 58);
  
  static const Color myBackground = Color.fromARGB(255, 255, 255, 255);
  static const Color myOnBackground = Color.fromARGB(103, 216, 216, 216);
  static const Color myOnBackgroundD = Color.fromARGB(255, 184, 180, 180);

  
  static const Color mySurface = Color.fromARGB(255, 255, 255, 255);
  static const Color myOnSurface = Color.fromARGB(255, 4, 4, 4);

  
  static const Color myError = Color.fromARGB(255, 244, 5, 5);
  
  static const Color myBlue = Color.fromARGB(255, 55, 0, 255);
  static const Color myRed = Color.fromARGB(255, 255, 0, 0);

  static const Color myAmped = Color.fromARGB(255, 98, 97, 97);
  static const Color myMatch = Color.fromARGB(255, 4, 4, 4);


  // Override the constructor
  const colors({
    // Set your custom colors as primary and secondary
    Color primary = myPrimaryColor,
    Color onPrimary = myOnPrimary,
    Color background = myBackground,
    Color secondaryColor = mySecondaryColor,
    Color onBackground = myOnBackground,

    Color surface = mySurface,
    Color onSurface = myOnSurface,
    Color error = myError,
    Color blue = myBlue,  
    Color red = myRed,
    Color amped = myAmped,
    Color match = myMatch,

  
    // Include other color properties from the super class
    // such as background, surface, onBackground, etc.
  }) : super(
      primary: primary,//buttons? should be white
      onPrimary: onPrimary,//text on buttons should be red


      secondary: secondaryColor,//not used
      onSecondary: onPrimary,//doesn't show up?? 

      surface: surface,//top bar should be white
      onSurface: onSurface,//text on the surface should be black

      brightness: Brightness.light, 


      error: error,
      onError: primary,
      );
}