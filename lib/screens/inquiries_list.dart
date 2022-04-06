import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/loggedAppBar.dart';

class inquiryList extends StatefulWidget {
  const inquiryList({Key? key}) : super(key: key);

  @override
  State<inquiryList> createState() => _inquiryListState();
}

class _inquiryListState extends State<inquiryList> {

  //collection reference
  final CollectionReference _inquiries =
  FirebaseFirestore.instance.collection('inquiries');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildLoggedAppBar(context),
      body: StreamBuilder(
        stream: _inquiries.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(12),
                    child:ListTile(
                      tileColor: Colors.white70,
                      title: Text('Enquiry No: ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(2,5,2,5),
                        child: Text(documentSnapshot['inquiryDesc']),
                      ),
                      leading: const CircleAvatar(backgroundImage: AssetImage('assets/images/enquiry-icon.png')),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit, color: Colors.green,),
                                onPressed: () {
                                }),
                            IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red,),
                                onPressed: () {
                                  _deleteDegree(documentSnapshot.id);
                                }
                            ),
                          ],
                        ),
                      ),),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print(currentUser.acc_type);
          Navigator.pushNamed(context, '/add_inquiry');
          // Add your onPressed code here!
        },
        backgroundColor: const Color(0xff002F66),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  //delete function
  Future<void> _deleteDegree(String degreeId) async {
    await _inquiries.doc(degreeId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Inquiry')));
  }
}