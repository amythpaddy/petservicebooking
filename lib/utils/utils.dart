import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants/dataAccessors.dart';
import 'package:the_pet_nest/konstants/values.dart';

void showSnackbar(
    {required BuildContext context,
    String message = 'Something went wrong. Try again later.',
    int duration = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: duration),
  ));
}

String getTimeSlot({required String timeSlot}) {
  if (timeSlot == timeSlots[0])
    return '09:00:00';
  else if (timeSlot == timeSlots[1])
    return '11:00:00';
  else if (timeSlot == timeSlots[2])
    return '01:00:00';
  else if (timeSlot == timeSlots[3])
    return '03:00:00';
  else if (timeSlot == timeSlots[4]) return '05:00:00';
  return '00:00:00';
}

Future<bool> isLoggedIn() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.getString(kDataToken) == null)
    return false;
  else
    return true;
}
