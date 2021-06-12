import 'package:flutter/material.dart';
import 'package:the_pet_nest/konstants/colors.dart';

const kContainerBoxShadow = BoxShadow(
  color: Color(0x0c000000),
  blurRadius: 60,
  offset: Offset(0, 4),
);

const kInactiveButtonTextStyle = TextStyle(
    color: Color(0xFF0C0F15),
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5);
const kActiveButtonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5);
const kActiveButtonContainerStyle = BoxDecoration(
    color: kActiveButtonColor,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    boxShadow: [kContainerBoxShadow]);
const kActiveButtonOutlineTextStyle = TextStyle(
    color: kAppIconColor,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5);
const kActiveButtonOutlineContainerStyle = BoxDecoration(
    border: Border(
      top: BorderSide(color: kAppIconColor),
      bottom: BorderSide(color: kAppIconColor),
      left: BorderSide(color: kAppIconColor),
      right: BorderSide(color: kAppIconColor),
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    boxShadow: [kContainerBoxShadow]);

const kAppBarTitleStyle = TextStyle(
    color: kAppIconColor,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.5);
const kTabbedHeadingBlue = BoxDecoration(
    color: kTextColorBlue,
    borderRadius: BorderRadius.all(Radius.circular(42)),
    boxShadow: [kContainerBoxShadow]);
