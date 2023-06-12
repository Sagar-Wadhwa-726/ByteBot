// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_print
import 'package:animate_do/animate_do.dart';
import 'package:bytebot/screens/feature_box.dart';
import 'package:bytebot/screens/openai_service.dart';
import 'package:bytebot/screens/pallete.dart';
import 'package:bytebot/screens/sign_in_screen.dart';
import 'package:bytebot/screens/tutorial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../reusable_widgets/reusable_widgets.dart';
import 'about.dart';
import 'contact.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;
  bool isSpeaking = false;
  final speechToText = SpeechToText();
  String lastWords = "";
  final OpenAIService openAIService = OpenAIService();
  final flutterTts = FlutterTts();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;
  String userEmail = FirebaseAuth.instance.currentUser!.email!;

  @override
  void initState() {
    super.initState();
    //initialise the plugin
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    //widget rebuilds
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  Future<void> systemSpeak(String content) async {
    isSpeaking = true;
    setState(() {});
    await flutterTts.speak(content);
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      //last words is what contains whatever user has said
      lastWords = result.recognizedWords;
      print(lastWords);
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(child: const Text("ByteBot")),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.lightBlue,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 0, 139, 203)),
                  currentAccountPictureSize: const Size.fromRadius(35.0),
                  accountName: Text(userEmail),
                  accountEmail: Text("ByteBot User"),
                  margin: EdgeInsets.zero,
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.png"),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              drawerTiles(context, Icons.accessibility_outlined, "Tutorial",
                  () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TutorialPage()));
              }),
              SizedBox(height: 10),
              drawerTiles(context, Icons.home, "Home", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
              SizedBox(height: 10),
              drawerTiles(context, Icons.person_3_rounded, "About ByteBot", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              }),
              SizedBox(height: 10),
              drawerTiles(context, Icons.phone_android, "Contact Us", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactPage()));
              }),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(10),
                width: 50,
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromARGB(255, 255, 255, 255))),
                  child: const Text(
                    "LOGOUT",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                          (route) => false);
                    });
                    getSnackbar("User Logged Out successfully",
                        "Thanks for using ByteBot");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Virtual assistant picture
            ZoomIn(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                          color: Pallete.assistantCircleColor,
                          shape: BoxShape.circle),
                    ),
                  ),
                  Container(
                    height: 123,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/virtualAssistant.png"))),
                  ),
                ],
              ),
            ),
            // Chat Bubble
            FadeInRight(
              child: Visibility(
                visible: generatedImageUrl == null,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin:
                      EdgeInsets.symmetric(horizontal: 40).copyWith(top: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: Pallete.borderColor),
                    borderRadius: BorderRadius.circular(20)
                        .copyWith(topLeft: Radius.zero),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      generatedContent == null
                          ? 'Hey there, what task can I do for you?'
                          : generatedContent!,
                      style: TextStyle(
                          color: Pallete.mainFontColor,
                          fontSize: generatedContent == null ? 25 : 18,
                          fontFamily: "Cera Pro"),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    generatedImageUrl!,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(
                              color: Colors.black, strokeWidth: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),
            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 22),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Here are a few features",
                    style: TextStyle(
                        fontFamily: "Cera Pro",
                        color: Pallete.mainFontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // Suggestions List
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(milliseconds: start),
                    child: const FeatureBox(
                      color: Pallete.firstSuggestionBoxColor,
                      headerText: "Chat GPT",
                      descText:
                          "A smarter way to stay organized and informed with Chat GPT",
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + delay),
                    child: const FeatureBox(
                      color: Pallete.secondSuggestionBoxColor,
                      headerText: "Dall-E",
                      descText:
                          "Get inspired and stay creative with your personal assistant powered by Dall-E",
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + 2 * delay),
                    child: const FeatureBox(
                      color: Pallete.thirdSuggestionBoxColor,
                      headerText: "Smart voice assistant",
                      descText:
                          "Get the best of both worlds with a voice assistant powered by Chat-GPT and Dall-E",
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            isSpeaking == true
                ? FadeInDown(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          flutterTts.stop();
                          isSpeaking = false;
                          setState(() {});
                        },
                        child: Text("Stop Speaking"),
                      ),
                    ),
                  )
                : SizedBox(height: 0)
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + 3 * delay),
        child: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final speech = await openAIService.isArtPromptAPI(lastWords);
              print(speech);
              if (speech.contains('https')) {
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          backgroundColor: Pallete.firstSuggestionBoxColor,
          child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
