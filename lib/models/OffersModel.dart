class OffersModel {
  String statusCode;
  String message;
  List<OfferList> offerList;

  OffersModel({this.statusCode, this.message, this.offerList});

  OffersModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['offer_list'] != null) {
      offerList = new List<OfferList>();
      json['offer_list'].forEach((v) {
        offerList.add(new OfferList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.offerList != null) {
      data['offer_list'] = this.offerList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferList {
  String id;
  String sliderImage;

  OfferList({this.id, this.sliderImage});

  OfferList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sliderImage = json['slider_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slider_image'] = this.sliderImage;
    return data;
  }
}
