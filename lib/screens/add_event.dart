import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sliit_info_ctse/model/event_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class add_Event_screen extends StatefulWidget {
  const add_Event_screen({Key? key}) : super(key: key);

  @override
  State<add_Event_screen> createState() => _add_Event_screenState();
}

class _add_Event_screenState extends State<add_Event_screen> {



  //text editor controllers
  final event_name_editing_cntrlr = new TextEditingController();
  final venue_editing_cntrlr = new TextEditingController();
  final desc_editing_cntrlr = new TextEditingController();

  //event date and time
  DateTime? event_dateTime;

  //signup form key
  final _event_formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    //Event title field
    final event_title_Field = TextFormField(
      autofocus: false,
      controller: event_name_editing_cntrlr,
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
        event_name_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(9.0),
            child: FaIcon(FontAwesomeIcons.graduationCap),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Event Title",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //venue field
    final venue_field = TextFormField(
      autofocus: false,
      controller: venue_editing_cntrlr,
      keyboardType: TextInputType.text,
      //field validation
      validator: (val){
        if(val!.isEmpty){
          return ("field cannot be empty");
        }
        return null;
      },
      onSaved: (val){
        venue_editing_cntrlr.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(9.0),
            child: FaIcon(FontAwesomeIcons.hotel),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Venue",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final datetimepicker = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.8),
      ),
      padding: const EdgeInsets.fromLTRB(100, 1, 100, 1),
      child: TextButton(
          onPressed: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(2022, 3, 5),
                maxTime: DateTime(2056, 6, 7), onChanged: (date) {
                  print('change $date');
                }, onConfirm: (date) {
                  print('confirm $date');
                }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
          child: Text(
            'Select Date & Time',
            style: TextStyle(color: Colors.blue),
          )),
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
                        key: _event_formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              const SizedBox(height: 50),
                              event_title_Field,
                              const SizedBox(height: 20),
                              venue_field,
                              const SizedBox(height: 20),
                              datetimepicker,
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
    if(_event_formKey.currentState!.validate()){
      saveDatatoFirestore();
    }
  }

  saveDatatoFirestore() async{
    //initializinn firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    event_model eventModel = event_model();

    //maping the values
    eventModel.event_name = event_name_editing_cntrlr.text;
    eventModel.venue = venue_editing_cntrlr.text;
    eventModel.description = desc_editing_cntrlr.text;


    await firebaseFirestore.collection('events').doc().set(eventModel.toMap());
    Fluttertoast.showToast(msg: "Event added successfully");
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}


