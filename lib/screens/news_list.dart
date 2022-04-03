import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sliit_info_ctse/widgets/appBar2.dart';

class newsList extends StatefulWidget {
  const newsList({Key? key}) : super(key: key);

  @override
  State<newsList> createState() => _newsListState();
}

class _newsListState extends State<newsList> {

  //collection reference
  final CollectionReference _news =
  FirebaseFirestore.instance.collection('news');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildLoggedAppBar(context),
      body: StreamBuilder(
        stream: _news.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                  Timestamp timeFrmServer = documentSnapshot['createdOn'];
                  DateTime datetimeConverted = timeFrmServer.toDate();
                  var gFormat = DateFormat.yMMMd().add_jm().format(datetimeConverted);
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child:ListTile(
                      tileColor: Colors.white70,
                      title: Text(documentSnapshot['title'], style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text('Created on ' + gFormat.toString()),
                      leading: const CircleAvatar(
                          child: FaIcon(FontAwesomeIcons.newspaper, color: Colors.white,)
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
                                  _deleteNews(documentSnapshot.id);
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
          Navigator.pushNamed(context, '/add_news');
          // Add your onPressed code here!
        },
        backgroundColor: const Color(0xff002F66),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  //delete function
  Future<void> _deleteNews(String newsID) async {
    await _news.doc(newsID).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a news')));
  }

}
