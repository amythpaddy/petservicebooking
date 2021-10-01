import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileState.dart';
import 'package:the_pet_nest/profiles/bloc/userProfile/userProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/userProfile/userProfileState.dart';
import 'package:the_pet_nest/profiles/petProfile/model/editPetArguments.dart';
import 'package:the_pet_nest/profiles/userProfile/component/menu.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => UserProfileBloc(UserProfileState()),
          ),
          BlocProvider(
            create: (_) => PetProfileBloc(PetProfileState()),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('My Profile', style: kAppBarTitleStyle),
            backgroundColor: kAppBackgroundAltGray,
            elevation: 0,
          ),
          backgroundColor: kAppBackgroundAltGray,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 33, horizontal: 20.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (blocContext, state) {
                    return Container(
                        margin: EdgeInsets.only(bottom: 6),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [kContainerBoxShadow],
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            state.imageAddress.isEmpty
                                ? Image.asset(
                                    'assets/images/avatar.png',
                                    height: 72,
                                    width: 72,
                                    fit: BoxFit.fill,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(36),
                                    child: Image.network(
                                      state.imageAddress,
                                      height: 72,
                                      width: 72,
                                      fit: BoxFit.fitWidth,
                                    )),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      height: 1.5),
                                ),
                                Text(
                                  state.email,
                                  style: TextStyle(
                                      color: Color(0xFF232C63),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.5),
                                )
                              ],
                            )),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                          context, kNavigationEditUserprofile)
                                      .then((value) =>
                                          BlocProvider.of<UserProfileBloc>(
                                                  blocContext)
                                              .checkForUserData());
                                },
                                child: SvgPicture.asset(
                                  'assets/images/profile/edit.svg',
                                ))
                          ],
                        ));
                  }),
                  Text(
                    'No of Pets:',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  BlocBuilder<PetProfileBloc, PetProfileState>(
                      builder: (blocContext, state) {
                    if (state.petList == null) {
                      BlocProvider.of<PetProfileBloc>(blocContext).getPetData();
                      return Center(
                          child:
                              CircularProgressIndicator(color: kAppIconColor));
                    } else {
                      int length = 0;
                      if (state.petList != null)
                        length = state.petList!.petDataStore.length;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: state.fetchingPetData ? 1 : 2,
                            childAspectRatio: 3,
                            mainAxisSpacing: 11,
                            crossAxisSpacing: 11),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (state.fetchingPetData) {
                            return Container(
                              decoration: BoxDecoration(
                                  boxShadow: [kContainerBoxShadow],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                  child: SizedBox(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                height: 24,
                                width: 24,
                              )),
                            );
                          } else {
                            if (index == length)
                              return Container(
                                decoration: BoxDecoration(
                                    boxShadow: [kContainerBoxShadow],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, kNavigationAddPetProfile,
                                        arguments:
                                            BlocProvider.of<PetProfileBloc>(
                                                blocContext));
                                  },
                                  child: (Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.add_circle,
                                        color: kAppIconColor,
                                        size: 36,
                                      ),
                                      SizedBox(
                                        width: 11.45,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Add Pet',
                                          style: TextStyle(
                                              color: kTextColorBlue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: kAppIconColor,
                                      )
                                    ],
                                  )),
                                ),
                              );
                            else {
                              EditPetArguments args = EditPetArguments(
                                  petId: state.petList!.petDataStore[index].id
                                      .toString());
                              return Container(
                                decoration: BoxDecoration(
                                    boxShadow: [kContainerBoxShadow],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextButton(
                                  onPressed: () {
                                    BlocProvider.of<PetProfileBloc>(blocContext)
                                        .setId(state
                                            .petList!.petDataStore[index].id);
                                    Navigator.pushNamed(
                                        context, kNavigationPetProfile,
                                        arguments: args);
                                  },
                                  child: (Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      state.petList!.petDataStore[index]
                                                  .images ==
                                              null
                                          ? Image.asset(
                                              'assets/images/profile/dog_avatar.png',
                                              height: 46.16,
                                              width: 46.16,
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(46),
                                              child: Image.network(
                                                state
                                                    .petList!
                                                    .petDataStore[index]
                                                    .images!,
                                                height: 46.16,
                                                width: 46.16,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.petList!.petDataStore[index]
                                              .name!,
                                          style: TextStyle(
                                              color: kTextColorBlue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: kAppIconColor,
                                      )
                                    ],
                                  )),
                                ),
                              );
                            }
                          }
                        },
                        itemCount: length + 1,
                      );
                    }
                  }),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [kContainerBoxShadow],
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 17),
                    margin: EdgeInsets.only(top: 20.22),
                    child: Column(
                      children: [
                        MenuItem(
                          icon: 'assets/images/feedback/location.svg',
                          title: 'Service Address',
                          onClick: () => Navigator.pushNamed(
                              context, kNavigationAddressBook),
                        ),
                        Divider(
                          height: 1,
                        ),
                        MenuItem(
                          icon: 'assets/images/feedback/message_icon.svg',
                          title: 'Messages',
                        ),
                        Divider(
                          height: 1,
                        ),
                        MenuItem(
                          icon: 'assets/images/sidebar/privacyPolicy.svg',
                          title: 'Booking',
                        ),
                        Divider(
                          height: 1,
                        ),
                        MenuItem(
                          icon: 'assets/images/profile/coupons.svg',
                          title: 'Coupons',
                          onClick: () => Navigator.pushNamed(
                              context, kNavigationViewCoupons),
                        ),
                        Divider(
                          height: 1,
                        ),
                        MenuItem(
                          icon: 'assets/images/sidebar/referNearn.svg',
                          title: 'Refer and Earn',
                          onClick: () => Navigator.pushNamed(
                              context, kNavigationReferAndEarn),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [kContainerBoxShadow]),
                    margin: EdgeInsets.only(top: 12.5),
                    child: MenuItem(
                      icon: 'assets/images/sidebar/logout.svg',
                      title: 'Logout',
                    ),
                  ),
                  SizedBox(
                    height: 72,
                  ),
                  Center(
                    child: BlocBuilder<PetProfileBloc, PetProfileState>(
                        builder: (context, state) {
                      return Text(
                        'Version ${state.appVersion}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.5),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
