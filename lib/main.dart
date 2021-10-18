import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/views/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

int cartCount = 0;
bool isServiceAvailable = true;
String address;

void getCartDetails() async {
  var response = await Database.getCart();
  if (response != null) {
    List<dynamic> listCart = json.decode(response);
    cartCount = listCart.length;
  }
  print("CARTDATA ${response}");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rentswale',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
