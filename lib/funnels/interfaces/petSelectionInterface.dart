import 'package:the_pet_nest/profiles/model/getPetListModel.dart';

abstract class PetSelectionInterface {
  void petSelected(blocContext, CustomerPet petData);
  void onNoteUpdated(blocContext, String note);
  void onPetSelectionComplete(blocContext);
}
