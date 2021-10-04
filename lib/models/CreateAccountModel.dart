class CreateAccountModel {
  String message;

  CreateAccountModel({this.message});

  CreateAccountModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    return data;
  }
}
