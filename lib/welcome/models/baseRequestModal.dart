abstract class BaseRequestModel {
  final String type;
  final String number;
  String code = '';
  BaseRequestModel({required this.type, required this.number, this.code = ''});
}
