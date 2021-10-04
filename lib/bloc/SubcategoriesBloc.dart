import 'package:rentswale/models/SubcategoriesModel.dart';
import 'package:rentswale/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class SubcategoriesBloc {
  Repository repository = Repository();
  final subCategoryFether = PublishSubject<List<SubcategoryList>>();

  Stream<List<SubcategoryList>> get subCategoriesStream => subCategoryFether.stream;

  fetchSubcategories(String categoryId) async {
    List<SubcategoryList> listSubCategories = await Repository.getSubCategories(categoryId);
    print("FROM BLOC ${listSubCategories?.length}");
    subCategoryFether.sink.add(listSubCategories);
  }
}

final subCategoriesBloc = SubcategoriesBloc();
