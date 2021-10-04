import 'package:rentswale/models/LoginModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final loginFetcher = PublishSubject<LoginModel>();

  Stream<LoginModel> get loginStream => loginFetcher.stream;

  login({String username, String password}) async {
    LoginModel loginModel = await Repository.login(userName: username, password: password);
    loginFetcher.sink.add(loginModel);
  }
}

final loginBloc = LoginBloc();
