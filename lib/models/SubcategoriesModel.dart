class SubcategoriesModel {
  String statusCode;
  String message;
  List<SubcategoryList> subcategoryList;

  SubcategoriesModel({this.statusCode, this.message, this.subcategoryList});

  SubcategoriesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['subcategory_list'] != null) {
      subcategoryList = new List<SubcategoryList>();
      json['subcategory_list'].forEach((v) {
        subcategoryList.add(new SubcategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.subcategoryList != null) {
      data['subcategory_list'] = this.subcategoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubcategoryList {
  String subCategoryId;
  String categoryId;
  String subCategory;

  SubcategoryList({this.subCategoryId, this.categoryId, this.subCategory});

  SubcategoryList.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    subCategory = json['sub_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['sub_category'] = this.subCategory;
    return data;
  }
}
