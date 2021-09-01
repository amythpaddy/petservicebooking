import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/funnels/bloc/couponBloc/couponBloc.dart';
import 'package:the_pet_nest/funnels/bloc/couponBloc/couponState.dart';
import 'package:the_pet_nest/funnels/component/bottomPriceDisplayComponent.dart';
import 'package:the_pet_nest/funnels/component/serviceBookingDetailPetCardComponent.dart';
import 'package:the_pet_nest/funnels/interfaces/bookingDetailReviewInterface.dart';
import 'package:the_pet_nest/funnels/model/packageDetailApiResponseModel.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';

class ScreenReviewBookingDetail extends StatelessWidget {
  const ScreenReviewBookingDetail(
      {Key? key,
      required this.onBookingDetailReviewInterface,
      required this.totalPrice,
      required this.petData,
      required this.packageDetail,
      required this.currentFunnel})
      : super(key: key);
  final BookingDetailReviewInterface onBookingDetailReviewInterface;
  final double totalPrice;
  final List<CustomerPet> petData;
  final List<PackageDetailModel> packageDetail;
  final FunnelType currentFunnel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.59,
                        ),
                        Text('Booking Details',
                            style: kFunnelScreenHeadingTextStyle),
                        SizedBox(
                          height: 8.4,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: petData.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (builder, index) =>
                                ServiceBookingDetailPetCardComponent(
                                    petName: petData[index].name!,
                                    bookingDate: '',
                                    servicePrice: packageDetail[index].price!,
                                    bookingService:
                                        packageDetail[index].name!)),
                        TextButton(
                          style:
                              TextButton.styleFrom(padding: EdgeInsets.all(0)),
                          onPressed: () => onBookingDetailReviewInterface
                              .onAddAnotherPetClicked(context),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 14.5),
                              margin: EdgeInsets.symmetric(vertical: 8.2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [kContainerBoxShadow]),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/pet_paw_icon.svg',
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Add another pet',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 18.59,
                        ),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'Any Preferred Pet Hero? ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  height: 1.5),
                            ),
                            TextSpan(
                              text: ' (Optional)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  height: 1.5),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: 8.6,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter name',
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Visibility(
                          visible: currentFunnel == FunnelType.PET_GROOMING,
                          child: Column(
                            children: [
                              Text(
                                'Appointment Prep',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    height: 1.5),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                'assets/images/funnels/grooming_prep_image.png',
                                height: 160,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'We recommend you to have following items on the day of appointment. \n ${String.fromCharCode(0x2022)} A bathing area and Personal towels (If Any) \n ${String.fromCharCode(0x2022)} A well-lit area that has access to outlets for blow drying.'),
                            ],
                          ),
                        ),
                      ],
                    )),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                  onPressed: () {
                    onBookingDetailReviewInterface
                        .onCouponSelectionButtonClicked(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                    color: Colors.white,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/funnels/booking_page_coupon_icon.svg',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Offers, promo code and gifts cards',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  color: Colors.black),
                            ),
                            BlocBuilder<CouponBloc, CouponState>(
                                builder: (blocContext, state) {
                              if (state.couponsData == null)
                                BlocProvider.of<CouponBloc>(blocContext)
                                    .getCoupons(currentFunnel);
                              return Text(
                                state.fetchingCouponList
                                    ? '...'
                                    : '${state.couponsData!.data!.length} offers available',
                                style: TextStyle(
                                    fontSize: 12,
                                    height: 1.5,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFB6B7B9)),
                              );
                            })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                    color: Colors.white,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/home/refer_n_earn.svg',
                          height: 36,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Refer and Earn',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5),
                            ),
                            Text(
                              'Guaranteed reward for every referral',
                              style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFB6B7B9)),
                            )
                          ],
                        )
                      ],
                    )),
                SizedBox(
                  height: 135,
                )
              ],
            ),
          ),
          BlocBuilder<CouponBloc, CouponState>(builder: (blocContext, state) {
            return BottomPriceDisplayComponent(
                totalPrice: totalPrice,
                onPressed: () {
                  onBookingDetailReviewInterface
                      .onBookingDetailReviewComplete(context);
                },
                discountPrice: state.discountValue,
                proceedText: 'Select Date and Time');
          }),
        ],
      ),
    );
  }
}
