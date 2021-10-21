import 'package:rentswale/models/verify_otp_model.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class OtpVerifyBloc {
  final otpVerifyCtrl = PublishSubject<VerifyOtpModel>();

  Stream<VerifyOtpModel> get verifyOtpStream => otpVerifyCtrl.stream;

  verifyOtp({String otp, String userName}) async {
    VerifyOtpModel verifyOtpModel = await Repository.verifyOtp(otp: otp, userName: userName);

    otpVerifyCtrl.sink.add(verifyOtpModel);
  }
}

final otpVerifyBloc = OtpVerifyBloc();
