// import 'package:blog_app/PhoneLogin.dart';
// import 'package:blog_app/Phone_auth/forgetPassword.dart';
// import 'package:blog_app/Phone_auth/signup.dart';
import 'package:blog_app/EmailAuth/forgetPassword.dart';
import 'package:blog_app/EmailAuth/signup.dart';
import 'package:blog_app/PhoneAuth/PhoneLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  googleLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn()
        .signIn(); // This is show list of email in your phone
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication; // authenticate your acc

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, // get token
      idToken: googleAuth?.idToken, //get token
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  login() async {
    setState(() { //// This tow line for screen loading, also declear isLoading first  also pass in return sec
      isLoading = true; //// This tow line for screen loading, also declear isLoading first  also pass in return sec
      });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          "error msg is", e.code);
    } catch (e) {
      Get.snackbar("error msg is",
        e.toString(),
      );
    }
    setState(() { //// This tow line for screen loading, also declear isLoading first  also pass in return sec
      isLoading = false; //// This tow line for screen loading, also declear isLoading first  also pass in return sec
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator(color: Color(0xffABAEE4),),)
        : Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(

                  child: Column(
                    children: [
                      SizedBox(
                          height: 230,
                          width: 250,
                          child: SvgPicture.asset("assets/loginImage.svg")),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: Column(
                          children: [
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
                           obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              hintText: "Enter Your password",
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),

                          ],
                      ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: (() => Get.to(Forgetpassword())),
                            child: Text("Forgot Password ?",
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Get.width * .9,
                        height: Get.height * 0.07,
                        child: ElevatedButton(
                            onPressed: (() => login()),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffABAEE4)),
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            )),
                      ),
                      SizedBox(
                        height: 12,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an Account?",
                              style: TextStyle(fontSize: 17)),
                          TextButton(
                              onPressed: (() => Get.to(SignUp())),
                              child: Text("Sign Up",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Or",style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 90,
                              width: 55,
                              child: IconButton(
                                color: Colors.white,
                                icon: Image.asset('assets/glogo.png'),
                                iconSize: 80,
                                onPressed: (() => googleLogin()),
                              ),
                            ),
                            SizedBox(
                              width: 22,
                            ),
                            IconButton(
                              onPressed: () {
                               Get.to(()=>PhoneLogin());
                              },
                              icon: Icon(FontAwesomeIcons.phone),
                            ),
                          ],
                        ),
                      ),
                      // IconButton(onPressed: (()=>googleLogin()), icon: Icon(FontAwesomeIcons.google)),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
