// ignore_for_file: prefer_const_constructors

import 'package:bytebot/login.dart';
import 'package:bytebot/register.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "login",
    routes: {
      "login": (context) => MyLogin(),
      "register": (context) => MyRegister(),
      "home": (context) => Home(),
    },
  ));
}
