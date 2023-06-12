// ignore_for_file: prefer_final_fields, avoid_print, unused_catch_clause, empty_catches

import 'package:bytebot/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/colors_utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var isMailSent = false;
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(90),
                    child:
                        logoWidget("assets/images/forgot_password_image.png"),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Enter recovery E-mail",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                reusableTextField("Enter Email-ID", Icons.email_rounded, false,
                    _emailTextController),
                const SizedBox(height: 35),
                isMailSent == false
                    ? generalButton(context, () async {
                        try {
                          setState(() {
                            isMailSent = true;
                          });
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: _emailTextController.text)
                              .then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
                                ),
                                (route) => false);
                            getSnackbar(
                                "\nPassword reset mail sent successfully", "");
                          });
                        } on FirebaseAuthException catch (error) {
                          setState(() {
                            isMailSent = false;
                          });
                          getSnackbar("\n${error.message}", "");
                        }
                      }, "RESET PASSWORD")
                    : const CircularProgressIndicator(
                        color: Colors.black,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
