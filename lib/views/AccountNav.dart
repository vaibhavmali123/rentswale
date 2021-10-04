import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/utils.dart';
import 'package:rentswale/views/Dashboard.dart';
import 'package:rentswale/views/KycPage.dart';
import 'package:rentswale/views/LoginPage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'MyOrders.dart';

class AccountNav extends StatefulWidget {
  AccountNavState createState() => AccountNavState();
}

class AccountNavState extends State<AccountNav> {
  List<dynamic> listMenu = [
    {'title': 'Login/Signup', 'icon': Icons.login},
    {'title': 'KYC', 'icon': Icons.fingerprint_sharp},
    {'title': 'Offers & Promotions', 'icon': Icons.label_sharp},
    {'title': 'My orders', 'icon': Icons.fingerprint_sharp},
    {'title': 'Contact Us', 'icon': Icons.contact_phone},
    {'title': 'Read More', 'icon': Icons.chrome_reader_mode_outlined},
    {'title': 'Logout', 'icon': Icons.logout},
  ];

  String address;
  File fileProfile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database.initDatabase();
    Database.getAddres().then((value) {
      setState(() {
        address = value;
      });
      print("ADDRESS ${value.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0)), border: Border.all(width: 0.4, color: Colors.black)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await showPicker(context: context);
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          child: fileProfile == null
                              ? Icon(
                                  Icons.supervised_user_circle_sharp,
                                  size: 100,
                                )
                              : ClipOval(
                                  child: Image.file(fileProfile),
                                ),
                        ),
                      ),
                      Text(
                        Database.getUserName() != null ? Database.getUserName() : "User name here",
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, height: 1.7, color: Colors.black87),
                      ),
                      Text(
                        address == null ? "Pune" : address,
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, height: 1.7, color: Colors.black87),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  color: Colors.grey.shade100,
                  child: ListView.builder(
                      itemCount: listMenu.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 55,
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: ListTile(
                                  onTap: () {
                                    navigate(index);
                                  },
                                  title: Text(
                                    listMenu[index]["title"],
                                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
                                  ),
                                  leading: Icon(listMenu[index]['icon']),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          )),
    );
  }

  Future<void> showLogoutDialog() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              'Do you want to logout',
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  onPressed: () {
                    Database.initDatabase();
                    Database.logout();
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return Dashboard();
                    }));
                  },
                  child: Text(
                    'Yes',
                    style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w700),
                  )),
              CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'No',
                    style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w700),
                  )),
            ],
          );
        });
  }

  void navigate(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return KycPage();
        }));
        break;
      case 4:
        contactusBottomSheet(context: context);
        break;

      case 6:
        showLogoutDialog();
        break;

      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MyOrders();
        }));
        break;
    }
  }

  void contactusBottomSheet({BuildContext context}) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            height: MediaQuery.of(context).size.height / 3,
            child: Wrap(
              children: [
                Container(
                  height: 55,
                  color: color.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Contact Us',
                          style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          makeCall();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: MediaQuery.of(context).size.height / 8,
                          decoration: BoxDecoration(color: Colors.grey.shade300),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_ic_call_outlined,
                                size: 30,
                              ),
                              Text(
                                'Call Us',
                                style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          mailTo();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: MediaQuery.of(context).size.height / 8,
                          decoration: BoxDecoration(color: Colors.grey.shade300),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: 30,
                              ),
                              Text(
                                'e-mail',
                                style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
        });
  }

  void makeCall() async {
    launch("tel://9890498824");
  }

  void mailTo() async {
    await launch("mailto://9890498824");
  }

  showPicker({String type, BuildContext context}) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.file_copy_sharp),
                  title: Text("Pick from Gallery"),
                  onTap: () async {
                    FilePickerResult fileResult = await FilePicker.platform.pickFiles();
                    if (fileResult != null) {
                      File file = File(fileResult.files.single.path);
                      setState(() {
                        fileProfile = file;
                      });
                    } else {}
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Capture from camera"),
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      fileProfile = File(pickedFile.path);
                      print("PROFILE ${fileProfile}");
                      Utils.showMessage(message: fileProfile.toString());
                    });
                  },
                )
              ],
            ),
          ));
        });
  }
}
