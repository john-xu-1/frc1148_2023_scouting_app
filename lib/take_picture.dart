// import 'dart:async';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// class take_picture extends StatefulWidget {
//   const take_picture({Key? key, required this.camera}) : super(key: key);

//   final CameraDescription camera;

//   @override
//   _take_picture createState() => _take_picture();
// }

// class _take_picture extends State<take_picture> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // To display the current output from the Camera,
//     // create a CameraController.
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.camera,
//       // Define the resolution to use.
//       ResolutionPreset.medium,
//     );

//     // Next, initialize the controller. This returns a Future.
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller); // Display the camera preview
//           } else {
//             return const Center(child: CircularProgressIndicator()); // Display a loading indicator while initializing
//           }
//         },
//       ),
//     );
//     // Fill this out in the next steps.
//   }
// }
