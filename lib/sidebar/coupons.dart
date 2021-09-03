import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/funnels/bloc/couponBloc/couponBloc.dart';
import 'package:the_pet_nest/funnels/bloc/couponBloc/couponState.dart';
import 'package:the_pet_nest/funnels/interfaces/couponSelectionInterface.dart';
import 'package:the_pet_nest/funnels/model/couponseApiResponseModel.dart';
import 'package:the_pet_nest/funnels/screen/screenCouponSelection.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class Coupons extends StatelessWidget implements CouponSelectionInterface {
  const Coupons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Coupon',
          style: TextStyle(
              color: kAppIconColor, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: kAppBackgroundAltGray,
        elevation: 0,
      ),
      backgroundColor: kAppBackgroundAltGray,
      body: BlocProvider(
          create: (_) => CouponBloc(CouponState()),
          child: BlocBuilder<CouponBloc, CouponState>(
            builder: (blocContext, state) {
              if (state.couponsData == null)
                BlocProvider.of<CouponBloc>(blocContext)
                    .getCoupons(FunnelType.PET_GROOMING);
              return Column(
                children: [
                  ScreenCouponSelection(
                    onCouponSelection: this,
                    totalPrice: 0,
                    couponsAreSelectable: false,
                  ),
                ],
              );
            },
          )),
    );
  }

  @override
  void onCouponSelected(blocContext, CouponData couponData) {
    // TODO: implement onCouponSelected
  }

  @override
  void onCouponSelectionCompleted(blocContext) {
    // TODO: implement onCouponSelectionCompleted
  }
}
