// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ByteBot Tutorial"),
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
            Padding(
              padding: EdgeInsets.all(20),
              child: ZoomIn(
                child: Text(
                  "• Welcome to ByteBot Tutorial\n\n• This is an AI-powered application where you can get your queries resolved\n\n• To get started, swipe right nad see the drawer options\n\n• Tutorial page will bring you to the tutorial page\n\n• Clicking on the home page will navigate you back to the main home screen\n\n• Click on About ByteBot you can know more about our service\n\n• Clicking on the contact us button you can contact us write an email to us if you have any queries\n\n• For using the application, press the mic button on the bottom right corner of your device\n\n• After the mic has been initialised, speka in your query\n\n• The query can be either a simple question or you can also ask the chatbot to generate some kind of a image\n\n • To logout, simply click the logout button present on the slider",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 19, height: 1.4),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
