import 'package:rentswale/models/CheckCouponModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class CouponCodeBloc {
  final couponFetcher = PublishSubject<CheckCouponModel>();

  Stream<CheckCouponModel> get checkCouponCodeStream => couponFetcher.stream;

  checkCouponCode({String couponCode}) async {
    CheckCouponModel checkCouponModel = await Repository.applyCoupon(coupon_code: couponCode);

    couponFetcher.sink.add(checkCouponModel);
  }
}

final couponBloc = CouponCodeBloc();
