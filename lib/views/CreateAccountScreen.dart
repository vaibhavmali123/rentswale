import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/bloc/CreateAccountBloc.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/constants.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/Dashboard.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  List<String> listType = [
    'Individual',
    'Company',
  ];

  bool showLoader = false;
  TextEditingController nameCtrl, emailCtrl, mobileCtrl, passwordCtrl;
  var selectedType;

  @override
  void initState() {
    // TODO: implement initState
    nameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    mobileCtrl = TextEditingController();
    passwordCtrl = TextEditingController();

    super.initState();
    initControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.primaryColor,
        title: Text('Create account'),
      ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 50,
              child: Container(
                height: 54,
                decoration: BoxDecoration(),
                width: MediaQuery.of(context).size.width / 1.1,
                child: Center(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                        buttonTheme: ButtonTheme.of(context).copyWith(
                          alignedDropdown: true, //If false (the default), then the dropdown's menu will be wider than its button.
                        )),
                    child: DropdownButton<String>(
                      underline: Container(
                        height: 1.0,
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))),
                      ),
                      isExpanded: true,
                      focusColor: Colors.white,
                      value: selectedType,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: listType.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select customer type",
                        style: TextStyle(fontSize: 14, color: Colors.black87.withOpacity(0.7), fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          selectedType = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: nameCtrl,
                decoration: InputDecoration(hintText: "Enter name", hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: emailCtrl,
                decoration: InputDecoration(hintText: "Enter email address", hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: mobileCtrl,
                decoration: InputDecoration(hintText: "Enter mobile number", hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter password", hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              child: RaisedButton(
                  onPressed: () {
                    if (nameCtrl.value.text == "" && emailCtrl.text == "" && mobileCtrl.text == "" && passwordCtrl.text == "" && selectedType == null) {
                      Utils.showMessage(message: 'All Fields are compulsoory', type: false);
                    } else {
                      if (RegExp(constants.emailRegExp).hasMatch(emailCtrl.text)) {
                        setState(() {
                          showLoader = true;
                        });
                        navigate();
                        print("DDDDDDDDDD ${nameCtrl.text} ${emailCtrl.text} ${mobileCtrl.text} ${passwordCtrl.text}");
                      } else {
                        Utils.showMessage(message: 'Please enter valid email', type: false);
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  color: color.primaryColor,
                  child: Text(
                    'Create account',
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
                  ))
              /*RaisedButton(
                  onPressed: () {
                    if (nameCtrl.value.text == "" && emailCtrl.text == "" && mobileCtrl.text == "" && passwordCtrl.text == "" && selectedType == null) {
                      Utils.showMessage(message: 'All Fields are compulsoory', type: false);
                    } else {
                      if (RegExp(constants.emailRegExp).hasMatch(emailCtrl.text)) {
                        setState(() {
                          showLoader = true;
                        });
                        print("DDDDDDDDDD ${nameCtrl.text} ${emailCtrl.text} ${mobileCtrl.text} ${passwordCtrl.text}");
                        createAccountBloc.createAccount(name: nameCtrl.text, email: emailCtrl.text, mobileNumber: mobileCtrl.text, password: passwordCtrl.text, type: selectedType);
                      } else {
                        Utils.showMessage(message: 'Please enter valid email', type: false);
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  color: color.primaryColor,
                  child: StreamBuilder(
                      stream: createAccountBloc.createAccountStream,
                      builder: (context, AsyncSnapshot<CreateAccountModel> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.statusCode == '200') {
                            //  Utils.showMessage(message: snapshot.data.message, type: true);
                            navigate(snapshot);
                          } else if (snapshot.data.statusCode == '300') {
                            Utils.showMessage(message: snapshot.data.message, type: false);
                          }
                        } else if (snapshot.connectionState == ConnectionState.waiting && showLoader == true) {
                          return Utils.loader;
                        } else {
                          return Text(
                            'Create account',
                            style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
                          );
                        }
                        showLoader == false
                            ? Text(
                                'Create account',
                                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
                              )
                            : Utils.loader;
                      }))*/
              ,
            ),
          ],
        ),
      )),
    );
  }

  void initControllers() {}

  void navigate() {
    Database.initDatabase();
    /*Database.setName(snapshot.data.result.name);
    Database.setUserName(snapshot.data.result.username);
    Database.setEmail(snapshot.data.result.emailAddress);
    Database.setEmail(snapshot.data.result.id);*/
    createAccountBloc.createAccount(name: nameCtrl.text, email: emailCtrl.text, mobileNumber: mobileCtrl.text, password: passwordCtrl.text, type: selectedType);

    createAccountBloc.createAccountStream.listen((event) {
      if (event.statusCode == '200') {
        Database.setName(event.result.name);
        Database.setUserName(event.result.username);
        Database.setEmail(event.result.emailAddress);
        Database.setUserId(event.result.id);
        setState(() {
          showLoader = false;
        });
        Timer(Duration(seconds: 1), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return Dashboard();
          }));
        });
      }
    });
  }
}
