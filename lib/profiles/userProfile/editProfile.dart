import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/bloc/userProfile/userProfileBloc.dart';
import 'package:the_pet_nest/profiles/bloc/userProfile/userProfileState.dart';
import 'package:the_pet_nest/profiles/userProfile/component/userDetailInput.dart';

class EditUserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile', style: kAppBarTitleStyle),
        backgroundColor: kAppBackgroundColor,
        elevation: 0,
      ),
      body: BlocProvider(
          create: (_) => UserProfileBloc(UserProfileState()),
          child: BlocListener<UserProfileBloc, UserProfileState>(
              listener: (context, state) {
                if (state.updateState == UpdateState.SUCCESS) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: BlocBuilder<UserProfileBloc, UserProfileState>(
                              builder: (blocContext, state) {
                            print(state.image);
                            return TextButton(
                                onPressed: () =>
                                    BlocProvider.of<UserProfileBloc>(
                                            blocContext)
                                        .selectUserImage(),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    state.image == null
                                        ? Image.asset(
                                            'assets/images/avatar.png',
                                            width: 82,
                                            height: 82,
                                          )
                                        : kIsWeb
                                            ? Image.network(state.image!.path)
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(82),
                                                child: Image.file(
                                                  File(state.image!.path),
                                                  height: 82,
                                                  width: 82,
                                                ),
                                              ),
                                    Container(
                                      height: 82,
                                      width: 82,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Color(0x77000000)),
                                    ),
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: Color(0x77FFFFFF),
                                      size: 20,
                                    )
                                  ],
                                ));
                          }),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        BlocBuilder<UserProfileBloc, UserProfileState>(
                            builder: (context, state) {
                          return state.processing
                              ? CircularProgressIndicator(
                                  color: kAppIconColor,
                                )
                              : Flexible(
                                  child: UserDetailInput(
                                  heading: 'Name',
                                  required: true,
                                  onDataFilled: (name) => context
                                      .read<UserProfileBloc>()
                                      .updateName(name),
                                  value: state.name,
                                ));
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 20.5,
                    ),
                    BlocBuilder<UserProfileBloc, UserProfileState>(
                        builder: (context, state) {
                      return state.processing
                          ? CircularProgressIndicator(
                              color: kAppIconColor,
                            )
                          : UserDetailInput(
                              heading: 'Email',
                              required: true,
                              onDataFilled: (email) => context
                                  .read<UserProfileBloc>()
                                  .updateEmail(email),
                              value: state.email);
                    }),
                    SizedBox(
                      height: 20.5,
                    ),
                    BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        return state.processing
                            ? CircularProgressIndicator(
                                color: kAppIconColor,
                              )
                            : UserDetailInput(
                                heading: 'Phone number',
                                required: true,
                                disabled: true,
                                onDataFilled: (String value) {},
                                value: state.number);
                      },
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: kActiveButtonOutlineContainerStyle,
                              child: Text(
                                'Cancel',
                                style: kActiveButtonOutlineTextStyle,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: BlocBuilder<UserProfileBloc, UserProfileState>(
                            builder: (context, state) {
                              return TextButton(
                                onPressed: () => context
                                    .read<UserProfileBloc>()
                                    .updateData(state.name, state.email),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  decoration: kActiveButtonContainerStyle,
                                  child:
                                      state.updateState == UpdateState.UPDATING
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'Submit',
                                              style: kActiveButtonTextStyle,
                                            ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}
