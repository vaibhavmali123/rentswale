import 'package:rentswale/models/forgot_password_model.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordBloc {
  final forgotPasswordCtrl = PublishSubject<ForgotPasswordModel>();

  Stream<ForgotPasswordModel> get forgotPasswordStream => forgotPasswordCtrl.stream;
  forgotPassword({String userName}) async {
    ForgotPasswordModel forgotPasswordModel = await Repository.forgotPassword(userName: userName);

    forgotPasswordCtrl.sink.add(forgotPasswordModel);
  }
}

final forgotPasswordBloc = ForgotPasswordBloc();
