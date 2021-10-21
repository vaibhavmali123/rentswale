import 'package:rentswale/models/profile_model.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final profileCtrl = PublishSubject<ProfileModel>();

  Stream<ProfileModel> get profileStream => profileCtrl.stream;

  getProfile() async {
    ProfileModel profileModel = await Repository.getProfile();

    profileCtrl.sink.add(profileModel);
  }
}

final profileBloc = ProfileBloc();
