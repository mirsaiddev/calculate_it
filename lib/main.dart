import 'package:flutter/material.dart';

import 'calculate_page.dart';
import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculate It',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: MyColors.purple,
        scaffoldBackgroundColor: MyColors.bgColor,
      ),
      home: const CalculatePage(),
    );
  }
}
