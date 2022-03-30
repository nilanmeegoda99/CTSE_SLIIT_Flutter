import 'package:flutter/material.dart';

class btn_design_01 extends StatefulWidget {
  final String text;
  final String navScreen;
  const btn_design_01({Key? key, required this.text, required this.navScreen}) : super(key: key);

  @override
  State<btn_design_01> createState() => _btn_design_01State();
}

class _btn_design_01State extends State<btn_design_01> {
  String? get navScreen => null;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation : 5,
        borderRadius: BorderRadius.circular(25),
        color: Colors.orange,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: () {
              Navigator.pushNamed(context, navScreen!);
            },
            minWidth: MediaQuery.of(context).size.width,
            child:const Text("Sign In", textAlign: TextAlign.center,style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold
            ),)
        )
    );
  }
}
