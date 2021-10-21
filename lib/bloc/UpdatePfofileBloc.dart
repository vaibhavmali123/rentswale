import 'package:rentswale/models/profile_update_model_response.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class UpdatePfofileBloc {
  final updateProfileCtrl = PublishSubject<ProfileUpdateModelResponse>();

  Stream<ProfileUpdateModelResponse> get updateProfileStream => updateProfileCtrl.stream;

  updateProfile({String name, String email, String address, String profileImage, String floorNo, String landmark, String direction}) async {
    ProfileUpdateModelResponse profileUpdateModelResponse = await Repository.updateProfile(name: name, email: email, address: address, profileImage: profileImage, floorNo: floorNo, landmark: landmark, direction: direction);

    updateProfileCtrl.sink.add(profileUpdateModelResponse);
  }
}

final updateProfileBloc = UpdatePfofileBloc();
