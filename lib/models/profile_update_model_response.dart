/// Status_code : "200"
/// result : {"id":"170","name":"a","email_address":"v","address":"f","profile_image":"t"}

class ProfileUpdateModelResponse {
  ProfileUpdateModelResponse({
    String statusCode,
    Result result,
  }) {
    _statusCode = statusCode;
    _result = result;
  }

  ProfileUpdateModelResponse.fromJson(dynamic json) {
    _statusCode = json['Status_code'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String _statusCode;
  Result _result;

  String get statusCode => _statusCode;
  Result get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status_code'] = _statusCode;
    if (_result != null) {
      map['result'] = _result.toJson();
    }
    return map;
  }
}

/// id : "170"
/// name : "a"
/// email_address : "v"
/// address : "f"
/// profile_image : "t"

class Result {
  Result({
    String id,
    String name,
    String emailAddress,
    String address,
    String profileImage,
  }) {
    _id = id;
    _name = name;
    _emailAddress = emailAddress;
    _address = address;
    _profileImage = profileImage;
  }

  Result.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _emailAddress = json['email_address'];
    _address = json['address'];
    _profileImage = json['profile_image'];
  }
  String _id;
  String _name;
  String _emailAddress;
  String _address;
  String _profileImage;

  String get id => _id;
  String get name => _name;
  String get emailAddress => _emailAddress;
  String get address => _address;
  String get profileImage => _profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email_address'] = _emailAddress;
    map['address'] = _address;
    map['profile_image'] = _profileImage;
    return map;
  }
}
