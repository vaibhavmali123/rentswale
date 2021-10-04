class PlaceOrderModel {
  String categoryId;
  String itemId;
  String itemName;
  String itemPrice;
  String month;
  String subTotal;

  PlaceOrderModel({this.categoryId, this.itemId, this.itemName, this.itemPrice, this.month, this.subTotal});

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    month = json['month'];
    subTotal = json['sub_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['item_price'] = this.itemPrice;
    data['month'] = this.month;
    data['sub_total'] = this.subTotal;
    return data;
  }
}
