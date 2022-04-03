
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sliit_info_ctse/model/event_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sliit_info_ctse/widgets/appBar2.dart';

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
  String _date = "Not set";
  String _time = "Not set";

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

    //date and time picker
    final datetimepicker = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () {
            DatePicker.showDatePicker(context,
                theme: const DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true,
                minTime: DateTime(2000, 1, 1),
                maxTime: DateTime(2055, 12, 31), onConfirm: (date) {
                  print('confirm $date');
                  _date = '${date.year} - ${date.month} - ${date.day}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
          child: Container(
            alignment: Alignment.center,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.date_range,
                            size: 18.0,
                            color: Colors.grey,
                          ),
                          Text(
                            " $_date",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Text(
                  "  Change",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () {
            DatePicker.showTimePicker(context,
                theme: const DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true, onConfirm: (time) {
                  print('confirm $time');
                  _time = '${time.hour} : ${time.minute} : ${time.second}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.access_time,
                            size: 18.0,
                            color: Colors.grey,
                          ),
                          Text(
                            " $_time",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Text(
                  "  Change",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ],
            ),
          ),
        )
      ],
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
    eventModel.date_time = '$_date at $_time';


    await firebaseFirestore.collection('events').doc().set(eventModel.toMap());
    Fluttertoast.showToast(msg: "Event added successfully");
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}


