import 'package:flutter/material.dart';
import 'FeedbackForm.dart';
import 'form_controller.dart';


class ScoutingForm extends StatefulWidget {
  const ScoutingForm({super.key, required this.title});
  final String title;
  @override
  _ScoutingForm createState() => _ScoutingForm();
}

class _ScoutingForm extends State<ScoutingForm> {
  final List<String> entries = <String>[
    'Question #1',
    'Quesetion #2',
    'Question #3',
  ];
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
          "a",
          "b",
          "c",
          "d");

      FormController formController = FormController();

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Feedback Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      });
    }
  }
  _showSnackbar(String message) {
      final snackBar = SnackBar(content: Text(message));
      print (message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) 
          {
            return Container(
              height: 100,
              color: Colors.deepPurple.shade50,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(entries[index]),
                    TextField(
                      controller: TextEditingController(),
                      onSubmitted: (String value) async {
                        await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Thanks!'),
                              content: Text(
                                  'You typed "$value", which has length ${value.characters.length}.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text("test"))
                  ],
                )
              )
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          
        )
      ),


    );
  }
}
