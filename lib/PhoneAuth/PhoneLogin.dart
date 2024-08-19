import 'package:blog_app/PhoneAuth/OtpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController phonenumber = TextEditingController();
  bool isLoading = false;

  sendCode() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(//verify ph no
          phoneNumber: '+91' + phonenumber.text,
          verificationCompleted: (PhoneAuthCredential credential) {
            // if automatically fetch opt then logic add
          },
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar("Error Occurred", e.code);
          },
          codeSent: (String vid,int? token) { //we used token because of resent otp
            Get.to(OtpPage(vid: vid, PhoneNo: '',),);
          },
          codeAutoRetrievalTimeout: (vid) {
            //resend opt code then logic add
          });
    }   on FirebaseAuthException catch (e) {   // for showing error (exception handling)
      Get.snackbar("Error Occurred", e.code);
    } catch (e) {
      Get.snackbar("Error Occured", e.toString());
    }
    setState(() {  ////  //// This tow line for screen loading, also declear isLoading first  also pass in return sec
      isLoading = false;  //// This tow line for screen loading, also declear isLoading first  also pass in return sec
    });// End
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator(color: Color(0xffABAEE4),),)
        : Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                SizedBox(
                    height: 230,
                    width: 250,
                    child: SvgPicture.asset("assets/loginImage.svg")),
                SizedBox(
                  height: 20,
                ),
                Container(
                 // padding: EdgeInsets.all(MediaQuery.of(context).size.height *1),
                  child: Column(
                    children: [
                      Text("Your Phone!",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(
                        "we will send you a one time password"
                            " on this mobile number",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(keyboardType: TextInputType.number,
                  controller: phonenumber,
                  decoration: InputDecoration(
                      prefix: Text("+91  "),
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Enter Your Phone No",
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  width: Get.width * .9,
                  height: Get.height * 0.07,
                  child: ElevatedButton(
                      onPressed: () {
                sendCode();
                },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffABAEE4)),
                      child: Text(
                        "Received OTP",
                        style:
                        TextStyle(fontSize: 24, color: Colors.black),
                      )),
                ),
                // Container( width: double.infinity,
                //   child: ElevatedButton(
                //       onPressed: () {
                //         sendCode();
                //       },
                //       child: Text("Received OTP")),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
