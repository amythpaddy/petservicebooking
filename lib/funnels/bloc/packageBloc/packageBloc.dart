import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageEvent.dart';
import 'package:the_pet_nest/funnels/bloc/packageBloc/packageState.dart';
import 'package:the_pet_nest/funnels/model/packageDetailApiResponseModel.dart';
import 'package:the_pet_nest/konstants/endpoints.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/utils/ApiCaller.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  late PackagesListResponse _packagesListResponse;

  int _selectedPackageIndex = 0;

  PackageBloc(PackageState initialState) : super(initialState);

  void getInHomePackage() async {
    //todo get in home packages via api
  }
  void getOnlinePackage() async {
    //todo get online packages via api
  }

  void getPackageDetail(String city, PetCategory petType) async {
    add(PackageEvent.FETCHING_PACKAGE_LIST);
    var response = await ApiCaller.get(
        kUrlGetGroomingPackageInfo(
            city, petType == PetCategory.DOG ? "dog" : "cat"),
        withToken: true);
    _packagesListResponse = PackagesListResponse.fromJson(response);
    add(PackageEvent.PACKAGE_LIST_FETCHED);
  }

  void updatePackageSelectedIndex(int index) {
    _selectedPackageIndex = index;
    add(PackageEvent.PACKAGE_SELECTED_BY_USER);
  }

  void resetState() {
    add(PackageEvent.RESET_STATE_VALUE);
  }

  @override
  Stream<PackageState> mapEventToState(PackageEvent event) async* {
    if (event == PackageEvent.FETCHING_PACKAGE_LIST) {
      yield state.copyWith(loadingPackagesData: true);
    } else if (event == PackageEvent.PACKAGE_LIST_FETCHED) {
      yield state.copyWith(
          loadingPackagesData: false, packages: _packagesListResponse);
    } else if (event == PackageEvent.PACKAGE_SELECTED_BY_USER) {
      yield state.copyWith(selectedPackageIndex: _selectedPackageIndex);
    } else if (event == PackageEvent.RESET_STATE_VALUE) {
      yield state.reset();
    }
  }
}
