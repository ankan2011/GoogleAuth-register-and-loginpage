import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: Column(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [

              Center(child: Text("Welcome , ${user!.email}")),
              Center(child: Text("Welcome , ${user!.phoneNumber}")),
              // SizedBox(
              //   height: 45,
              //   width: double.infinity,
              //   child: MaterialButton(
              //       color: Colors.red,
              //       onPressed: (()=>signout()), child: Text(
              //   "Sign Out",style: TextStyle(
              //       color: Colors.black),)),
              // )
    ],
    ),
      floatingActionButton: FloatingActionButton(
        onPressed:  (()=>signout()),child: Icon(Icons.login_rounded),
      ),


    );
  }
}
