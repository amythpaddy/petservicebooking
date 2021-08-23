class ApplyCouponRequestData {
  final double totalAmount;
  final int couponId;

  ApplyCouponRequestData({required this.totalAmount, required this.couponId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["total_amount"] = totalAmount;
    data["coupon_id"] = couponId;
    Map<String, dynamic> request = Map<String, dynamic>();
    request["coupon_validation"] = data;
    return request;
  }
}

class ApplyCouponResponse {
  Data? data;
  Error? error;

  ApplyCouponResponse({this.data, this.error});

  ApplyCouponResponse.fromJson(Map<String, dynamic> json) {
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

  Data({this.success});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    return data;
  }
}

class Error {
  String? code;

  Error({this.code});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}
