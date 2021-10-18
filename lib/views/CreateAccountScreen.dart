import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentswale/bloc/CreateAccountBloc.dart';
import 'package:rentswale/models/CreateAccountModel.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/LoginPage.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  List<String> listType = [
    'Individual',
    'Company',
  ];
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
                      print("DDDDDDDDDD ${nameCtrl.text} ${emailCtrl.text} ${mobileCtrl.text} ${passwordCtrl.text}");
                      createAccountBloc.createAccount(name: nameCtrl.text, email: emailCtrl.text, mobileNumber: mobileCtrl.text, password: passwordCtrl.text, type: selectedType);
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  color: color.primaryColor,
                  child: StreamBuilder(
                      stream: createAccountBloc.createAccountStream,
                      builder: (context, AsyncSnapshot<CreateAccountModel> snapshot) {
                        if (snapshot.hasData) {
                          //  Utils.showMessage(message: snapshot.data.message, type: true);
                          navigate();
                        }
                        return Text(
                          'Create account',
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
                        );
                      })),
            ),
          ],
        ),
      )),
    );
  }

  void initControllers() {}

  void navigate() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }
}
