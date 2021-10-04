/*
class ProductsHomeModel {
  String statusCode;
  String message;
  List<ProductList> productList;

  ProductsHomeModel({this.statusCode, this.message, this.productList});

  ProductsHomeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['product_list'] != null) {
      productList = new List<ProductList>();
      json['product_list'].forEach((v) {
        productList.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.productList != null) {
      data['product_list'] = this.productList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String itemMasterId;
  String subCategoryId;
  String categoryId;
  String cityName;
  String itemName;
  String price;
  String priceMonth;
  String priceThree;
  String priceSix;
  String priceNine;
  String priceTwel;
  String description;
  String deposite;
  String deliveryCharge;
  String itemImg;
  String itemImgOne;
  String itemImgTwo;
  String itemImgThree;
  String rating;
  String status;
  String heading;
  String termSpecification;

  ProductList(
      {this.itemMasterId,
        this.subCategoryId,
        this.categoryId,
        this.cityName,
        this.itemName,
        this.price,
        this.priceMonth,
        this.priceThree,
        this.priceSix,
        this.priceNine,
        this.priceTwel,
        this.description,
        this.deposite,
        this.deliveryCharge,
        this.itemImg,
        this.itemImgOne,
        this.itemImgTwo,
        this.itemImgThree,
        this.rating,
        this.status,
        this.heading,
        this.termSpecification});

  ProductList.fromJson(Map<String, dynamic> json) {
    itemMasterId = json['item_master_id'];
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    cityName = json['city_name'];
    itemName = json['item_name'];
    price = json['price'];
    priceMonth = json['price_month'];
    priceThree = json['price_three'];
    priceSix = json['price_six'];
    priceNine = json['price_nine'];
    priceTwel = json['price_twel'];
    description = json['description'];
    deposite = json['deposite'];
    deliveryCharge = json['delivery_charge'];
    itemImg = json['item_img'];
    itemImgOne = json['item_img_one'];
    itemImgTwo = json['item_img_two'];
    itemImgThree = json['item_img_three'];
    rating = json['rating'];
    status = json['status'];
    heading = json['heading'];
    termSpecification = json['term_specification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_master_id'] = this.itemMasterId;
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['city_name'] = this.cityName;
    data['item_name'] = this.itemName;
    data['price'] = this.price;
    data['price_month'] = this.priceMonth;
    data['price_three'] = this.priceThree;
    data['price_six'] = this.priceSix;
    data['price_nine'] = this.priceNine;
    data['price_twel'] = this.priceTwel;
    data['description'] = this.description;
    data['deposite'] = this.deposite;
    data['delivery_charge'] = this.deliveryCharge;
    data['item_img'] = this.itemImg;
    data['item_img_one'] = this.itemImgOne;
    data['item_img_two'] = this.itemImgTwo;
    data['item_img_three'] = this.itemImgThree;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['heading'] = this.heading;
    data['term_specification'] = this.termSpecification;
    return data;
  }
}
*/
