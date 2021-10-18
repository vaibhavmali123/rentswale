import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/views/Dashboard.dart';

class ThankYouPage extends StatefulWidget {
  int total;
  String flatNo, landmark, direction, address, date;

  ThankYouPage({this.total, this.flatNo, this.landmark, this.direction, this.address, this.date});

  ThankYouPageState createState() => ThankYouPageState(total: total, direction: direction, flatNo: flatNo, landmark: landmark, address: address, date: date);
}

class ThankYouPageState extends State<ThankYouPage> {
  bool showLottie = true;

  int total;
  String flatNo, landmark, direction, address, date;

  ThankYouPageState({this.total, this.flatNo, this.landmark, this.direction, this.address, this.date});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database.initDatabase();
    Timer(Duration(seconds: 4), () {
      setState(() {
        showLottie = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: showLottie != true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: color.primaryColor.withOpacity(0.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Order Placed",
                                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Total amount: " + total.toString(),
                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 8,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery by: ' + date != null ? date : "",
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width,
                              height: 0.6,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              Database.getName(),
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              address != null ? address : "",
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                            ),
                            Text(
                              flatNo != null ? flatNo : "",
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                            ),
                            Text(
                              landmark != null ? landmark : "",
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                            ),
                            Text(
                              direction != null ? direction : "",
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                            ),
                            Text(
                              "Maharashtra",
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.6,
                                  height: 50,
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                        return Dashboard();
                                      }));
                                    },
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    color: color.primaryColor,
                                    child: Text(
                                      "Continue with rentswale",
                                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              )
            : Center(
                child: Lottie.asset('assets/images/thank_you.json'),
              ),
      )),
    );
  }
}
