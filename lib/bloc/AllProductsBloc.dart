import 'package:rentswale/models/AllProductsModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class AllProductsBloc {
  final allProductsFetcher = PublishSubject<List<AllProductList>>();

  Stream<List<AllProductList>> get productDescriptionStream => allProductsFetcher.stream;

  getAllProducts() async {
    List<AllProductList> listProductDescription = await Repository.allProducts();

    allProductsFetcher.sink.add(listProductDescription);
  }
}

final allProductDetailsBloc = AllProductsBloc();
