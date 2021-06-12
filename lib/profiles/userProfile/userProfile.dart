import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';
import 'package:the_pet_nest/konstants/colors.dart';
import 'package:the_pet_nest/konstants/paths.dart';
import 'package:the_pet_nest/konstants/styles.dart';
import 'package:the_pet_nest/profiles/petProfile/model/petData.dart';
import 'package:the_pet_nest/profiles/userProfile/component/menu.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String versionNumber = '...';
  void getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionNumber = packageInfo.version;
    });
    print('getting version info');
  }

  @override
  void initState() {
    super.initState();
    getVersionInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                  margin: EdgeInsets.only(bottom: 6),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [kContainerBoxShadow],
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/avatar.png',
                        height: 72,
                        width: 72,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ayesha Ch',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                height: 1.5),
                          ),
                          Text(
                            'ayeshach@gmail.com',
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
                                context, kNavigationEditUserprofile);
                          },
                          child: SvgPicture.asset(
                            'assets/images/profile/edit.svg',
                          ))
                    ],
                  )),
              Text(
                'No of Pets:',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    mainAxisSpacing: 11,
                    crossAxisSpacing: 11),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == PetData.length)
                    return Container(
                      decoration: BoxDecoration(
                          boxShadow: [kContainerBoxShadow],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, kNavigationAddPetProfile);
                        },
                        child: (Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  else
                    return Container(
                      decoration: BoxDecoration(
                          boxShadow: [kContainerBoxShadow],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, kNavigationPetProfile);
                        },
                        child: (Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/images/profile/dog_avatar.png',
                              height: 46.16,
                              width: 46.16,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                PetData[index]['name'],
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
                },
                itemCount: PetData.length + 1,
              ),
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
                    ),
                    Divider(
                      height: 1,
                    ),
                    MenuItem(
                      icon: 'assets/images/sidebar/referNearn.svg',
                      title: 'Refer and Earn',
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
