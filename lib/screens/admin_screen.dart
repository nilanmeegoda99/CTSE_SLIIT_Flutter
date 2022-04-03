import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/appBar2.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  List<String> configs = [
    "Degree Info Configuration",
    "Event Info Configuration",
    "News Info Configuration",
    "Staff Configuration",
    "Student Configuration",
  ];

  List<String> configsLinks = [
    '/degreeList',
    '/eventList',
    '/newsList',
    '/lecture_config',
    '/student_config',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildLoggedAppBar(context),
        body: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xff002F66),
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.gear, color: Colors.white,),
                    onPressed: (){
                      Navigator.pushNamed(context, configsLinks[index]);
                    },
                  ),
                ),
                title: Text(configs[index]),
                onTap: (){
                  Navigator.pushNamed(context, configsLinks[index]);
                },
              ),
            );
          },
          itemCount: configs.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        ));
  }
}


