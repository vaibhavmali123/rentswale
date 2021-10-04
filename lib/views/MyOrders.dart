import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/utils/Colors.dart';

class MyOrders extends StatefulWidget {
  MyOrdersState createState() => MyOrdersState();
}

class MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My orders',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: color.primaryColor,
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
