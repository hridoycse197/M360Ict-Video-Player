import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/views/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Video Player',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
    );
  }
}

