import 'package:the_pet_nest/welcome/models/baseRequestModal.dart';

class LoginRequest extends BaseRequestModel {
  final String destinationType = 'phone';

  LoginRequest(phone) : super(type: 'login_request', number: phone);

  Map<String, dynamic> toJson() =>
      {'phone': number, 'destination_type': destinationType, 'code': code};
}
