import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_info_ctse/model/user_model.dart';
import 'package:sliit_info_ctse/services/auth_service.dart';
import 'package:sliit_info_ctse/widgets/gradient_background.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({Key? key}) : super(key: key);

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  //picked image file
  PlatformFile? pickedFile;
  late String uploadedImgUrl;

  //authservice
  final AuthService _auth = AuthService();

  //account types
  final accTypes = ['Lecturer', 'Student'];

  //text editor controllers
  final f_name_editing_cntrlr = new TextEditingController();
  final l_name_editing_cntrlr = new TextEditingController();
  final email_editing_cntrlr = new TextEditingController();
  final pwd_editing_cntrlr = new TextEditingController();
  final confirm_pwd_editing_cntrlr = new TextEditingController();

  //account type
  String? accType;

  //signup form key
  final _signup_formKey = GlobalKey<FormState>();

  //menu item
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 16),
        ),
      );

  @override
  Widget build(BuildContext context) {
    //firstname field
    final fNameField = TextFormField(
      autofocus: false,
      controller: f_name_editing_cntrlr,
      keyboardType: TextInputType.text,
      //field validation
      validator: (val) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (val!.isEmpty) {
          return ("field cannot be empty");
        }
        if (!regex.hasMatch(val)) {
          return ("minimum length is 3 characters");
        }
        return null;
      },
      onSaved: (val) {
        f_name_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //image picker button viewer
    final imagePickerButton = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: [
            const Expanded(
              flex: 2,
              child: Text('Profile Picture'),
            ),
            Expanded(
              flex: 2,
              child: RawMaterialButton(
                fillColor: Theme.of(context).colorScheme.secondary,
                child: const FaIcon(
                  FontAwesomeIcons.photoFilm,
                  color: Colors.white,
                ),
                elevation: 2,
                onPressed: () {
                  getImage();
                },
                padding: const EdgeInsets.all(15),
                shape: const CircleBorder(),
              ),
            ),
            if (pickedFile != null)
              Expanded(
                flex: 6,
                child: Container(
                  color: Colors.grey[50],
                  child: Center(
                    child: Expanded(
                      child: Image.file(
                        File(pickedFile!.path!),
                        width: 120,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
          ],
        )
      ],
    );

    //lastname field
    final lNameField = TextFormField(
      autofocus: false,
      controller: l_name_editing_cntrlr,
      keyboardType: TextInputType.text,
      //field validation
      validator: (val) {
        if (val!.isEmpty) {
          return ("field cannot be empty");
        }
        return null;
      },
      onSaved: (val) {
        l_name_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //account type field
    final accTypeField = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.8),
      ),
      padding: const EdgeInsets.fromLTRB(20, 1, 20, 1),
      child: DropdownButtonFormField<String>(
        value: accType,
        isExpanded: true,
        hint: const Text('Select Account type'),
        items: accTypes.map(buildMenuItem).toList(),
        onChanged: (value) => setState(() => this.accType = value),
      ),
    );

    //username field
    final username_field = TextFormField(
      autofocus: false,
      controller: email_editing_cntrlr,
      keyboardType: TextInputType.emailAddress,
      //email field validation
      validator: (val) {
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val!)) {
          return ("Please enter a valid username");
        }
        if (val.isEmpty) {
          return ("Please enter your username");
        }
        return null;
      },
      onSaved: (val) {
        email_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //password field
    final pwd_field = TextFormField(
      autofocus: false,
      controller: pwd_editing_cntrlr,
      obscureText: true,
      //field validation
      validator: (val) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (val!.isEmpty) {
          return ("field cannot be empty");
        }
        if (!regex.hasMatch(val)) {
          return ("minimum length is 6 characters");
        }
        return null;
      },
      onSaved: (val) {
        pwd_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //re-enter password field
    final confirm_pwd_field = TextFormField(
      autofocus: false,
      controller: confirm_pwd_editing_cntrlr,
      obscureText: true,
      //field validation
      validator: (val) {
        if (confirm_pwd_editing_cntrlr.text != pwd_editing_cntrlr.text) {
          return ("passwords do not match");
        }
        return null;
      },
      onSaved: (val) {
        confirm_pwd_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //signup button
    final signUpBtn = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(25),
        color: Colors.orange,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: () async {
              _auth
                  .signUp(
                      email: email_editing_cntrlr.text,
                      password: pwd_editing_cntrlr.text)
                  .then((value) async {
                if (value == null) {
                  await uploadFile().then((value) {
                    saveDatatoFirestore();
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      value,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ));
                }
              });
            },
            minWidth: MediaQuery.of(context).size.width,
            child: const Text(
              "Register",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.orange),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        // resizeToAvoidBottomInset: false,
        body: GradientBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 240, 239, 239)
                        .withOpacity(0.5)),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(1, 5, 1, 5),
                      child: Text(
                        'Create a new account',
                        style: TextStyle(fontSize: 26),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 240, 239, 239)
                                    .withOpacity(0.7)),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Form(
                                  key: _signup_formKey,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        imagePickerButton,
                                        const SizedBox(height: 20),
                                        fNameField,
                                        const SizedBox(height: 20),
                                        lNameField,
                                        const SizedBox(height: 20),
                                        accTypeField,
                                        const SizedBox(height: 20),
                                        username_field,
                                        const SizedBox(height: 20),
                                        pwd_field,
                                        const SizedBox(height: 20),
                                        confirm_pwd_field,
                                        const SizedBox(height: 20),
                                        signUpBtn,
                                      ])),
                            )),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  //functions

  saveDatatoFirestore() async {
    //initializinn firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    user_model userModel = user_model();

    //maping the values
    userModel.uid = _auth.currentUser!.uid;
    userModel.email = _auth.currentUser!.email;
    userModel.f_name = f_name_editing_cntrlr.text;
    userModel.l_name = l_name_editing_cntrlr.text;
    userModel.acc_type = accType;
    userModel.imagePath = uploadedImgUrl;

    await firebaseFirestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Profile created successfully");
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  // File Picker select image
  Future getImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  //upload to the firebase storage
  Future uploadFile() async {
    final path = 'uploads/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    String urlDownload = await (await uploadTask).ref.getDownloadURL();
    print('download url: $urlDownload');

    setState(() {
      uploadedImgUrl = urlDownload;
    });
  }
}
