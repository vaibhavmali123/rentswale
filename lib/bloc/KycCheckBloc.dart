import 'package:rentswale/models/kyc_check_model.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class KycCheckBloc {
  final kycCheckCtrl = PublishSubject<KycCheckModel>();

  Stream<KycCheckModel> get kycCheckStream => kycCheckCtrl.stream;

  checkKyc() async {
    KycCheckModel kycCheckModel = await Repository.checkKyc();

    kycCheckCtrl.sink.add(kycCheckModel);
  }
}

final kycCheckBloc = KycCheckBloc();
