import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliit_info_ctse/widgets/button_widget.dart';
import 'package:sliit_info_ctse/model/user_model.dart';
import 'package:sliit_info_ctse/widgets/appbar_widget.dart';
import 'package:sliit_info_ctse/widgets/profile_widget.dart';
import 'package:sliit_info_ctse/widgets/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: "${currentUser.imagePath}",
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'First Name',
            text: "${currentUser.f_name}",
            onChanged: (f_name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'last Name',
            text: "${currentUser.l_name}",
            onChanged: (l_name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: "${currentUser.email}",
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          accUpdateButton(),

        ],
      ),
    );
  }

  Widget accUpdateButton() => ButtonWidget(
    text: 'Update Account',
    onClicked: () {},
  );

}