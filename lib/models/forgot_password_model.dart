/// data_code : "200"
/// state_list : "OTP Send"

class ForgotPasswordModel {
  ForgotPasswordModel({
    String dataCode,
    String stateList,
  }) {
    _dataCode = dataCode;
    _stateList = stateList;
  }

  ForgotPasswordModel.fromJson(dynamic json) {
    _dataCode = json['data_code'];
    _stateList = json['state_list'];
  }
  String _dataCode;
  String _stateList;

  String get dataCode => _dataCode;
  String get stateList => _stateList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data_code'] = _dataCode;
    map['state_list'] = _stateList;
    return map;
  }
}
