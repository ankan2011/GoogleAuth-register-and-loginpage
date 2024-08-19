import 'package:blog_app/Check_fun/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  signup() async {
    setState(() {//// This tow line for screen loading, also declear isLoading first  also pass in return sec
      isLoading = true;  //// This tow line for screen loading, also declear isLoading first  also pass in return sec
    });
    try {                                             // This sec for snackbar error show using try catch
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      Get.offAll(WrapperState());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("error msg is", e.code);
    } catch (e) {
      Get.snackbar("error msg is",
        e.toString(),
      );
    }
    setState(() {  ////  //// This tow line for screen loading, also declear isLoading first  also pass in return sec
      isLoading = false;  //// This tow line for screen loading, also declear isLoading first  also pass in return sec
    });

  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator(color: Color(0xffABAEE4),),)
    : Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(margin: EdgeInsets.all(20),

                child: Text("Create Your Account",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
              SizedBox(
                  height: 250,
                  width: 250,
                  child: SvgPicture.asset("assets/signup.svg")),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      TextField(

                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.drive_file_rename_outline_rounded),
                            hintText: "Enter Your Name",
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Enter Your email",
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: password,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: "Create Your password",
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
        
                    ],
                  ),
                ),
              ),
        
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: Get.width * .9,
                height: Get.height * 0.07,
                child: ElevatedButton(
                    onPressed: (() => signup()),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffABAEE4)),
                    child: Text(
                      "Register ",
                      style:
                      TextStyle(fontSize: 24, color: Colors.black),
                    )),
              ),
             // ElevatedButton(onPressed: (()=>signup()), child: Text("Login"))
            ],
          ),
        ),
      ),

    );
  }
}
