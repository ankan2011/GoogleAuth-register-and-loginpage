import 'package:blog_app/Check_fun/wrapper.dart';
import 'package:blog_app/EmailAuth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  void initState() {
    // TODO: implement initState
    sendverifylink();
    super.initState();
  }

  sendverifylink() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification().then((value) =>
    {
      Get.snackbar('link Send!', 'Check your register email id',
          margin: EdgeInsets.all(30), snackPosition: SnackPosition.BOTTOM)
    });
  }

  reload() async {
    await FirebaseAuth.instance.currentUser!
        .reload()
        .then((value) => {Get.offAll(WrapperState())});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.to(SignUp);
          },
        ),
        backgroundColor: Colors.blue,
        title: Text("Verification Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(28.0),
        child: Center(
            child: Text("Open your mail and click the link provided "
                "to verify email & reload this page")
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (() => reload()),
        child: Icon(Icons.restart_alt_outlined),
      ),
    );
  }
}
