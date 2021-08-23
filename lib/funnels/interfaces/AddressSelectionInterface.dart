import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';

abstract class AddressSelectionInterface {
  void onAddressSelected(blocContext, Address? address);
  void onAddressSelectionComplete(blocContext);
}
