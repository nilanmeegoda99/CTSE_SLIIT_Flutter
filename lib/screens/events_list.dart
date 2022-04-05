import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_info_ctse/widgets/loggedAppBar.dart';

class eventList extends StatefulWidget {
  const eventList({Key? key}) : super(key: key);

  @override
  State<eventList> createState() => _eventListState();
}

class _eventListState extends State<eventList> {

  //collection reference
  final CollectionReference _events =
  FirebaseFirestore.instance.collection('events');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildLoggedAppBar(context),
      body: StreamBuilder(
        stream: _events.snapshots(),
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
                      title: Text(documentSnapshot['event_name'], style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text('At ' + documentSnapshot['venue']),
                      leading:  const CircleAvatar(
                        child: FaIcon(FontAwesomeIcons.calendarDays, color: Colors.white,)
                      ),
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
                                  _deleteEvent(documentSnapshot.id);
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
          Navigator.pushNamed(context, '/add_event');
          // Add your onPressed code here!
        },
        backgroundColor: const Color(0xff002F66),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }


  //delete function
  Future<void> _deleteEvent(String eventId) async {
    await _events.doc(eventId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a event')));
  }
}
