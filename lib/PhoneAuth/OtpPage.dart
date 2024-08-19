import 'package:blog_app/Check_fun/Phone_wrapper.dart';
import 'package:blog_app/Check_fun/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {

  final String vid;
  final String PhoneNo;
  const OtpPage({super.key, required this.vid, required this.PhoneNo});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final user = FirebaseAuth.instance.currentUser;
  var code ='';



  signIn()async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.vid,
      smsCode: code,
    );
    try {

      await FirebaseAuth.instance.signInWithCredential(credential).then((value) =>
      {Get.offAll(PhoneWrapper())
    });
  }on FirebaseAuthException catch (e) {
        Get.snackbar("Error Occurred", e.code);
    } catch (e) {
      Get.snackbar("Error Occurred", e.toString());
    }
  }
    @override
    Widget build(BuildContext context) {

      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
          
                children: [
                  SizedBox(height: 20,),
                  Center(child: Text("Opt Verification", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),

                  Container(width: double.infinity,
                      height: 270,
                      child: Image.asset("assets/otp.png")),
          
                Text('Enter Your OPT  ', style: TextStyle(fontSize: 30),),
                  SizedBox(height: 20,),
                  //Center(child: Text("The no is ${user!.phoneNumber}")),
                  SizedBox(height: 20,),
                  Pinput(
                    length: 6,
                    onChanged: (value) {
                      setState(() {
                        code = value;
                      });
                    },
                  ),
                  SizedBox(height: 35,),

                  SizedBox(
                    width: Get.width * .9,
                    height: Get.height * 0.07,
                    child: ElevatedButton(
                        onPressed: (() => signIn()),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffABAEE4)),
                        child: const Text(
                          "Verify & Proceed",
                          style:
                          TextStyle(fontSize: 24, color: Colors.black),
                        )),
                  ),
                  Text("")
                  // Container(width: double.infinity,
                  //   child: ElevatedButton(onPressed: () {
                  //     signIn();

                  // )
                ],
              ),
            ),
          ),
        ),

      );
    }
  }
