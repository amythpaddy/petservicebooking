import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants/dataAccessors.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/bloc/userProfile/userProfileEvent.dart';
import 'package:the_pet_nest/profiles/bloc/userProfile/userProfileState.dart';
import 'package:the_pet_nest/profiles/model/userDataModel.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class UserProfileBloc extends Bloc<UserProfileEvents, UserProfileState> {
  UserProfileBloc(UserProfileState initialState) : super(initialState) {
    initSharedPreferences();
    checkForUserData();
  }

  UserDataModel? _userData;
  XFile? _image;

  void initSharedPreferences() async {
    _pref = await SharedPreferences.getInstance();
    _email = _pref.getString(kDataUserEmail) ?? '';
    _name = _pref.getString(kDataUserFirstName) ?? '';
    _number = _pref.getString(kDataUserPhone) ?? '';
    add(UserProfileEvents.UPDATE_DATA_FROM_STORE);
  }

  void selectUserImage() async {
    final ImagePicker _picker = ImagePicker();
    _image = await _picker.pickImage(source: ImageSource.gallery);
    Map<String, dynamic> image = Map();
    Uint8List imageByte = await _image!.readAsBytes();
    image["base64_string"] =
        'data:image/jpeg;base64,${base64Encode(imageByte)}';
    Map<String, dynamic> user = Map();
    user["image"] = image;
    Map<String, dynamic> data = Map();
    data["user"] = user;
    print(data.toString());
    var response =
        await ApiCaller.post(kUrlUploadUserImage, data, withToken: true);
    print(response);
    add(UserProfileEvents.IMAGE_SELECTED);
  }

  void checkForUserData() async {
    var value = await ApiCaller.get(kUrlGetUserData, withToken: true);
    ResponseUserDetail userDetail = ResponseUserDetail.fromJson(value);

    _email = userDetail.data!.user!.email!;
    _name = userDetail.data!.user!.firstName!;
    _referralCode = userDetail.data!.user!.referralCode ?? "";
    _imageAddress = userDetail!.data!.user!.image == null
        ? ""
        : userDetail!.data!.user!.image!.imageData!.url!;

    _pref.setString(kDataUserEmail, _email);
    _pref.setString(kDataUserFirstName, _name);
    _pref.setString(kDataUserLastName, userDetail.data!.user!.lastName!);
    _pref.setString(kDataUserReferral, _referralCode);
    _pref.setString(kDataUserImage, _imageAddress);

    add(UserProfileEvents.UPDATE_DATA_FROM_STORE);
  }

  late SharedPreferences _pref;
  late String _email;
  late String _name;
  late String _number;
  late String _referralCode;
  late String _imageAddress;

  void updateEmail(String email) {
    this._email = email;
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email))
      add(UserProfileEvents.EMAIL_VALID);
    else
      add(UserProfileEvents.EMAIL_INVALID);
  }

  void updateName(String name) {
    this._name = name;
    if (name.length > 0)
      add(UserProfileEvents.NAME_VALID);
    else
      add(UserProfileEvents.NAME_INVALID);
  }

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvents event) async* {
    if (event == UserProfileEvents.EMAIL_VALID)
      yield state.copyWith(
          emailValid: true, email: _email, updateState: UpdateState.IDLE);
    else if (event == UserProfileEvents.EMAIL_INVALID)
      yield state.copyWith(
          emailValid: false, email: _email, updateState: UpdateState.IDLE);
    else if (event == UserProfileEvents.NAME_INVALID)
      yield state.copyWith(
          nameValid: false, name: _name, updateState: UpdateState.IDLE);
    else if (event == UserProfileEvents.NAME_VALID)
      yield state.copyWith(
          nameValid: true, name: _name, updateState: UpdateState.IDLE);
    else if (event == UserProfileEvents.SUBMITTED)
      yield state.copyWith(updateState: UpdateState.UPDATING);
    else if (event == UserProfileEvents.UPDATE_FAILED)
      yield state.copyWith(updateState: UpdateState.FAILED);
    else if (event == UserProfileEvents.UPDATE_SUCCESS)
      yield state.copyWith(updateState: UpdateState.SUCCESS);
    else if (event == UserProfileEvents.UPDATE_DATA_FROM_STORE) {
      yield state.copyWith(
          name: _name,
          email: _email,
          number: _number,
          processing: false,
          imageAddress: _imageAddress);
    } else if (event == UserProfileEvents.IMAGE_SELECTED) {
      yield state.copyWith(image: _image);
    }
  }

  void updateData(String firstName, String email) async {
    add(UserProfileEvents.SUBMITTED);
    RequestUserDetailUpdate request =
        RequestUserDetailUpdate(firstName: firstName, email: email);
    var value = await ApiCaller.post(kUrlUpdateUserData, request.toJson(),
        withToken: true);
    _userData = UserDataModel.fromJson(value);
    add(UserProfileEvents.UPDATE_SUCCESS);
  }
}
