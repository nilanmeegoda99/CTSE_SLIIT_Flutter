
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";



import '../model/user_model.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 int _selectedPage = 0;
 PageController pageController = PageController();

 //authservice
 final AuthService _auth = AuthService();
 user_model currentUser = user_model();

 @override
 void initState() {
   // init state
   super.initState();
   FirebaseFirestore.instance.collection("users").doc(_auth.currentUser!.uid).get().then(
           (val){
         setState(() {
           currentUser = user_model.fromMap(val.data());
         });
       }
   );
 }

 List<_Photo> _photos(BuildContext context) {

   return [
     _Photo(
       assetName: 'assets/images/computing.jpg',
       title: "COMPUTING",
       subtitle: "Local & International",
       tileColor: 0xff053769
     ),
     _Photo(
       assetName: 'assets/images/engineering.jpg',
       title: "ENGINEERING",
       subtitle: "Local & International",
         tileColor: 0xff2A8945
     ),
     _Photo(
       assetName: 'assets/images/business.jpg',
       title: "BUSINESS",
       subtitle: "Local & International",
         tileColor: 0xffAA0B38
     ),
     _Photo(
       assetName: 'assets/images/humantise.jpg',
       title: "HUMANTISE & SCI",
       subtitle: "International",
         tileColor: 0xff873E8D
     ),
     _Photo(
       assetName: 'assets/images/graduate.jpg',
       title: "POSTGRADUATE",
       subtitle: "Local & International",
         tileColor: 0xffED9736
     ),
     _Photo(
       assetName: 'assets/images/archi.jpg',
       title: "ARCHITECTURE",
       subtitle: "International",
         tileColor: 0xff009FE3
     ),
     _Photo(
       assetName: 'assets/images/hospitality.jpg',
       title: "HOSPITALITY",
       subtitle: "International",
         tileColor: 0xffF5821F
     ),
   ];
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("SLIIT Info Portal") ,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color:Colors.orange, size: 35,),
            onPressed: (){
              _auth.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
            padding: const EdgeInsets.only(right: 10),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color:Colors.orange, size: 35,),
            onPressed: (){
              Navigator.pushNamed(context, '/userprofile');
            },
            padding: const EdgeInsets.only(right: 10),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                restorationId: 'grid_view_demo_grid_offset',
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: const EdgeInsets.all(8),
                childAspectRatio: 1,
                children: _photos(context).map<Widget>((photo) {
                  return _GridDemoPhotoItem(
                    photo: photo,
                  );
                }).toList(),
              ),
            ),
          ),
          Container(color: Colors.yellow,),
          Container(color: Colors.blue,)
        ],

      ),
      floatingActionButton: currentUser.acc_type == 'Admin' ? FloatingActionButton(
        onPressed: () {
          print(currentUser.acc_type);
          Navigator.pushNamed(context, '/add_event');
          // Add your onPressed code here!
        },
        backgroundColor: const Color(0xff002F66),
        child: const Icon(Icons.add, color: Colors.white,),
      ) : null,
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.graduationCap), label:'Faculties'),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.calendarDays), label:'Events'),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.newspaper), label:'News'),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.newspaper), label:'Staff'),
      ],
      currentIndex: _selectedPage,
      onTap: onTapped,),
    );
  }

void onTapped(int index){
    setState(() {
      _selectedPage = index;
    });
    pageController.animateToPage(index, duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
}
}

class _Photo {
  _Photo({
    required this.assetName,
    required this.title,
    required this.subtitle,
    required this.tileColor,
  });

  final String assetName;
  final String title;
  final String subtitle;
  final int tileColor;
}

/// Allow the text size to shrink to fit in the space
class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}

class _GridDemoPhotoItem extends StatelessWidget {
  const _GridDemoPhotoItem({
    Key? key,
    required this.photo,
  }) : super(key: key);

  final _Photo photo;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        photo.assetName,
        fit: BoxFit.cover,
      ),
    );
        return GridTile(
          footer: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              backgroundColor: Color(photo.tileColor),
              title: _GridTitleText(photo.title),
              subtitle: _GridTitleText(photo.subtitle),
            ),
          ),
          child: image,
        );
  }
}
