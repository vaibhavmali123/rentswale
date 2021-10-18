import 'package:rentswale/models/OrderHistoryModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class OrderHistoryBloc {
  final orderHistoryController = PublishSubject<OrderHistoryModel>();

  Stream<OrderHistoryModel> get orderHistoryStream => orderHistoryController.stream;

  getOrderHistory() async {
    OrderHistoryModel orderHistoryModel = await Repository.getOrderHistory();

    orderHistoryController.sink.add(orderHistoryModel);
  }
}

final orderHistoryBloc = OrderHistoryBloc();
