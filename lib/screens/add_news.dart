
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sliit_info_ctse/model/news_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_info_ctse/widgets/appBar2.dart';


class add_News_screen extends StatefulWidget {
  const add_News_screen({Key? key}) : super(key: key);

  @override
  State<add_News_screen> createState() => _add_News_screenState();
}

class _add_News_screenState extends State<add_News_screen> {



  //text editor controllers
  final title_editing_cntrlr = new TextEditingController();
  final desc_editing_cntrlr = new TextEditingController();



  //news form key
  final _news_formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    //news title field
    final news_title_Field = TextFormField(
      autofocus: false,
      controller: title_editing_cntrlr,
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
        title_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(9.0),
            child: FaIcon(FontAwesomeIcons.newspaper),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "News Title",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //description field
    final description_field = TextFormField(
      autofocus: false,
      controller: desc_editing_cntrlr,
      minLines: 1,
      maxLines: 6,
      keyboardType: TextInputType.multiline,
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
        desc_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(9.0),
            child: FaIcon(FontAwesomeIcons.pen),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Description",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );


    //submit button
    final submitBtn = Material(
        elevation : 5,
        borderRadius: BorderRadius.circular(25),
        color: Colors.orange,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: () {
              submitData();
            },
            minWidth: MediaQuery.of(context).size.width,
            child:const Text("Submit", textAlign: TextAlign.center,style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold
            ),)
        )
    );


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildLoggedAppBar(context),
        body: Center(
          child: SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                        key: _news_formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              const SizedBox(height: 50),
                              news_title_Field,
                              const SizedBox(height: 20),
                              description_field,
                              const SizedBox(height: 40),
                              submitBtn,

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
  void submitData()async{
    if(_news_formKey.currentState!.validate()){
      saveDatatoFirestore();
    }
  }

  saveDatatoFirestore() async{
    //initializinn firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    news_model newsModel = news_model();

    //maping the values
    newsModel.title = title_editing_cntrlr.text;
    newsModel.description = desc_editing_cntrlr.text;


    await firebaseFirestore.collection('news').doc().set(newsModel.toMap());
    Fluttertoast.showToast(msg: "News added successfully");
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}


