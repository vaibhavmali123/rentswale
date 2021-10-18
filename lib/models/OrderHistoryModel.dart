class OrderHistoryModel {
  String statusCode;
  String message;
  List<OrderDetailsList> orderDetailsList;

  OrderHistoryModel({this.statusCode, this.message, this.orderDetailsList});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['order_details_list'] != null) {
      orderDetailsList = new List<OrderDetailsList>();
      json['order_details_list'].forEach((v) {
        orderDetailsList.add(new OrderDetailsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.orderDetailsList != null) {
      data['order_details_list'] = this.orderDetailsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetailsList {
  String id;
  String name;
  String emailAddress;
  String phone;
  String address;
  String orderId;
  String date;
  List<OrderItemDetails> orderItemDetails;

  OrderDetailsList({this.id, this.name, this.emailAddress, this.phone, this.address, this.orderId, this.date, this.orderItemDetails});

  OrderDetailsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emailAddress = json['email_address'];
    phone = json['phone'];
    address = json['address'];
    orderId = json['order_id'];
    date = json['date'];
    if (json['order_item_details'] != null) {
      orderItemDetails = new List<OrderItemDetails>();
      json['order_item_details'].forEach((v) {
        orderItemDetails.add(new OrderItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email_address'] = this.emailAddress;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['order_id'] = this.orderId;
    data['date'] = this.date;
    if (this.orderItemDetails != null) {
      data['order_item_details'] = this.orderItemDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItemDetails {
  String id;
  String orderId;
  String phone;
  String itemId;
  String itemName;
  String itemPrice;
  String month;
  String couponCode;
  String subTotal;
  String date;

  OrderItemDetails({this.id, this.orderId, this.phone, this.itemId, this.itemName, this.itemPrice, this.month, this.couponCode, this.subTotal, this.date});

  OrderItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    phone = json['phone'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    month = json['month'];
    couponCode = json['coupon_code'];
    subTotal = json['sub_total'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['phone'] = this.phone;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['item_price'] = this.itemPrice;
    data['month'] = this.month;
    data['coupon_code'] = this.couponCode;
    data['sub_total'] = this.subTotal;
    data['date'] = this.date;
    return data;
  }
}
