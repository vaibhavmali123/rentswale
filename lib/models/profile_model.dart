class ProfileModel {
  String statusCode;
  String message;
  List<ProfileList> profileList;

  ProfileModel({this.statusCode, this.message, this.profileList});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['profile_list'] != null) {
      profileList = new List<ProfileList>();
      json['profile_list'].forEach((v) {
        profileList.add(new ProfileList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.profileList != null) {
      data['profile_list'] = this.profileList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileList {
  String id;
  String name;
  String emailAddress;
  String address;
  String profileImage;
  String flatDetails;
  String landmark;
  String direction;

  ProfileList({this.id, this.name, this.emailAddress, this.address, this.profileImage, this.flatDetails, this.landmark, this.direction});

  ProfileList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emailAddress = json['email_address'];
    address = json['address'];
    profileImage = json['profile_image'];
    flatDetails = json['flat_details'];
    landmark = json['landmark'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email_address'] = this.emailAddress;
    data['address'] = this.address;
    data['profile_image'] = this.profileImage;
    data['flat_details'] = this.flatDetails;
    data['landmark'] = this.landmark;
    data['direction'] = this.direction;
    return data;
  }
}
