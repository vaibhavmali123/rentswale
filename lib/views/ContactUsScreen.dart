import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/utils/Colors.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreenState createState() => ContactUsScreenState();
}

class ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact us',
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
