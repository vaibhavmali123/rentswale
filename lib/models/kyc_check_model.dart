class KycCheckModel {
  String statusCode;
  String message;

  KycCheckModel({this.statusCode, this.message});

  KycCheckModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['Message'] = this.message;
    return data;
  }
}
