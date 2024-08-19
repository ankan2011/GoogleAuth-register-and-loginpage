import 'dart:async';
import 'package:blog_app/Check_fun/wrapper.dart';
// import 'package:blog_app/Phone_auth/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Timer(Duration(seconds: 2), (){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   WrapperState()));
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        color: Colors.black,
        child: Center(

            child: Image.asset("assets/image.png")),
      ),
    );
  }
}
