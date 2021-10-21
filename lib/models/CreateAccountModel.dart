class CreateAccountModel {
  String message;
  String statusCode;
  Result result;

  CreateAccountModel({this.message, this.statusCode, this.result});

  CreateAccountModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['Status_code'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Status_code'] = this.statusCode;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String id;
  String name;
  String emailAddress;
  String username;
  String type;
  String password;

  Result({this.id, this.name, this.emailAddress, this.username, this.type, this.password});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emailAddress = json['email_address'];
    username = json['username'];
    type = json['type'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email_address'] = this.emailAddress;
    data['username'] = this.username;
    data['type'] = this.type;
    data['password'] = this.password;
    return data;
  }
}
