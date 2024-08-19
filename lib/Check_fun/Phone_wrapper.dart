import 'package:blog_app/EmailAuth/login.dart';
import 'package:blog_app/PhoneAuth/PhoneLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../EmailAuth/home.dart';


class PhoneWrapper extends StatefulWidget {
  const PhoneWrapper({super.key});

  @override
  State<PhoneWrapper> createState() => _PhoneWrapperState();
}

class _PhoneWrapperState extends State<PhoneWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // User is signed in, check if email is verified
                if (snapshot.hasData) {
                  return HomePage();  // Email is verified, navigate to HomePage
                } else {
                  return PhoneLogin();  // Email is not verified, navigate to VerifyPage
                }
              }

              else {
                // User is not signed in, navigate to PhoneLogin
                return LoginPage();
              }
            }

            )
    );
  }
}
