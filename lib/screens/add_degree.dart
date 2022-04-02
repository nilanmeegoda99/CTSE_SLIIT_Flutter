import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sliit_info_ctse/model/user_model.dart';

class add_Degree_screen extends StatefulWidget {
  const add_Degree_screen({Key? key}) : super(key: key);

  @override
  State<add_Degree_screen> createState() => _add_Degree_screenState();
}

class _add_Degree_screenState extends State<add_Degree_screen> {

  //firebase authentication and firestore
  final fAuth = FirebaseAuth.instance;

  //account types
  final accTypes = ['Lecturer','Student'];

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
  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(
        item,
        style: const TextStyle(fontSize: 16),
      ),);

  @override
  Widget build(BuildContext context) {

    //firstname field
    final fNameField = TextFormField(
      autofocus: false,
      controller: f_name_editing_cntrlr,
      keyboardType: TextInputType.text,
      //field validation
      validator: (val){
        RegExp regex = new RegExp(r'^.{3,}$');
        if(val!.isEmpty){
          return ("field cannot be empty");
        }
        if(!regex.hasMatch(val)){
          return ("minimum length is 3 characters");
        }
        return null;
      },
      onSaved: (val){
        f_name_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //lastname field
    final lNameField = TextFormField(
      autofocus: false,
      controller: l_name_editing_cntrlr,
      keyboardType: TextInputType.text,
      //field validation
      validator: (val){
        if(val!.isEmpty){
          return ("field cannot be empty");
        }
        return null;
      },
      onSaved: (val){
        l_name_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
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
        items: accTypes.map(buildMenuItem).toList(),
        onChanged: (value) => setState(()=> this.accType = value),
      ),
    );

    //username field
    final username_field = TextFormField(
      autofocus: false,
      controller: email_editing_cntrlr,
      keyboardType: TextInputType.emailAddress,
      //email field validation
      validator: (val){
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val!)){
          return ("Please enter a valid username");
        }
        if (val.isEmpty){
          return ("Please enter your username");
        }
        return null;
      },
      onSaved: (val){
        email_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //password field
    final pwd_field = TextFormField(
      autofocus: false,
      controller: pwd_editing_cntrlr,
      obscureText: true,
      //field validation
      validator: (val){
        RegExp regex = new RegExp(r'^.{6,}$');
        if(val!.isEmpty){
          return ("field cannot be empty");
        }
        if(!regex.hasMatch(val)){
          return ("minimum length is 6 characters");
        }
        return null;
      },
      onSaved: (val){
        pwd_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //re-enter password field
    final confirm_pwd_field = TextFormField(
      autofocus: false,
      controller: confirm_pwd_editing_cntrlr,
      obscureText: true,
      //field validation
      validator: (val){

        if(confirm_pwd_editing_cntrlr.text != pwd_editing_cntrlr.text){
          return ("passwords do not match");
        }
        return null;
      },
      onSaved: (val){
        confirm_pwd_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );


    //signup button
    final signUpBtn = Material(
        elevation : 5,
        borderRadius: BorderRadius.circular(25),
        color: Colors.orange,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: () {
              register(email_editing_cntrlr.text, pwd_editing_cntrlr.text);
            },
            minWidth: MediaQuery.of(context).size.width,
            child:const Text("Register", textAlign: TextAlign.center,style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold
            ),)
        )
    );


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color:Colors.orange),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                        key: _signup_formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              const SizedBox(height: 50),
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
                              const SizedBox(height: 40),
                              signUpBtn,

                            ]
                        )
                    ),
                  )

              )
          ),
        )
    );
  }

  //functions
  void register(String email, String password)async{
    if(_signup_formKey.currentState!.validate()){
      await fAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) =>
      {
        saveDatatoFirestore()
      }
      ).catchError((err){
        Fluttertoast.showToast(msg: err!.message);
      });
    }
  }

  saveDatatoFirestore() async{
    //initializinn firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = fAuth.currentUser;

    user_model userModel = user_model();

    //maping the values
    userModel.uid = user!.uid;
    userModel.email = user.email;
    userModel.f_name = f_name_editing_cntrlr.text;
    userModel.l_name = l_name_editing_cntrlr.text;
    userModel.acc_type = accType;

    await firebaseFirestore.collection("users").doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Profile created successfully");
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}


