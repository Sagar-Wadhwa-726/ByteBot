// ignore_for_file: use_function_type_syntax_for_parameters, non_constant_identifier_names, avoid_types_as_parameter_names, sized_box_for_whitespace
import 'package:bytebot/screens/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// reusable widget for the logo image
Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
  );
}

// reusbale widget for the text fields
TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    textInputAction: TextInputAction.next,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white70),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
  );
}

//reusable widget for the signin/signup button
Container generalButton(BuildContext context, Function onTap, String title) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) return Colors.black26;
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}

//reusable widget for forgot password
Widget forgetPassword(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 45,
    alignment: Alignment.bottomRight,
    child: TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ResetPasswordScreen(),
            ));
      },
      child: const Text(
        "Forgot Password?",
        style: TextStyle(color: Colors.white70, fontSize: 17),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

//reusable widget for the GetX snackbar
SnackbarController getSnackbar(String heading, String subtitle) {
  return Get.snackbar(
    heading,
    subtitle,
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.black),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color.fromARGB(255, 197, 207, 224),
    borderRadius: 15,
    margin: const EdgeInsets.all(25),
    colorText: Colors.black,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    dismissDirection: DismissDirection.vertical,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

// reusable widget for list tiles in the drawer section
ListTile drawerTiles(BuildContext context, IconData prefixicon, String title,
    Function onSeleciton) {
  return ListTile(
    onTap: () => onSeleciton(),
    leading: Icon(
      prefixicon,
      color: Colors.white,
    ),
    title: Text(
      title,
      textScaleFactor: 1.2,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
