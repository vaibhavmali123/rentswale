import 'package:rentswale/models/KycModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class KycBloc {
  final kycFetcher = PublishSubject<KycModel>();

  Stream<KycModel> get kycStream => kycFetcher.stream;

  updateKyc({String aadharNo, String aadharCard, String addressProof, String licenseNo, String license}) async {
    KycModel kycModel = await Repository.updateKyc(aadharNo: aadharNo, aadharCard: aadharCard, addressProof: addressProof, licenseNo: licenseNo, license: license);

    kycFetcher.sink.add(kycModel);
  }
}

final kycBloc = KycBloc();
