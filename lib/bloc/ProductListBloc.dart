import 'package:rentswale/models/ProductsListModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxDart.dart';

class ProductListBloc {
  final productListFetcher = PublishSubject<List<ProductList>>();

  Stream<List<ProductList>> get productListStream => productListFetcher.stream;

  fetchProductsList({String categoryId, String subCategoryId}) async {
    List<ProductList> listProduct = await Repository.getProductList(categoryId: categoryId, subCategoryId: subCategoryId);
    productListFetcher.sink.add(listProduct);
  }
}

final productListBloc = ProductListBloc();
