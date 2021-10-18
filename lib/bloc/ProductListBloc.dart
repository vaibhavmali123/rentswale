import 'package:rentswale/models/ProductsListModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxDart.dart';

class ProductListBloc {
  final productListFetcher = PublishSubject<ProductsListModel>();

  Stream<ProductsListModel> get productListStream => productListFetcher.stream;

  fetchProductsList({String categoryId, String subCategoryId}) async {
    ProductsListModel productsListModel = await Repository.getProductList(categoryId: categoryId, subCategoryId: subCategoryId);
    productListFetcher.sink.add(productsListModel);
  }
}

final productListBloc = ProductListBloc();
