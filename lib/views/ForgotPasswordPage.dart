import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/bloc/ForgotPasswordBloc.dart';
import 'package:rentswale/bloc/OtpVerifyBloc.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/LoginPage.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController otpCtrl = TextEditingController();
  bool verifyOtp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.primaryColor,
        title: Text(
          "Forgot password",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: verifyOtp == false ? forgotPassword() : verifyOtpWidget(),
      )),
    );
  }

  forgotPassword() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 50,
          child: TextFormField(
            controller: userNameCtrl,
            decoration: InputDecoration(hintText: "Enter username", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width / 2,
          child: RaisedButton(
            onPressed: () {
              forgotPasswordBloc.forgotPassword(userName: userNameCtrl.text);
              forgotPasswordBloc.forgotPasswordStream.listen((event) {
                if (event.dataCode == '200') {
                  setState(() {
                    verifyOtp = true;
                  });
                  Utils.showMessage(message: "OTP sent on mail", type: true);
                }
              });
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: color.primaryColor,
            child: Text(
              'Forgot',
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  verifyOtpWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 50,
          child: TextFormField(
            controller: otpCtrl,
            decoration: InputDecoration(hintText: "Enter OTP", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width / 2,
          child: RaisedButton(
            onPressed: () {
              if (otpCtrl.text.length > 0) {
                otpVerifyBloc.verifyOtp(otp: otpCtrl.text, userName: userNameCtrl.text);
              } else {
                Utils.showMessage(message: "Please enter OTP");
              }
              otpVerifyBloc.verifyOtpStream.listen((event) {
                if (event.dataCode == '200') {
                  Utils.showMessage(message: "Password sent to email address");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                }
              });
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: color.primaryColor,
            child: Text(
              'Verify OTP',
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
