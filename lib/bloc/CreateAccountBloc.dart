import 'package:rentswale/models/CreateAccountModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class CreateAccountBloc {
  final createAccountFetcher = PublishSubject<CreateAccountModel>();

  Stream<CreateAccountModel> get createAccountStream => createAccountFetcher.stream;

  createAccount({String name, String email, String mobileNumber, String password, String type}) async {
    CreateAccountModel createAccountModel = await Repository.createAccount(name: name, email: email, mobileNumber: mobileNumber, password: password, type: type);
    print("DDDFFFDD ${createAccountModel.message}");
    createAccountFetcher.sink.add(createAccountModel);
  }
}

final createAccountBloc = CreateAccountBloc();
