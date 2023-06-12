// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About ByteBot"),
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
                  "• Welcome to the world of ByteBot, where conversations come to life!\n\n•ByteBot is an advanced AI-powered chatting application designed to provide you with a seamless and intuitive virtual assistant experience. Equipped with state-of-the-art technology and trained on vast amounts of data, ByteBot is capable of understanding and responding to a wide range of queries, making it your go-to companion for all your needs.\n\n•At ByteBot, we believe that communication should be effortless, efficient, and enjoyable. Whether you're seeking information, looking for assistance, or simply engaging in casual conversation, ByteBot is here to provide you with timely and accurate responses. Our goal is to make your interaction with technology as natural as possible, so you can focus on what truly matters to you. \n\n• One of the remarkable features of ByteBot is its ability to generate images, much like Dall-e, a cutting-edge AI model developed by OpenAI. Powered by deep learning algorithms and an extensive dataset, ByteBot can create unique and imaginative visuals that are tailored to your specifications. Whether you need a customized illustration for a project, a conceptual image for a blog post, or simply want to explore the creative possibilities, ByteBot's image generation capabilities are sure to impress. ",
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


