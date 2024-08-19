// import 'package:blog_app/Phone_auth/home.dart';
// import 'package:blog_app/Phone_auth/login.dart';
// import 'package:blog_app/Phone_auth/verify.dart';
import 'package:blog_app/EmailAuth/home.dart';
import 'package:blog_app/EmailAuth/login.dart';
import 'package:blog_app/EmailAuth/verify.dart';
import 'package:blog_app/PhoneAuth/PhoneLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

class WrapperState extends StatefulWidget {
  const WrapperState({super.key});

  @override
  State<WrapperState> createState() => _WrapperStateState();
}

class _WrapperStateState extends State<WrapperState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is signed in, check if email is verified
            if (snapshot.data!.emailVerified) {
              return HomePage();  // Email is verified, navigate to HomePage
            } else {
              return VerifyPage();  // Email is not verified, navigate to VerifyPage
            }
          }

          else {
            // User is not signed in, navigate to PhoneLogin
            return LoginPage();
          }
        },

      ),
      // body: StreamBuilder(
      //         stream: FirebaseAuth.instance.authStateChanges(),
      //         builder: (context,snapshot)
      //         {
      //
      //           if(snapshot.hasData){
      //             print(snapshot.data);
      //             if(snapshot.data!.emailVerified) {
      //               return HomePage();
      //             }else{
      //             return VerifyPage();
      //             }
      //           }
      //           else {
      //             return LoginPage();
      //           }
      //
      //           }
      //       )
    );
  }
}
