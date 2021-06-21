import 'package:the_pet_nest/welcome/models/baseRequestModal.dart';

class RegisterRequest extends BaseRequestModel {
  String firstName;
  String lastName;
  String email;

  RegisterRequest(
      {required this.firstName,
      required this.lastName,
      required number,
      required this.email})
      : super(type: 'register_request ', number: number);

  Map<String, dynamic> toJson() => {
        'code': code,
        'destination_type': 'phone',
        'destination_value': number,
        'user': {
          'first_name': firstName,
          'last_name': lastName,
          'contact_number': number,
          'email': email
        }
      };
}

class RegisterResponse {
  Data? data;
  Error? error;

  RegisterResponse({required this.data, required this.error});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    return data;
  }
}

class Data {
  String? expiredAt;

  Data({this.expiredAt});

  Data.fromJson(Map<String, dynamic> json) {
    expiredAt = json['expired_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expired_at'] = this.expiredAt;
    return data;
  }
}

class Error {
  bool? success;
  String? code;

  Error({this.success, this.code});

  Error.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    return data;
  }
}
