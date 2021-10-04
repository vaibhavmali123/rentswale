import 'package:rentswale/models/ProductsListModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsHomeBloc {
  final productsHomeFetcher = PublishSubject<List<ProductList>>();

  Stream<List<ProductList>> get productStream => productsHomeFetcher.stream;

  fetchProductsHome() async {
    List<ProductList> listProduct = await Repository.getProductHome();
    productsHomeFetcher.sink.add(listProduct);
  }
}

final productsHomeBloc = ProductsHomeBloc();
