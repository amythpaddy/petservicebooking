import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';
import 'package:the_pet_nest/welcome/models/loginDataModel.dart';

void login(LoginRequest request) {
  ApiCaller.post(kUrlLogin, request.toJson()).then((value) => print(value));
}
