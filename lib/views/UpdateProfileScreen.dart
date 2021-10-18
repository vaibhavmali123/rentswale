import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreenState createState() => UpdateProfileScreenState();
}

class UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File fileProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.primaryColor,
        title: Text(
          "Update Profile",
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                Database.getUserName() != null ? await showPicker(context: context) : Utils.showMessage(type: false, message: "Please login to upload profile pic");
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
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              child: TextField(
                decoration: InputDecoration(hintText: 'Mobile number', border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              child: TextField(
                decoration: InputDecoration(hintText: 'Email', border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              child: TextField(
                decoration: InputDecoration(hintText: 'Address', border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              child: TextField(
                decoration: InputDecoration(hintText: 'Name', border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              child: RaisedButton(
                onPressed: () {},
                color: color.primaryColor,
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            )
          ],
        ),
      ),
    );
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
                        //fileProfile = file;
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
                  },
                )
              ],
            ),
          ));
        });
  }
}
