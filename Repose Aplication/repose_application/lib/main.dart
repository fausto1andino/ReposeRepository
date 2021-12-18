import 'package:flutter/material.dart';
import 'package:repose_application/src/pages/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith( secondary: Colors.orange[200]),
        scaffoldBackgroundColor: const Color(0xFFF6E6D9),
      ),
      home: Scaffold(
          
          appBar: AppBar(centerTitle: true, title: const Text("Repose"), ),
          body:  HomePage()),
          
    );
  }
}