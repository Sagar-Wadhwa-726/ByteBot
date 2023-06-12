// ignore_for_file: prefer_final_fields, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, nullable_type_in_catch_clause
import 'package:bytebot/screens/home_screen.dart';
import 'package:bytebot/screens/sign_up_screen.dart';
import 'package:bytebot/utils/colors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets/reusable_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var isVerified = false;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "ByteBot",
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
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.12, 20, 0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(90),
                    child: logoWidget("assets/images/logo1.jpg"),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Welcome to ByteBot",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                reusableTextField("Enter Email-ID", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(height: 30),
                reusableTextField("Enter Password", Icons.lock, true,
                    _passwordTextController),
                const SizedBox(height: 15),
                forgetPassword(context),
                const SizedBox(height: 20),
                isVerified == false
                    ? generalButton(context, () async {
                        try {
                          setState(() {
                            isVerified = true;
                          });
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text)
                              .then((value) {
                            getSnackbar(
                                "User Logged In Successfully", "Welcome User");
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          });
                        } on FirebaseAuthException catch (error) {
                          setState(() {
                            isVerified = false;
                          });
                          getSnackbar("\n${error.message}", "");
                        }
                      }, "LOG IN")
                    : CircularProgressIndicator(
                        color: Colors.black,
                      ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ",
                        style: TextStyle(color: Colors.white70, fontSize: 17)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
