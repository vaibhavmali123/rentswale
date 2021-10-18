import 'package:rentswale/models/OffersModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class OffersBloc {
  final offersController = PublishSubject<OffersModel>();

  Stream<OffersModel> get offersStream => offersController.stream;

  getOffers() async {
    OffersModel offersModel = await Repository.getOffers();
    print("RESPONSE ${offersModel.statusCode}");

    offersController.sink.add(offersModel);
  }
}

final offersBloc = OffersBloc();
