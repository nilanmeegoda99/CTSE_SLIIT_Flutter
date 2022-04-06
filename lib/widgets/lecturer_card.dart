import 'dart:ui';
import 'package:flutter/material.dart';

class lecturerCard extends StatelessWidget {
  final String f_name;
  final String l_name;
  final String email;
  final String image_path;

  const lecturerCard(
      {Key? key,
      required this.email,
      required this.l_name,
      required this.f_name,
      required this.image_path})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.fromLTRB(12, 15, 12, 12),
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // ListTile(
            //     // title: Text(
            //     //   'Name: ' + lecturer_name,
            //     //   style:
            //     //       const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            //     // ),
            //     // subtitle: const Text(
            //     //   // 'On : ' + date_time + '  At : ' + venue,
            //     //   "Test",
            //     //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            //     // ),
            //     ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 4, // 40%
                  child: Container(
                    color: Colors.grey[50],
                    child: Center(
                      child: Expanded(
                        child: Image.network(
                          image_path,
                          width: 300,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6, // 60%
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 2),
                      Text(
                        f_name + ' ' + l_name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          email,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
