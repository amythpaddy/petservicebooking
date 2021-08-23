import 'package:the_pet_nest/funnels/model/couponseApiResponseModel.dart';

abstract class CouponSelectionInterface {
  void onCouponSelected(blocContext, CouponData couponData);
  void onCouponSelectionCompleted(blocContext);
}
