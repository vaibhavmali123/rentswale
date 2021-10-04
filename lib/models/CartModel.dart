class CartModel {
  String productName;
  String price;
  String cityName;

  CartModel({this.productName, this.price, this.cityName});

  CartModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    price = json['price'];
    cityName = json['cityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['price'] = this.price;
    data['cityName'] = this.cityName;
    return data;
  }
}
