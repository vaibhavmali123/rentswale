import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rentswale/bloc/ProfileBloc.dart';
import 'package:rentswale/bloc/UpdatePfofileBloc.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/models/profile_model.dart';
import 'package:rentswale/networking/ApiProvider.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreenState createState() => UpdateProfileScreenState();
}

class UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File fileProfile;

  TextEditingController nameEditingCtrl, emailEditingCtrl, addressEditingCtrl = TextEditingController();
  TextEditingController flatBuildingCtrl, landmarkCtrl, directionCtrl;
  bool showLoader = false;
  String uploadImageUrl;

  @override
  void initState() {
    super.initState();
    initControllers();
    initDetails();
  }

  @override
  Widget build(BuildContext context) {
    profileBloc.getProfile();
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
      body: Stack(
        children: [
          StreamBuilder(
              stream: profileBloc.profileStream,
              builder: (context, AsyncSnapshot<ProfileModel> snapshot) {
                if (snapshot.hasData) {
                  nameEditingCtrl.text = snapshot.data.profileList[0].name;
                  emailEditingCtrl.text = snapshot.data.profileList[0].emailAddress;
                  addressEditingCtrl.text = snapshot.data.profileList[0].address;
                  flatBuildingCtrl.text = snapshot.data.profileList[0].flatDetails;
                  landmarkCtrl.text = snapshot.data.profileList[0].landmark;
                  directionCtrl.text = snapshot.data.profileList[0].direction;

                  return SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 20),
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
                              child: snapshot.data.profileList[0].profileImage == null
                                  ? fileProfile == null
                                      ? Icon(
                                          Icons.supervised_user_circle_sharp,
                                          size: 100,
                                        )
                                      : ClipOval(
                                          child: Image.file(fileProfile),
                                        )
                                  : SizedBox(
                                      width: 160,
                                      height: 90,
                                      child: ClipOval(
                                        child: Image.network(snapshot.data.profileList[0].profileImage),
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            child: TextField(
                              controller: nameEditingCtrl,
                              decoration: InputDecoration(hintText: 'Name', border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            child: TextField(
                              controller: emailEditingCtrl,
                              decoration: InputDecoration(hintText: 'Email', border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            child: TextFormField(
                              controller: addressEditingCtrl,
                              decoration: InputDecoration(hintText: "Delivery address", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            child: TextFormField(
                              controller: flatBuildingCtrl,
                              decoration: InputDecoration(hintText: "Flat, building floor no", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            child: TextFormField(
                              controller: landmarkCtrl,
                              decoration: InputDecoration(hintText: "Landmark, area", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            child: TextFormField(
                              controller: directionCtrl,
                              decoration: InputDecoration(hintText: "Direction to reach", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2,
                            child: RaisedButton(
                              onPressed: () {
                                String name = nameEditingCtrl.text;
                                String email = emailEditingCtrl.text;
                                String address = addressEditingCtrl.text;
                                String flatBuilding = flatBuildingCtrl.text;
                                String landmark = landmarkCtrl.text;
                                String direction = directionCtrl.text;

                                print("IMAGE ${emailEditingCtrl.text}");
                                if (nameEditingCtrl.text.length > 0 && emailEditingCtrl.text.length > 0 && addressEditingCtrl.text.length > 0) {
                                  print("IMAGE ${emailEditingCtrl.text}");

                                  updateProfileBloc.updateProfile(name: name, email: email, address: address, profileImage: uploadImageUrl, floorNo: flatBuildingCtrl.text, landmark: landmarkCtrl.text, direction: directionCtrl.text);
                                  updateProfileBloc.updateProfileStream.listen((event) {
                                    print("EVENT ${event.statusCode}");
                                    if (event.statusCode == '200') {
                                      Utils.showMessage(message: 'Updated successfully', type: true);
                                    }
                                    setState(() {});
                                  });
                                } else {
                                  Utils.showMessage(message: 'All fields are compulsory');
                                }
                              },
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
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Utils.loader;
                } else {
                  return Utils.noData;
                }
              }),
          showLoader == true ? Utils.loader : Container()
        ],
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
                      setState(() {
                        showLoader = true;
                      });
                      File file = File(fileResult.files.single.path);
                      String dir = (await getApplicationDocumentsDirectory()).path;
                      String imageName = 'rentswale';
                      String extension = File(file.path).path.split('.').last;

                      String newPath = path.join(dir, imageName + '.' + extension);

                      File f = await File(fileResult.files.single.path);
                      File ff = await File(f.path).copy(newPath);

                      String fileName = ff.path.split('/').last;
                      Navigator.pop(context);
                      uploadFile(fileName: fileName, directory: dir);
                    } else {}
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Capture from camera"),
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.camera);

                    File file = File(pickedFile.path);
                    String dir = (await getApplicationDocumentsDirectory()).path;
                    String imageName = 'rentswale';
                    String extension = File(file.path).path.split('.').last;

                    String newPath = path.join(dir, imageName + '.' + extension);

                    File f = await File(pickedFile.path);
                    File ff = await File(f.path).copy(newPath);

                    String fileName = ff.path.split('/').last;
                    setState(() {
                      showLoader = true;
                    });
                    uploadFile(fileName: fileName, directory: dir);
                  },
                )
              ],
            ),
          ));
        });
  }

  Future<String> uploadFile({fileName, directory, String type}) async {
    setState(() {
      showLoader = true;
    });
    dynamic prog;
    Map<String, dynamic> map;
    final uploader = FlutterUploader();
    //String fileName = await file.path.split('/').last;

    final taskId = await uploader.enqueue(url: ApiProvider.baseUrlUpload, files: [FileItem(filename: fileName, savedDir: directory)], method: UploadMethod.POST, headers: {"apikey": "api_123456", "userkey": "userkey_123456"}, showNotification: true);
    final subscription = uploader.progress.listen((progress) {
      print("Progress ${progress}");
    });

    final subscription1 = uploader.result.listen((result) {
      print("Progress result ${result.response}");

      // return result.response;
    }, onError: (ex, stacktrace) {
      setState(() {});
    });
    subscription1.onData((data) async {
      map = await json.decode(data.response);
      print("PATH TYPE ${map['url']}");

      showLoader = false;
      setState(() {
        uploadImageUrl = map['url'];
        showLoader = false;
      });

      return map['url'];
    });
  }

  void initDetails() {
    nameEditingCtrl = TextEditingController();
    emailEditingCtrl = TextEditingController();
    addressEditingCtrl = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void initControllers() {
    flatBuildingCtrl = TextEditingController();
    landmarkCtrl = TextEditingController();
    directionCtrl = TextEditingController();
  }
}
