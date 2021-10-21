import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class UploadFileBloc {
  final fileUploadCtrl = PublishSubject<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get fileUploadStream => fileUploadCtrl.stream;

  uploadFile({fileName, directory, String type}) async {
    Map<String, dynamic> mapResult = await Repository.uploadFile(fileName: fileName, directory: directory);

    fileUploadCtrl.sink.add(mapResult);
  }
}

final uploadFileBloc = UploadFileBloc();
