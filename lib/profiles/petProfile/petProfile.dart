import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/bloc/petProfile/petProfileBloc.dart';
import 'package:the_pet_nest/profiles/petProfile/component/petInfo.dart';

class PetProfile extends StatefulWidget {
  @override
  _PetProfileState createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  String versionNumber = '...';
  void getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionNumber = packageInfo.version;
    });
  }

  @override
  void initState() {
    super.initState();
    getVersionInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundAltGray,
      appBar: AppBar(
        backgroundColor: kAppBackgroundAltGray,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pet Profile',
          style: kAppBarTitleStyle,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [kContainerBoxShadow],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Image.asset('assets/images/profile/dog_avatar.png'),
                    SizedBox(
                      width: 9,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jackey',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 1.5),
                        ),
                        Text(
                          'Labrador dog',
                          style: TextStyle(
                              color: kTextColorBlue,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5),
                        )
                      ],
                    )),
                    SizedBox(
                      width: 9,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, kNavigationEditPetProfile,
                              arguments:
                                  BlocProvider.of<PetProfileBloc>(context));
                        },
                        child: SvgPicture.asset(
                          'assets/images/profile/edit.svg',
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 9.25,
              ),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [kContainerBoxShadow],
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PetInfo(
                      heading: 'Gender',
                      value: 'Male',
                    ),
                    Divider(
                      height: 1,
                    ),
                    PetInfo(
                      heading: 'Age',
                      value: '2 years',
                    ),
                    Divider(
                      height: 1,
                    ),
                    PetInfo(
                      heading: 'Weight',
                      value: '10 Kg',
                    ),
                    Divider(
                      height: 1,
                    ),
                    PetInfo(
                      heading: 'Aggression',
                      value: 'Medium',
                    ),
                    Divider(
                      height: 1,
                    ),
                    PetInfo(
                      heading: 'Vaccinated',
                      value: 'Yes',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250,
              ),
              Center(
                child: Text(
                  'Version $versionNumber',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
