import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliit_info_ctse/widgets/appBar2.dart';
import 'package:sliit_info_ctse/widgets/degreeCard.dart';

class degreeInfo extends StatefulWidget {

  //faculty attribute
  final String faculty;

  const degreeInfo({Key? key, required this.faculty}) : super(key: key);


  @override
  State<degreeInfo> createState() => _degreeInfoState();
}



class _degreeInfoState extends State<degreeInfo> {


  @override
  void initState(){
    final String _faculty = widget.faculty;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildLoggedAppBar(context),
      body:  Column(
        children: [
          Padding(
                  padding: const EdgeInsets.fromLTRB(1,5,1,5),
                  child: Text('FACULTY OF ' + widget.faculty, style: const TextStyle(fontSize: 26),),
                ),
          const SizedBox(height: 20,),
          Expanded(
            child:  StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('degrees').where('faculty', isEqualTo: 'Computing').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                          return degreeCard(
                            name: documentSnapshot['name'],
                            entry_req: documentSnapshot['entry_req'],
                            description: documentSnapshot['description'],
                            duration: documentSnapshot['duration'],
                            faculty: widget.faculty,);
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            ),
          )
        ],
      ),
    );
  }


}



