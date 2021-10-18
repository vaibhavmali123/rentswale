import 'package:rentswale/models/ProductsListModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsHomeBloc {
  final productsHomeFetcher = PublishSubject<ProductsListModel>();

  Stream<ProductsListModel> get productStream => productsHomeFetcher.stream;

  fetchProductsHome({String address}) async {
    ProductsListModel listProduct = await Repository.getProductHome(address: address);
    productsHomeFetcher.sink.add(listProduct);
  }
}

final productsHomeBloc = ProductsHomeBloc();
