class ProductDetailsModel {
  String statusCode;
  String message;
  List<ProductDescription> productDescription;

  ProductDetailsModel({this.statusCode, this.message, this.productDescription});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['product_description'] != null) {
      productDescription = new List<ProductDescription>();
      json['product_description'].forEach((v) {
        productDescription.add(new ProductDescription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.productDescription != null) {
      data['product_description'] = this.productDescription.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDescription {
  String itemMasterId;
  String cityName;
  String subCategoryId;
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
  String termSpecification;

  ProductDescription(
      {this.itemMasterId,
      this.cityName,
      this.subCategoryId,
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
      this.termSpecification});

  ProductDescription.fromJson(Map<String, dynamic> json) {
    itemMasterId = json['item_master_id'];
    cityName = json['city_name'];
    subCategoryId = json['sub_category_id'];
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
    termSpecification = json['term_specification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_master_id'] = this.itemMasterId;
    data['city_name'] = this.cityName;
    data['sub_category_id'] = this.subCategoryId;
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
    data['term_specification'] = this.termSpecification;
    return data;
  }
}
