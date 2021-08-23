import 'package:the_pet_nest/funnels/model/packageDetailApiResponseModel.dart';

abstract class PackageSelectionInterface {
  void packageSelected(blocContext, PackageDetailModel packageDetail);
  void onPackageSelectionComplete(
    blocContext,
  );
}
