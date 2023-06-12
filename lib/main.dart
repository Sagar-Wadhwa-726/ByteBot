// ignore_for_file: prefer_const_constructors
import 'package:bytebot/screens/home_screen.dart';
import 'package:bytebot/screens/pallete.dart';
import 'package:bytebot/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  //Flutter needs to call native code before calling runApp, makes sure that you have an instance of the WidgetsBinding, which is required to use platform channels to call the native code. Basically this ensures that firebase is initialised before we run our application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkIfLogin() {
    // on auth state change, a listener listens to the event
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  // before running the application call the init state method which will call the checkIfLogin method
  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ByteBot",
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(scaffoldBackgroundColor: Pallete.whiteColor),
      home: isLogin ? HomeScreen() : SignInScreen(),
    );
  }
}
