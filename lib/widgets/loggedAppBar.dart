import 'package:flutter/material.dart';
import 'package:sliit_info_ctse/services/auth_service.dart';

//authservice
final AuthService _auth = AuthService();

AppBar buildLoggedAppBar(BuildContext context){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: const Text("SLIIT INFO", style: TextStyle(color: Color(0xff002F66), fontWeight: FontWeight.w600, fontSize: 25),) ,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color:Colors.orange),
      onPressed: (){
        Navigator.pop(context);
      },
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.logout_rounded, color:Colors.orange, size: 35,),
        onPressed: (){
          _auth.signOut();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Signed Out Successfully')));
          Navigator.pushReplacementNamed(context, '/');
        },
        padding: const EdgeInsets.only(right: 10),
      ),
      IconButton(
        icon: const Icon(Icons.account_circle, color:Colors.orange, size: 35,),
        onPressed: (){
          Navigator.pushNamed(context, '/userprofile');
        },
        padding: const EdgeInsets.only(right: 10),
      ),
    ],
  );
}