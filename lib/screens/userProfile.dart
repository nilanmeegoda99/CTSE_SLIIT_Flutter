import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sliit_info_ctse/model/user_model.dart';
import 'package:sliit_info_ctse/widgets/appbar_widget.dart';
import 'package:sliit_info_ctse/widgets/button_widget.dart';
import 'package:sliit_info_ctse/widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: "${currentUser.imagePath}",
            onClicked: () {
              Navigator.pushNamed(context, '/edit_profile');
            },
          ),
          const SizedBox(height: 24),
          buildName(currentUser),
          const SizedBox(height: 48),
          buildAbout(currentUser),
          const SizedBox(height: 54),
          Center(child: accDeleteButton()),
        ],
      ),
    );
  }

  Widget buildName(user_model user) => Column(
    children: [
      Text(
        "${user.f_name} ${user.l_name}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        "${user.email}",
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget accDeleteButton() => ButtonWidget(
    text: 'Delete My Account',
    onClicked: () {},
  );

  Widget buildAbout(user_model user) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'First Name',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "${user.f_name}",
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
        const SizedBox(height: 20),
        const Text(
          'Last Name',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "${user.l_name}",
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
        const SizedBox(height: 20),
        const Text(
          'Account Type',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "${user.acc_type}",
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}