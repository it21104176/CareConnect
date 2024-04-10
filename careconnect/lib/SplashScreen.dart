import 'dart:async';
import 'package:flutter/material.dart';

import 'WelcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background Image
          Image.asset(
            "assets/careconnect_BG.png",
            fit: BoxFit.cover,
          ),
          // Logo and Text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Your Logo with White Border
              Padding(
                padding: EdgeInsets.all(0.0), // Increased padding
                child: Container(
                  width: 400.0, // Increased image size
                  height: 400.0, // Increased image size
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200.0), // Adjust to fit inside the border
                    child: Image.asset(
                      "assets/careconnect_logo.png",
                      fit: BoxFit.fitWidth, // Fit the image inside the container
                    ),
                  ),
                ),
              ),
              // Your Texts Positioned
              Positioned(
                bottom: 100, // Adjust position as per your requirement
                left: 0,
                right: 0,
                child: Text(
                  "Care",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comic Sans MS', // Change font family
                    color: Colors.black, // Change text color
                  ),
                ),
              ),
              Positioned(
                bottom: 60, // Adjust position as per your requirement
                left: 0,
                right: 0,
                child: Text(
                  "Connect",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comic Sans MS', // Change font family
                    color: Colors.black, // Change text color
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
