import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {


  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color:Colors.orange),
      onPressed: (){
        Navigator.pop(context);
      },
    ),
  );
}