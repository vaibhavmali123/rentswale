/// data_code : "200"
/// res : "Email send to your register Mail ID"

class VerifyOtpModel {
  VerifyOtpModel({
    String dataCode,
    String res,
  }) {
    _dataCode = dataCode;
    _res = res;
  }

  VerifyOtpModel.fromJson(dynamic json) {
    _dataCode = json['data_code'];
    _res = json['res'];
  }
  String _dataCode;
  String _res;

  String get dataCode => _dataCode;
  String get res => _res;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data_code'] = _dataCode;
    map['res'] = _res;
    return map;
  }
}
