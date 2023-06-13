// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison, sized_box_for_whitespace, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class AltTextScreen extends StatefulWidget {
  const AltTextScreen({super.key});

  @override
  State<AltTextScreen> createState() => _AltTextScreenState();
}

class _AltTextScreenState extends State<AltTextScreen> {
  bool imageLabelChecking = false;
  File? selectedImage;
  StringBuffer sb = StringBuffer();
  String base64Image = "";

  void getImageLabel(File image) async {
    setState(() {
      imageLabelChecking = true;
      sb.clear();
    });
    final inputImage = InputImage.fromFilePath(image.path);
    ImageLabeler imageLabeler =
        ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.7));

    //this method returns a list of image lables
    List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    for (ImageLabel imgLabel in labels) {
      String lbltext = imgLabel.label;
      double confidence = imgLabel.confidence;
      sb.write(lbltext);
      sb.write(": ");
      sb.write((confidence * 100).toStringAsFixed(0));
      sb.write("%\n");
    }
    imageLabeler.close();
    imageLabelChecking = false;
    setState(() {});
  }

  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }
  }

  // Object of ImagePicker class
  ImagePicker image = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Recognizer"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 350,
              width: 380,
              child: selectedImage == null
                  ? Icon(Icons.image, size: 80)
                  : Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      selectedImage == null;
                      setState(() {});
                      chooseImage("Gallery");
                    },
                    style: ElevatedButton.styleFrom(fixedSize: Size(145, 50)),
                    child: Text(
                      "Upload Image",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      selectedImage == null;
                      setState(() {});
                      chooseImage("camera");
                    },
                    style: ElevatedButton.styleFrom(fixedSize: Size(145, 50)),
                    child: Text(
                      "Click Photo",
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            selectedImage == null
                ? SizedBox(height: 0)
                : ((imageLabelChecking == true))
                    ? CircularProgressIndicator(
                        color: Colors.black,
                      )
                    : ElevatedButton(
                        onPressed: () {
                          imageLabelChecking = true;
                          setState(() {});
                          getImageLabel(selectedImage!);
                        },
                        style:
                            ElevatedButton.styleFrom(fixedSize: Size(150, 50)),
                        child: Text(
                          "Analyze Image",
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
            SizedBox(height: 20),
            Text(
              sb.toString(),
              style: TextStyle(
                fontFamily: "Cera Pro",
                fontSize: 17,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
