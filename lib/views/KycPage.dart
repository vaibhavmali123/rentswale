import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rentswale/utils/Colors.dart';
import 'package:rentswale/utils/constants.dart';
import 'package:rentswale/utils/utils.dart';

class KycPage extends StatefulWidget {
  KycPageState createState() => KycPageState();
}

class KycPageState extends State<KycPage> {
  TextEditingController aadharController, licenseController;
  String aadharCard, license, addressProof;

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KYC',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: color.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade100,
          child: Column(
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
                              // kycBloc.updateKyc(aadharNo:aadharController.text,);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(primary: color.primaryColor, textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white)),
                            child: Text('Submit')),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _showCategoryPicker(String addressProof, BuildContext context) async {
    print("dsddsd");
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

                    showPicker(type: constants.electricityBill, context: context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.iso),
                  title: Text("Company or College ID"),
                  onTap: () {
                    Navigator.pop(context);
                    showPicker(type: constants.idCard, context: context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.iso),
                  title: Text("Rent agreement"),
                  onTap: () {
                    Navigator.pop(context);
                    showPicker(type: constants.agreement, context: context);
                  },
                )
              ],
            ),
          ));
        });
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
                  'Adhaar Card',
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

                      print("DDDDDDDDDDDDDDD ${file.path.toString()}");
                      print("DDDDDDDDDDDDDDD  Dir ${dir.toString()}");
                      print("DDDDDDDDDDDDDDD  extension ${extension}");

                      String newPath = path.join(dir, imageName + '.' + extension);
                      print("DDDDDDDDDDDDDDD  newPath ${newPath}");

                      File f = await File(fileResult.files.single.path);
                      File ff = await File(f.path).copy(newPath);
                      print("DDDDDDDDDDDDDDD  newFilePAth ${ff}");

                      String fileName = ff.path.split('/').last;
                      print("DDDDDDDDDDDDDDD  FILENAME ${fileName}");

                      uploadFile(fileName: fileName, directory: dir);

                      switch (type) {
                        case 'adhaarCard':
                          break;
                        case 'drivingLiscene':
                          break;
                        case 'AddressProof':
                          break;
                      }
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

  void initControllers() {
    aadharController = TextEditingController();
    licenseController = TextEditingController();
  }

  uploadFile({fileName, directory}) async {
    dynamic prog;
    Map<String, dynamic> map;
    final uploader = FlutterUploader();
    //String fileName = await file.path.split('/').last;

    final taskId = await uploader.enqueue(url: "http://rentswale.com/admin/index.php/api/FileUpload/uploadFile", files: [FileItem(filename: fileName, savedDir: directory)], method: UploadMethod.POST, headers: {"apikey": "api_123456", "userkey": "userkey_123456"}, showNotification: true);
    final subscription = uploader.progress.listen((progress) {
      print("Progress ${progress}");
    });

    final subscription1 = uploader.result.listen((result) {
//    print("Progress result ${result.response}");

      // return result.response;
    }, onError: (ex, stacktrace) {
      setState(() {});
    });
    subscription1.onData((data) async {
      map = await json.decode(data.response);
      map = await json.decode(data.response);
      print("PATH data ${map['url']}");
      setState(() {});
    });

    /*  http.MultipartRequest request = await new http.MultipartRequest("POST", Uri.parse(ApiProvider.baseUrlUpload));

    http.MultipartFile multipartFile = await http.MultipartFile.fromPath('file', fileName.path);

    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();
    String imgUrl;
    response.stream.transform(utf8.decoder).listen((event) {
      print("IMG_RESPONSE ${event}");
      setState(() {
        json.decode(event);
        print("IMG_RESPONSE ${json.decode(event)}");
      });

      setState(() {});
    });*/
  }
}
