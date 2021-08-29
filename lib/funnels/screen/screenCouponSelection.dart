import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/funnels/bloc/couponBloc/couponBloc.dart';
import 'package:the_pet_nest/funnels/bloc/couponBloc/couponState.dart';
import 'package:the_pet_nest/funnels/component/bottomPriceDisplayComponent.dart';
import 'package:the_pet_nest/funnels/component/couponCardComponent.dart';
import 'package:the_pet_nest/funnels/interfaces/couponSelectionInterface.dart';

class ScreenCouponSelection extends StatelessWidget {
  const ScreenCouponSelection(
      {Key? key, required this.onCouponSelection, required this.totalPrice})
      : super(key: key);
  final CouponSelectionInterface onCouponSelection;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Apply Code'),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: BlocBuilder<CouponBloc, CouponState>(
                      builder: (blocContext, state) {
                        TextEditingController _controller =
                            TextEditingController(text: state.couponCode);
                        return Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextFormField(
                              enabled: false,
                              controller: _controller,
                              decoration: InputDecoration(
                                  hintText: 'Paste', border: InputBorder.none),
                            )),
                            BlocBuilder<CouponBloc, CouponState>(
                                builder: (blocContext, state) {
                              return TextButton(
                                  onPressed: () {
                                    if (!state.isApplyingCoupon)
                                      BlocProvider.of<CouponBloc>(blocContext)
                                          .applyCouponCode(
                                              totalAmount: totalPrice,
                                              couponId: state.selectedCouponId);
                                  },
                                  child: state.isApplyingCoupon
                                      ? CircularProgressIndicator()
                                      : Text('Apply'));
                            })
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<CouponBloc, CouponState>(
                      builder: (blocContext, state) {
                    return ListView.builder(
                        itemCount: state.couponsData!.data!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (ctx, index) {
                          return CouponCard(
                            discountValue:
                                state.couponsData!.data![index].discountValue!,
                            discountDescription:
                                state.couponsData!.data![index].description!,
                            discountCode:
                                state.couponsData!.data![index].couponCode!,
                            onPressed: () {
                              BlocProvider.of<CouponBloc>(blocContext)
                                  .copyCouponCode(
                                      state.couponsData!.data![index]
                                          .couponCode!,
                                      state.couponsData!.data![index].id!,
                                      state.couponsData!.data![index]
                                          .discountValue!);
                            },
                          );
                        });
                  })
                ],
              ),
            ),
          ),
          BlocBuilder<CouponBloc, CouponState>(builder: (blocContext, state) {
            return BottomPriceDisplayComponent(
                totalPrice: totalPrice,
                onPressed: () {
                  onCouponSelection.onCouponSelectionCompleted(context);
                },
                discountPrice: state.discountValue,
                proceedText: 'Select Date and Time');
          })
        ],
      ),
    );
  }
}
