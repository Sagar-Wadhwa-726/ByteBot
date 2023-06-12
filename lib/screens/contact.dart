// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, deprecated_member_use
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  final int start = 100;
  final int delay = 100;

  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(children: [
            Image(
              image: AssetImage("assets/images/logo1.jpg"),
              height: 250,
              width: 250,
            ),
            FadeInLeft(
              delay: Duration(milliseconds: start),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                    textAlign: TextAlign.justify,
                    textScaleFactor: 1.4,
                    "Got any query? Feel free to contact us on the phone number given below or write an email to us.\n\n"),
              ),
            ),
            FadeInRight(
              delay: Duration(milliseconds: delay + start),
              child: ListTile(
                onTap: () {
                  launchDialer('+91-9999999999');
                },
                leading: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
                title: Text(
                  "+91-9999999999",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            FadeInRight(
              delay: Duration(milliseconds: 2 * delay + start),
              child: ListTile(
                onTap: () {
                  launcEmailService("support@agripharm.com");
                },
                leading: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                title: Text(
                  "support@bytebot.com",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// function to open dialer on pressing the contact phone
void launchDialer(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    ScaffoldMessenger(
        child: SnackBar(content: Text("Error opening calling application")));
  }
}

// function to open the email service application on pressing the contact email
void launcEmailService(String email) async {
  String email = Uri.encodeComponent("support@agripharm.com");
  Uri mailer = Uri.parse("mailto:$email");
  if (await launchUrl(mailer)) {
  } else {
    ScaffoldMessenger(
        child: SnackBar(content: Text("Error opening email application")));
  }
}
