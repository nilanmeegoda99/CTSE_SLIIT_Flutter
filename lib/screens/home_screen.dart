
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import '../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //firebase user authneication state
  User? user = FirebaseAuth.instance.currentUser;
  user_model currentUser = user_model();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
        (val){
          this.currentUser = user_model.fromMap(val.data());
          setState(() {

          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Welcome to the home",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 30,
              ),
              Text("Name : ${currentUser.f_name}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
              const SizedBox(
                height: 40,
              ),
              ActionChip(label: const Text("Logout"), onPressed: (){signout(context);},),
            ],
          ),
        )
      ),
    );
  }

  //signout function
Future<void> signout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
}
}
