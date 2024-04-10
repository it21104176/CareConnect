import 'dart:async';
import 'package:careconnect/HomePage.dart';
import 'package:flutter/material.dart';

import 'BottomNavBar.dart';

class WelcomeScreen extends StatelessWidget {
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
                child: Stack(
                  children: [
                    Container(
                      width: 400.0, // Increased image size
                      height: 400.0, // Increased image size
                      child: ClipRRect(
                        child: Image.asset(
                          "assets/careconnect_logo.png",
                          fit: BoxFit.fitWidth, // Fit the image inside the container
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Welcome to",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20), // Added space between welcome text and "Care Connect" text
              // "Care Connect" Text
              Text(
                "Care Connect",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30), // Added space between "Care Connect" text and description text
              // Description Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Where we help you to take care of yourself",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 40), // Added space between description text and arrow button
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0), // Add border around the IconButton
                  borderRadius: BorderRadius.circular(50.0), // Rounded border
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
                  },
                  color: Colors.black,
                  iconSize: 40,
                ),
              ),
              SizedBox(height: 10), // Added space between arrow button and "Let's Start" text
              // "Let's Start" Text
              Text(
                "Let's Start",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}