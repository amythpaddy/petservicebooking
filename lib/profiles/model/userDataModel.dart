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
  Image? image;

  UserDataModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.email,
      this.referralCode,
      this.image});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    email = json['email'];
    referralCode = json['referral_code'] ?? "";
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['contact_number'] = this.contactNumber;
    data['email'] = this.email;
    data['referral_code'] = this.referralCode;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class Image {
  ImageData? imageData;

  Image({this.imageData});

  Image.fromJson(Map<String, dynamic> json) {
    imageData =
        json['image'] != null ? new ImageData.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.imageData != null) {
      data['image'] = this.imageData!.toJson();
    }
    return data;
  }
}

class ImageData {
  String? signedId;
  String? url;

  ImageData({this.signedId, this.url});

  ImageData.fromJson(Map<String, dynamic> json) {
    signedId = json['signed_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signed_id'] = this.signedId;
    data['url'] = this.url;
    return data;
  }
}
