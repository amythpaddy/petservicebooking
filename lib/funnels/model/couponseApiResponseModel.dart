class CouponDataResponse {
  List<CouponData>? data;

  CouponDataResponse({this.data});

  CouponDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new CouponData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouponData {
  int? id;
  String? couponCode;
  String? discountType;
  double? discountValue;
  String? validFrom;
  String? validTill;
  double? maxDiscountValue;
  double? minOrderValue;
  bool? isActive;
  String? serviceType;
  int? usesLeft;
  int? maxUsagePerUser;
  String? couponType;
  int? userId;
  String? description;

  CouponData(
      {this.id,
      this.couponCode,
      this.discountType,
      this.discountValue,
      this.validFrom,
      this.validTill,
      this.maxDiscountValue,
      this.minOrderValue,
      this.isActive,
      this.serviceType,
      this.usesLeft,
      this.maxUsagePerUser,
      this.couponType,
      this.userId,
      this.description});

  CouponData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponCode = json['coupon_code'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    validFrom = json['valid_from'];
    validTill = json['valid_till'];
    maxDiscountValue = json['max_discount_value'];
    minOrderValue = json['min_order_value'];
    isActive = json['is_active'];
    serviceType = json['service_type'];
    usesLeft = json['uses_left'];
    maxUsagePerUser = json['max_usage_per_user'];
    couponType = json['coupon_type'];
    userId = json['user_id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupon_code'] = this.couponCode;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['valid_from'] = this.validFrom;
    data['valid_till'] = this.validTill;
    data['max_discount_value'] = this.maxDiscountValue;
    data['min_order_value'] = this.minOrderValue;
    data['is_active'] = this.isActive;
    data['service_type'] = this.serviceType;
    data['uses_left'] = this.usesLeft;
    data['max_usage_per_user'] = this.maxUsagePerUser;
    data['coupon_type'] = this.couponType;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    return data;
  }
}
