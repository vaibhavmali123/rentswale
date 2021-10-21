import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rentswale/bloc/KycBloc.dart';
import 'package:rentswale/bloc/KycCheckBloc.dart';
import 'package:rentswale/database/Database.dart';
import 'package:rentswale/models/kyc_check_model.dart';
import 'package:rentswale/networking/ApiProvider.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/constants.dart';
import 'package:rentswale/utils/utils.dart';

class KycPage extends StatefulWidget {
  KycPageState createState() => KycPageState();
}

class KycPageState extends State<KycPage> {
  String aadharCardPath, licensePath, addressProofPath;

  TextEditingController aadharController, licenseController;
  String aadharCard, license, addressProof;
  bool showLoader;

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  Widget build(BuildContext context) {
    kycCheckBloc.checkKyc();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: color.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: StreamBuilder(
              stream: kycCheckBloc.kycCheckStream,
              builder: (context, AsyncSnapshot<KycCheckModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.statusCode == "200") {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text("KYC Complete"),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              'Please complete your KYC first',
                              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.6)),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                              flex: 22,
                              child: Column(
                                children: [
                                  getAdhaarCardField(),
                                  getCurrentAddressField(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  getLisceneField(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 2,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          print("DETAILS aadharCard ${aadharCard}");
                                          print("DETAILS license ${license}");
                                          print("DETAILS addressProof ${addressProof}");

                                          Database.initDatabase();

                                          if (aadharController.text.length > 0 && licenseController.text.length > 0 && aadharCard != null && addressProof != null && license != null) {
                                            if (Database.getUserName() != null) {
                                              kycBloc.updateKyc(aadharCard: aadharCard, aadharNo: aadharController.text, license: license, addressProof: addressProof, licenseNo: licenseController.text);

                                              kycBloc.kycStream.listen((event) {
                                                print("DDDDDDDD ${event}");
                                                if (event.statusCode == "200") {
                                                  Utils.showMessage(message: "KYC Updated successfully", type: true);
                                                  Navigator.pop(context);
                                                } else {
                                                  Utils.showMessage(message: "Update Failed", type: false);
                                                }
                                              });
                                            } else {
                                              Utils.showMessage(message: "Please login first", type: false);
                                            }
                                          } else {
                                            Utils.showMessage(message: "All fields are compulsory", type: false);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(primary: color.primaryColor, textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white)),
                                        child: Text('Submit')),
                                  )
                                ],
                              ))
                        ],
                      ),
                    );
                  }
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Utils.loader;
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            'Please complete your KYC first',
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.6)),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 22,
                            child: Column(
                              children: [
                                getAdhaarCardField(),
                                getCurrentAddressField(),
                                SizedBox(
                                  height: 10,
                                ),
                                getLisceneField(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        print("DETAILS aadharCard ${aadharCard}");
                                        print("DETAILS license ${license}");
                                        print("DETAILS addressProof ${addressProof}");

                                        Database.initDatabase();

                                        if (aadharController.text.length > 0 && licenseController.text.length > 0 && aadharCard != null && addressProof != null && license != null) {
                                          if (Database.getUserName() != null) {
                                            kycBloc.updateKyc(aadharCard: aadharCard, aadharNo: aadharController.text, license: license, addressProof: addressProof, licenseNo: licenseController.text);

                                            kycBloc.kycStream.listen((event) {
                                              print("DDDDDDDD ${event}");
                                              if (event.statusCode == "200") {
                                                Utils.showMessage(message: "KYC Updated successfully", type: true);
                                                Navigator.pop(context);
                                              } else {
                                                Utils.showMessage(message: "Update Failed", type: false);
                                              }
                                            });
                                          } else {
                                            Utils.showMessage(message: "Please login first", type: false);
                                          }
                                        } else {
                                          Utils.showMessage(message: "All fields are compulsory", type: false);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(primary: color.primaryColor, textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white)),
                                      child: Text('Submit')),
                                )
                              ],
                            ))
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          showLoader == true ? Utils.loader : Container()
        ],
      ),
    );
  }

  void _showCategoryPicker(String addressProof, BuildContext context) async {
    print("dsddsd");

    if (showLoader != true) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
                child: Container(
              child: Wrap(
                children: [
                  ListTile(
                    leading: Icon(Icons.iso),
                    title: Text("Electricity bill"),
                    onTap: () async {
                      Navigator.pop(context);

                      showPicker(type: constants.addressProof, context: context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.iso),
                    title: Text("Company or College ID"),
                    onTap: () {
                      Navigator.pop(context);
                      showPicker(type: constants.addressProof, context: context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.iso),
                    title: Text("Rent agreement"),
                    onTap: () {
                      Navigator.pop(context);
                      showPicker(type: constants.addressProof, context: context);
                    },
                  )
                ],
              ),
            ));
          });
    }
  }

  getAdhaarCardField() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.1,
          child: TextFormField(
            controller: aadharController,
            decoration: InputDecoration(hintText: 'Aadhar number', hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87.withOpacity(0.6)), border: Utils.inputBorder),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async {
            showPicker(type: constants.adhaarCard, context: context);
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 1.1,
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), border: Border.all(width: 1, color: Colors.black54)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  aadharCardPath != "" ? 'Adhaar Card' : aadharCardPath,
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.6)),
                ),
                Icon(Icons.iso)
              ],
            ),
          ),
        )
      ],
    );
  }

  getCurrentAddressField() {
    return GestureDetector(
      onTap: () async {
        await _showCategoryPicker(constants.addressProof, context);
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.1,
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), border: Border.all(width: 1, color: Colors.black54)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Current address proof',
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.6)),
            ),
            Icon(Icons.iso)
          ],
        ),
      ),
    );
  }

  getLisceneField() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.1,
          child: TextFormField(
            controller: licenseController,
            decoration: InputDecoration(hintText: 'Driving license number', hintStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87.withOpacity(0.6)), border: Utils.inputBorder),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await showPicker(type: constants.drivingLiscene, context: context);
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 1.1,
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), border: Border.all(width: 1, color: Colors.black54)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Driving license',
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.6)),
                ),
                Icon(Icons.iso)
              ],
            ),
          ),
        )
      ],
    );
  }

  //this function is for show file picker
  showPicker({String type, BuildContext context}) async {
    if (showLoader != true) {
      await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
                child: Container(
              child: Wrap(
                children: [
                  ListTile(
                    leading: Icon(Icons.file_copy_sharp),
                    title: Text("Pick from files"),
                    onTap: () async {
                      FilePickerResult fileResult = await FilePicker.platform.pickFiles();
                      if (fileResult != null) {
                        File file = File(fileResult.files.single.path);
                        String dir = (await getApplicationDocumentsDirectory()).path;
                        String imageName = 'rentswale';
                        String extension = File(file.path).path.split('.').last;

                        String newPath = path.join(dir, imageName + '.' + extension);

                        File f = await File(fileResult.files.single.path);
                        File ff = await File(f.path).copy(newPath);

                        String fileName = ff.path.split('/').last;

                        switch (type) {
                          case 'adhaarCard':
                            setState(() {
                              aadharCardPath = fileResult.files.single.path.toString();
                            });
                            break;
                          case 'drivingLiscene':
                            setState(() {
                              licensePath = fileResult.files.single.path.toString();
                            });
                            break;
                          case 'AddressProof':
                            setState(() {
                              addressProofPath = fileResult.files.single.path.toString();
                            });
                            break;
                        }

                        uploadFile(fileName: fileName, directory: dir, type: type);

                        Navigator.pop(context);
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
                      switch (type) {
                        case 'adhaarCard':
                          setState(() {
                            aadharCardPath = pickedFile.path.toString();
                          });
                          break;
                        case 'drivingLiscene':
                          setState(() {
                            licensePath = pickedFile.path.toString();
                          });
                          break;
                        case 'AddressProof':
                          setState(() {
                            addressProofPath = pickedFile.path.toString();
                          });
                          break;
                      }

                      uploadFile(fileName: fileName, directory: dir, type: type);
                    },
                  )
                ],
              ),
            ));
          });
    }
  }

  void initControllers() {
    aadharController = TextEditingController();
    licenseController = TextEditingController();
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
      print("PATH TYPE ${map['url']} ${type}");

      showLoader = false;
      setState(() {
        switch (type) {
          case 'adhaarCard':
            print("PATH data ${map['url']}");
            aadharCard = map['url'];
            print("DETAILS aadharCard ${aadharCard}");
            break;
          case 'drivingLiscene':
            license = map['url'];
            print("DETAILS license ${license}");
            print("DETAILS addressProof ${addressProof}");

            break;
          case 'AddressProof':
            addressProof = map['url'];
            print("DETAILS AddressProof ${addressProof}");
            break;
        }
      });

      return map['url'];
    });
  }
}
