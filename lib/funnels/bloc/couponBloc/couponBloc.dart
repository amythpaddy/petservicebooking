import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/funnels/bloc/couponBloc/couponEvent.dart';
import 'package:the_pet_nest/funnels/bloc/couponBloc/couponState.dart';
import 'package:the_pet_nest/funnels/model/applyCouponModel.dart';
import 'package:the_pet_nest/funnels/model/couponseApiResponseModel.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  late CouponDataResponse _getCouponResponse;
  String _selectedCouponCode = '';
  ApplyCouponResponse? _applyCouponResponse;
  String _errorMsg = '';
  int _selectedCouponId = 0;
  double _discountValue = 0;

  CouponBloc(CouponState initialState) : super(initialState) {
    getCoupons();
  }

  void getCoupons() async {
    add(CouponEvent.GETTING_COUPON_LIST);
    var response =
        await ApiCaller.get(kUrlGetCouponsList('grooming'), withToken: true);
    _getCouponResponse = CouponDataResponse.fromJson(response);
    add(CouponEvent.FETCHED_COUPON_LIST);
  }

  void copyCouponCode(String couponCode, int couponId, double discountValue) {
    _selectedCouponCode = couponCode;
    _selectedCouponId = couponId;
    _discountValue = discountValue;
    add(CouponEvent.COPY_COUPON_CODE);
  }

  void applyCouponCode(
      {required double totalAmount, required int couponId}) async {
    add(CouponEvent.APPLYING_COUPON);
    ApplyCouponRequestData data =
        ApplyCouponRequestData(totalAmount: totalAmount, couponId: couponId);
    var response =
        await ApiCaller.post(kUrlApplyCoupons, data.toJson(), withToken: true);
    _applyCouponResponse = ApplyCouponResponse.fromJson(response);
    if (_applyCouponResponse!.error == null) {
      add(CouponEvent.COUPON_APPLIED);
    } else {
      switch (_applyCouponResponse!.error!.code) {
        case 'exceeds_max_usages':
          _errorMsg = 'Max Usage For Coupon Exceeded';
          break;
        case 'total_amount_less_than_min_order_value':
          _errorMsg = 'Total amount is less than minimum order value.';
          break;
        case 'coupon_expired':
          _errorMsg = 'Coupon Has Expired';
          break;
        default:
          _errorMsg = 'Invalid coupon code';
      }
      add(CouponEvent.ERROR_APPLYING_COUPON);
    }
  }

  @override
  Stream<CouponState> mapEventToState(CouponEvent event) async* {
    if (event == CouponEvent.GETTING_COUPON_LIST) {
      yield state.copyWith(fetchingCouponList: true);
    } else if (event == CouponEvent.FETCHED_COUPON_LIST) {
      yield state.copyWith(
          couponsData: _getCouponResponse, fetchingCouponList: false);
    } else if (event == CouponEvent.COPY_COUPON_CODE) {
      yield state.copyWith(
          applyCouponCode: _selectedCouponCode,
          copyCode: true,
          selectedCouponId: _selectedCouponId,
          discountValue: _discountValue);
    } else if (event == CouponEvent.APPLYING_COUPON) {
      yield state.copyWith(isApplyingCoupon: true);
    } else if (event == CouponEvent.COUPON_APPLIED) {
      yield state.copyWith(isApplyingCoupon: false, isCouponApplied: true);
    } else if (event == CouponEvent.ERROR_APPLYING_COUPON) {
      yield state.copyWith(
          isApplyingCoupon: false, hasError: true, errorMsg: _errorMsg);
    }
  }
}
