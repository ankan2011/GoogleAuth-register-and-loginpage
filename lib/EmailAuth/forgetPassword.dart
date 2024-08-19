import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController email = TextEditingController();

  bool isLoading = false;

  reset() async {
    setState(() {
      isLoading = true;
    });
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);

    }on FirebaseAuthException catch(e){
      Get.snackbar("Error msg is" , e.code);
    } catch(e){
      Get.snackbar("Error msg is", e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return  isLoading ? Center(child: CircularProgressIndicator(color: Color(0xffABAEE4),))
    : Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              children: [
                SizedBox(
                    height: 330,
                    width: 350,
                    child: Image.asset("assets/for.png")),
                SizedBox(
                  height: 22,
                ),
                Text("Forgot Your Password!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 10,),
                Text("Don't Warry",
                  style: TextStyle(
                    fontSize: 15,
                  ),),
                SizedBox(height: 20,),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                      //  left: 20,
                        //right: 20
                      ),
                    //padding: EdgeInsets.only(
                      //  top: MediaQuery.of(context).size.height * 0.6),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: "Enter Your email",
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
                SizedBox(height: 35,),
                SizedBox(
                  width: Get.width * .9,
                  height: Get.height * 0.07,
                  child: ElevatedButton(
                      onPressed: (() => reset()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffABAEE4)),
                      child: Text(
                        "Send Link",
                        style:
                        TextStyle(fontSize: 24, color: Colors.black),
                      )),
                ),

             //   ElevatedButton(onPressed: (() => reset()), child: Text("Send link"))
              ],
            ),

        ),
      ),
    );
  }
}
