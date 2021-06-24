import 'package:the_pet_nest/welcome/models/baseRequestModal.dart';

class LoginRequest extends BaseRequestModel {
  final String destinationType = 'phone';
  late int id;

  LoginRequest({phone, id: -1, code: ''})
      : super(type: 'login_request', number: phone, code: code);
  Map<String, dynamic> toJson() =>
      {'phone': number, 'destination_type': destinationType, 'code': code};
  Map<String, dynamic> toJsonForOtpVerification() =>
      {'contact_number': number, 'code': code};

  Map<String, dynamic> toJsonForOtpGeneration() =>
      {'destination_type': destinationType, 'id': id};
}

class LoginResponse {
  Data? data;

  LoginResponse({this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? email;

  User(
      {this.id, this.firstName, this.lastName, this.contactNumber, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['contact_number'] = this.contactNumber;
    data['email'] = this.email;
    return data;
  }
}
