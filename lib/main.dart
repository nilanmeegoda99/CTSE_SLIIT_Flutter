import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sliit_info_ctse/screens/add_degree.dart';
import 'package:sliit_info_ctse/screens/add_news.dart';
import 'package:sliit_info_ctse/screens/admin_screen.dart';
import 'package:sliit_info_ctse/screens/edit_prodile.dart';
import 'package:sliit_info_ctse/screens/home_screen.dart';
import 'package:sliit_info_ctse/screens/login_screen.dart';
import 'package:sliit_info_ctse/screens/signup_screen.dart';
import 'package:sliit_info_ctse/screens/userProfile.dart';

import 'screens/add_event.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
     initialRoute: '/',
      routes: {
        '/': (context) => const Login_Screen(),
        '/signup': (context) => const SignUp_Screen(),
        '/home': (context) => const HomeScreen(),
        '/userprofile': (context) => ProfilePage(),
        '/edit_profile' : (context) => EditProfilePage(),
        '/add_degree': (context) => const add_Degree_screen(),
        '/add_event': (context) => const add_Event_screen(),
        '/add_news': (context) => const add_News_screen(),
        '/admin': (context) => const  AdminScreen(),
      },
    );
  }
}
