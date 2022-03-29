
import 'package:flutter/material.dart';
import 'package:sliit_info_ctse/screens/home_screen.dart';
import 'package:sliit_info_ctse/screens/signup_screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  //text editing controllers
  final TextEditingController username_controller = TextEditingController();
  final TextEditingController pwd_controller = TextEditingController();


  // form key for email and password validation
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    //username field
    final username_field = TextFormField(
      autofocus: false,
      controller: username_controller,
      keyboardType: TextInputType.emailAddress,

      onSaved: (val){
        username_controller.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

    //password field
    final pwd_field = TextFormField(
      autofocus: false,
      controller: pwd_controller,
      obscureText: true,
      keyboardType: TextInputType.text ,

      onSaved: (val){
        pwd_controller.text = val!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //login button
    final signInBtn = Material(
      elevation : 5,
      borderRadius: BorderRadius.circular(25),
      color: Colors.orange,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        minWidth: MediaQuery.of(context).size.width,
        child:const Text("Sign In", textAlign: TextAlign.center,style: TextStyle(
          fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold
        ),)
      )
    );

    //signup_navigation


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    const SizedBox(height: 50),
                    username_field,
                    const SizedBox(height: 20),
                    pwd_field,
                    const SizedBox(height: 40),
                    signInBtn,
                    const SizedBox(height: 20),

                    //account creation navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignUp_Screen()),
                                );
                          },
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/images/z_p01-SLIIT.jpg",
                          fit: BoxFit.contain,
                        )),
                  ]
                )
              ),
            )

          )
        ),
      )
    );
  }
}
