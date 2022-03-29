import 'package:flutter/material.dart';
import 'package:sliit_info_ctse/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SLIIT INFO PORTAL',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Login_Screen(),
    );
  }
}
