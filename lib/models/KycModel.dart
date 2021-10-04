class KycModel {
  String statusCode;
  Result result;

  KycModel({this.statusCode, this.result});

  KycModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['Status_code'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status_code'] = this.statusCode;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String id;
  String adharNumber;
  String adharCard;
  String drivingLicence;
  String drivingLicenceNumber;
  String addressProof;

  Result({this.id, this.adharNumber, this.adharCard, this.drivingLicence, this.drivingLicenceNumber, this.addressProof});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adharNumber = json['adhar_number'];
    adharCard = json['adhar_card'];
    drivingLicence = json['driving_licence'];
    drivingLicenceNumber = json['driving_licence_number'];
    addressProof = json['address_proof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adhar_number'] = this.adharNumber;
    data['adhar_card'] = this.adharCard;
    data['driving_licence'] = this.drivingLicence;
    data['driving_licence_number'] = this.drivingLicenceNumber;
    data['address_proof'] = this.addressProof;
    return data;
  }
}
