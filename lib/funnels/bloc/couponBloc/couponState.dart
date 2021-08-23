import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/funnels/model/couponseApiResponseModel.dart';

class CouponState extends Equatable {
  final bool fetchingCouponList;
  final CouponDataResponse? couponsData;
  final String couponCode;
  final bool copyCode;
  final bool hasError;
  final String errorMsg;
  final bool isApplyingCoupon;
  final bool isCouponApplied;
  final int selectedCouponId;
  final double discountValue;

  CouponState(
      {this.fetchingCouponList = true,
      this.couponsData,
      this.couponCode = '',
      this.copyCode = false,
      this.hasError = false,
      this.errorMsg = '',
      this.isApplyingCoupon = false,
      this.isCouponApplied = false,
      this.selectedCouponId = 0,
      this.discountValue = 0});

  CouponState copyWith(
      {bool? fetchingCouponList,
      CouponDataResponse? couponsData,
      String? applyCouponCode,
      bool? copyCode,
      bool? hasError,
      String? errorMsg,
      bool? isApplyingCoupon,
      bool? isCouponApplied,
      int? selectedCouponId,
      double? discountValue}) {
    return CouponState(
        fetchingCouponList: fetchingCouponList ?? this.fetchingCouponList,
        couponsData: couponsData ?? this.couponsData,
        couponCode: applyCouponCode ?? this.couponCode,
        copyCode: copyCode ?? false,
        hasError: hasError ?? false,
        errorMsg: errorMsg ?? '',
        isApplyingCoupon: isApplyingCoupon ?? this.isApplyingCoupon,
        isCouponApplied: isCouponApplied ?? this.isCouponApplied,
        selectedCouponId: selectedCouponId ?? this.selectedCouponId,
        discountValue: discountValue ?? this.discountValue);
  }

  @override
  List<Object?> get props => [
        fetchingCouponList,
        couponsData,
        couponCode,
        copyCode,
        hasError,
        errorMsg,
        isApplyingCoupon,
        isCouponApplied,
        selectedCouponId,
        discountValue
      ];
}
