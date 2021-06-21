class OtpResponse {
  Data? data;
  Error? error;

  OtpResponse({this.data, this.error});

  OtpResponse.fromJson(Map<String, dynamic> json) {
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
  bool? success;
  int? otpId;

  Data({this.success, this.otpId});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    otpId = json['otp_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['otp_id'] = this.otpId;
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
