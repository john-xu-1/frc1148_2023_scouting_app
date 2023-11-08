import 'package:flutter/material.dart';
import 'FeedbackForm.dart';
import 'form_controller.dart';
import 'package:gsheets/gsheets.dart';
import 'scouting_form.dart';


class ScoutWindow extends StatefulWidget {
  const ScoutWindow({super.key, required this.entryObject});
  final ScoutingForm entryObject;
  @override
  _ScoutWindow createState() => _ScoutWindow(entryObject);

  ScoutingForm getEntryObjects(){
    return entryObject;
  }

}

class _ScoutWindow extends State<ScoutWindow> {

  ScoutingForm entryObject = ScoutingForm(title: "");
  _ScoutWindow(this.entryObject);

  var _selectedPageIndex;
  List<Widget> _pages = List.empty();
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;
    _pages = [
      
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         PageView(
          controller: _pageController,
          children: _pages,
        )
      ],
    );
   
  }
}
