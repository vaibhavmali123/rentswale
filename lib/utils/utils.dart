import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class Utils {
  static var inputBorder = OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54));

  static Widget loader = Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
  static Widget noData = Container(
    child: Center(
      child: Text(
        'No data',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ),
  );

  static Widget animatedLoader = Container(
    child: Center(
      child: Lottie.asset("assets/lotties/loader.json"),
    ),
  );
  static showMessage({String message, bool type}) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: type == false ? Colors.red : Colors.green, textColor: Colors.white, fontSize: 16.0);
  }
}
