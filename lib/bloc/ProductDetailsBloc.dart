import 'package:rentswale/models/ProductDetailsModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductDetailsBloc {
  final productsDetailsFetcher = PublishSubject<List<ProductDescription>>();

  Stream<List<ProductDescription>> get productDescriptionStream => productsDetailsFetcher.stream;

  getProductsDetails({String itemMasterId}) async {
    List<ProductDescription> listProductDescription = await Repository.getProductDetails(itemMasterId: itemMasterId);
    productsDetailsFetcher.sink.add(listProductDescription);
  }
}

final productDetailsBloc = ProductDetailsBloc();
