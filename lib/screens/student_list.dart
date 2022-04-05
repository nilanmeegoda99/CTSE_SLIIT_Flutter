import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/loggedAppBar.dart';

class studentList extends StatefulWidget {
  const studentList({Key? key}) : super(key: key);

  @override
  State<studentList> createState() => _studentListState();
}

class _studentListState extends State<studentList> {

  //collection reference
  final CollectionReference _lecturers =
  FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildLoggedAppBar(context),
      body: StreamBuilder<QuerySnapshot>(
        stream: _lecturers.where(
            'acc_type', isEqualTo: 'Student').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child:ListTile(
                      tileColor: Colors.white70,
                      title: Text(documentSnapshot['f_name'], style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(documentSnapshot['email']),
                      leading:  CircleAvatar(backgroundImage: NetworkImage('${documentSnapshot['imagePath']}')),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
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
    );
  }

  //delete function
  Future<void> _deleteDegree(String userId) async {
    await _lecturers.doc(userId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User has been deleted successfully!')));
  }

}
