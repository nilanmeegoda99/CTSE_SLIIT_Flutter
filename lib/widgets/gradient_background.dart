import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  GradientBackground({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Color.fromARGB(255, 1, 34, 61),
                Color.fromARGB(255, 182, 82, 16)
              ])),
        ),
        child,
      ],
    );
  }
}
