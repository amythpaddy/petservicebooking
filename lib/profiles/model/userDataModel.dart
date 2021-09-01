class RequestUserDetailUpdate {
  final String firstName;
  final String email;
  const RequestUserDetailUpdate({required this.firstName, required this.email});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = firstName;
    data['email'] = email;
    return data;
  }
}

class ResponseUserDetail {
  Data? data;

  ResponseUserDetail({this.data});

  ResponseUserDetail.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  UserDataModel? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user =
        json['user'] != null ? new UserDataModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class UserDataModel {
  int? id;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? email;
  String? referralCode;

  UserDataModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.email,
      this.referralCode});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    email = json['email'];
    referralCode = json['referral_code'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['contact_number'] = this.contactNumber;
    data['email'] = this.email;
    data['referral_code'] = this.referralCode;
    return data;
  }
}
