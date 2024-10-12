import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 255, 81, 81),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color.fromARGB(255, 255, 216, 216),
  onPrimaryContainer: Color.fromARGB(255, 78, 3, 3),
  secondary: Color.fromARGB(255, 115, 88, 87),
  onSecondary: Color.fromARGB(255, 255, 255, 255),
  error: Color.fromARGB(255, 176, 0, 82),
  onError: Color.fromARGB(255, 255, 255, 255),
  background: Color.fromARGB(255, 255, 251, 254),
  onBackground: Color.fromARGB(255, 29, 27, 31),
  surface: Color.fromARGB(255, 255, 251, 254),
  onSurface: Color.fromARGB(255, 28, 27, 31),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color.fromARGB(255, 147, 2, 2),
  onPrimary: Color.fromARGB(255, 133, 0, 0),
  primaryContainer: Color.fromARGB(255, 121, 41, 41),
  onPrimaryContainer: Color.fromARGB(255, 255, 216, 216),
  secondary: Color.fromARGB(255, 225, 189, 189),
  onSecondary: Color.fromARGB(255, 65, 42, 42),
  error: Color.fromARGB(255, 207, 102, 102),
  onError: Color.fromARGB(255, 28, 27, 31),
  background: Color.fromARGB(255, 18, 18, 18),
  onBackground: Color.fromARGB(255, 225, 225, 225),
  surface: Color.fromARGB(255, 18, 18, 18),
  onSurface: Color.fromARGB(255, 225, 225, 225),
);


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