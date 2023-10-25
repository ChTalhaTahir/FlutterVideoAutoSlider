import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

Widget richText(){
  return RichText(
    text: TextSpan(
      children:  [
        const TextSpan(
          text: "By signing up for Hinge, you agree to our ",
        ),

        TextSpan(
          text: "Terms of Services ",
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline
          ),
          recognizer: new TapGestureRecognizer()
            ..onTap = () => print("Terms and Services"),
        ),

        const TextSpan(text: "Learn how we process your data in our "),

        TextSpan(
          text: "Privacy Policy ",
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline
          ),
          recognizer: new TapGestureRecognizer()
            ..onTap = () => print("Privacy Statement"),
        ),

        const TextSpan(text: "and "),

        TextSpan(
          text: "Cookies Policy",
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          recognizer: new TapGestureRecognizer()
            ..onTap = () => print("Cookies Statement"),
        ),

        const TextSpan(text: "."),

      ],
    ),
  );
}