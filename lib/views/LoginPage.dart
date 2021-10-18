import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/bloc/LoginBloc.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/models/LoginModel.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/CreateAccountScreen.dart';
import 'package:rentswale/views/Dashboard.dart';
import 'package:rentswale/views/PlaceOrderScreen.dart';

class LoginPage extends StatefulWidget {
  List<dynamic> listProducts = [];
  String couponAmount;

  LoginPage({this.listProducts, this.couponAmount});

  LoginPageState createState() => LoginPageState(listProducts: listProducts, couponAmount: couponAmount);
}

class LoginPageState extends State<LoginPage> {
  TextEditingController userNameCtrl, passCtrl;
  bool showLoader = false;
  String couponAmount;
  List<dynamic> listProducts = [];

  LoginPageState({this.listProducts, this.couponAmount});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameCtrl = TextEditingController();
    passCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                height: MediaQuery.of(context).size.height / 4.5,
              ),
            ),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: userNameCtrl,
                decoration: InputDecoration(hintText: "Username", hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: passCtrl,
                obscureText: true,
                decoration: InputDecoration(hintText: "Password", hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              child: StreamBuilder(
                stream: loginBloc.loginStream,
                builder: (context, AsyncSnapshot<LoginModel> snapshot) {
                  return RaisedButton(
                    onPressed: () {
                      if (userNameCtrl.text != "" && passCtrl.text != "") {
                        login();
                      } else {
                        Utils.showMessage(message: "Please enter username & password", type: false);
                      }
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    color: color.primaryColor,
                    child: showLoader == false
                        ? Text(
                            'Login',
                            style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
                          )
                        : Center(
                            child: Container(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 14,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateAccountScreen();
                }));
              },
              child: RichText(
                text: TextSpan(
                    text: 'Dont have an account?  ',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black87.withOpacity(0.9),
                    ),
                    children: <TextSpan>[TextSpan(text: 'Signup', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.blueAccent))]),
              ),
            )
          ],
        ),
      )),
    );
  }

  void login() {
    setState(() {
      showLoader = true;
    });
    loginBloc.login(username: userNameCtrl.text, password: passCtrl.text);

    loginBloc.loginStream.listen((event) {
      print("SNSNSNSSS ${event.statusCode}");
      if (event.statusCode == "200") {
        Database.initDatabase();
        Database.setName(event.result.name);
        print("SNSNSNSSS ${Database.getName()}");
        Database.setUserName(event.result.username);
        Database.setEmail(event.result.emailAddress);
        Database.setUserId(event.result.id);
        setState(() {
          showLoader = false;
        });
        if (listProducts != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PlaceOrderScreen(
              listProducts: listProducts,
              couponAmount: couponAmount,
            );
          }));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return Dashboard();
          }));
        }
      } else {
        setState(() {
          showLoader = false;
        });
        Utils.showMessage(message: "Invalid username or password", type: false);
      }
    });
  }
}
