import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentswale/views/Dashboard.dart';

class SplashScreen extends StatefulWidget {
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      'assets/images/rentswale icon.jpeg',
                      scale: 0.4,
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 2.6,
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
/*
                  Text(
                    "Everything on rent",
                    style: TextStyle(fontSize: 18, color: Colors.black87.withOpacity(0.7), fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                  ),
*/
                ],
              )))),
    );
  }
}
