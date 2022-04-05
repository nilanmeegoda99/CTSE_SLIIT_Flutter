import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/loggedAppBar.dart';

class degreeList extends StatefulWidget {
  const degreeList({Key? key}) : super(key: key);

  @override
  State<degreeList> createState() => _degreeListState();
}

class _degreeListState extends State<degreeList> {

  //collection reference
  final CollectionReference _degrees =
  FirebaseFirestore.instance.collection('degrees');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildLoggedAppBar(context),
      body:
      Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(1, 5, 1, 5),
            child: Text('Available Degrees',
              style: TextStyle(fontSize: 26),),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: StreamBuilder(
              stream: _degrees.snapshots(),
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
                            title: Text(documentSnapshot['name'], style: const TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(documentSnapshot['faculty']),
                            leading: const CircleAvatar(backgroundImage: AssetImage('assets/images/degree_icon.png')),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print(currentUser.acc_type);
          Navigator.pushNamed(context, '/add_degree');
          // Add your onPressed code here!
        },
        backgroundColor: const Color(0xff002F66),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  //delete function
  Future<void> _deleteDegree(String degreeId) async {
    await _degrees.doc(degreeId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Degree')));
  }
}
