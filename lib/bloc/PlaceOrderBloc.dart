import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class PlaceOrderBloc {
  final placeOrderSubject = PublishSubject<dynamic>();

  Stream<dynamic> get placeOrderStream => placeOrderSubject.stream;

  placeOrder({List<dynamic> placeOrderList, String address,String flatNo, String landmark, String direction}) async {
    dynamic result = await Repository.placeOrder(placeOrderList: placeOrderList, address: address,flatNo:flatNo,landmark:landmark,direction:direction);

    placeOrderSubject.sink.add(result);
  }
}

final placeOrderBloc = PlaceOrderBloc();
