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
  List<String?> _prices = [];

  PackageBloc(PackageState initialState) : super(initialState);

  void getVetPackages(int cityId, PetCategory petCategory) async {
    add(PackageEvent.FETCHING_PACKAGE_LIST);
    add(PackageEvent.VET_PACKAGE_SELECTED);
    var response = await ApiCaller.get(
        kUrlGetVetPackageInfo(cityId, petCategory, 'veterinary_service'),
        withToken: true);
    _packagesListResponse = PackagesListResponse.fromJson(response);
    add(PackageEvent.PACKAGE_LIST_FETCHED);
  }

  void getParentingPackages(int cityId, PetCategory petCategory) async {
    add(PackageEvent.FETCHING_PACKAGE_LIST);
    add(PackageEvent.PARENTING_PACKAGE_SELECTED);

    var response = await ApiCaller.get(
        kUrlGetVetPackageInfo(cityId, petCategory, 'parenting'),
        withToken: true);
    _packagesListResponse = PackagesListResponse.fromJson(response);
    add(PackageEvent.PACKAGE_LIST_FETCHED);
  }

  void closeValueAdded() {
    add(PackageEvent.CLOSE_VALUE_ADDED);
  }

  void expandValueAdded() {
    add(PackageEvent.OPEN_VALUE_ADDED);
  }

  void closeRequirements() {
    add(PackageEvent.CLOSE_REQUIREMENTS);
  }

  void expandRequirements() {
    add(PackageEvent.OPEN_REQUIREMENTS);
  }

  void getPackageDetail(String city, PetCategory petType,
      FunnelType currentFunnel, int? cityId, ServiceType? serviceType) async {
    add(PackageEvent.FETCHING_PACKAGE_LIST);
    if (currentFunnel == FunnelType.PET_GROOMING) {
      var response = await ApiCaller.get(
          kUrlGetGroomingPackageInfo(city, petType),
          withToken: true);
      _packagesListResponse = PackagesListResponse.fromJson(response);
      add(PackageEvent.PACKAGE_LIST_FETCHED);
    } else if (currentFunnel == FunnelType.PET_TRAINING) {
      var response = await ApiCaller.get(
          kUrlGetTrainingPackageInfo(city, petType),
          withToken: true);
      _packagesListResponse = PackagesListResponse.fromJson(response);
      add(PackageEvent.PACKAGE_LIST_FETCHED);
    } else if (currentFunnel == FunnelType.VET_SERVICE) {
      var response = await ApiCaller.get(
          kUrlGetVetPackageInfo(
              cityId,
              petType,
              serviceType == ServiceType.PARENTING
                  ? 'parenting'
                  : 'veterinary_service'),
          withToken: true);
      _packagesListResponse = PackagesListResponse.fromJson(response);
      add(PackageEvent.PACKAGE_LIST_FETCHED);
    }
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
    } else if (event == PackageEvent.OPEN_REQUIREMENTS) {
      yield state.copyWith(expandRequirements: true);
    } else if (event == PackageEvent.OPEN_VALUE_ADDED) {
      yield state.copyWith(expandValueAdded: true);
    } else if (event == PackageEvent.CLOSE_REQUIREMENTS) {
      yield state.copyWith(expandRequirements: false);
    } else if (event == PackageEvent.CLOSE_VALUE_ADDED) {
      yield state.copyWith(expandValueAdded: false);
    } else if (event == PackageEvent.VET_PACKAGE_SELECTED) {
      yield state.copyWith(serviceType: ServiceType.VET);
    } else if (event == PackageEvent.PARENTING_PACKAGE_SELECTED) {
      yield state.copyWith(serviceType: ServiceType.PARENTING);
    } else if (event == PackageEvent.CAT_SELECTED) {
      yield state.copyWith(selectedPet: PetCategory.CAT);
    } else if (event == PackageEvent.DOG_SELECTED) {
      yield state.copyWith(selectedPet: PetCategory.DOG);
    } else if (event ==
        PackageEvent.VET_PACKAGE_PRICE_FETCHED_FOR_DETAIL_PAGE) {
      yield state.copyWith(loadingPackagesData: false, prices: _prices);
    }
  }

  void getCatGroomingPackagesForDetailPage() async {
    add(PackageEvent.CAT_SELECTED);
    add(PackageEvent.FETCHING_PACKAGE_LIST);
    var response = await ApiCaller.get(
        kUrlGetGroomingPackageInfo('deli', PetCategory.CAT),
        withToken: true);
    _packagesListResponse = PackagesListResponse.fromJson(response);
    add(PackageEvent.PACKAGE_LIST_FETCHED);
  }

  void getDogGroomingPackagesForDetailPage() async {
    add(PackageEvent.DOG_SELECTED);
    add(PackageEvent.FETCHING_PACKAGE_LIST);
    var response = await ApiCaller.get(
        kUrlGetGroomingPackageInfo('delhi', PetCategory.DOG),
        withToken: true);
    _packagesListResponse = PackagesListResponse.fromJson(response);
    add(PackageEvent.PACKAGE_LIST_FETCHED);
  }

  void getCatTrainingPackagesForDetailPage() async {
    add(PackageEvent.CAT_SELECTED);
    add(PackageEvent.FETCHING_PACKAGE_LIST);
    var response = await ApiCaller.get(
        kUrlGetTrainingPackageInfo('delhi', PetCategory.CAT),
        withToken: true);
    _packagesListResponse = PackagesListResponse.fromJson(response);
    add(PackageEvent.PACKAGE_LIST_FETCHED);
  }

  void getDogTrainingPackagesForDetailPage() async {
    add(PackageEvent.DOG_SELECTED);
    add(PackageEvent.FETCHING_PACKAGE_LIST);
    var response = await ApiCaller.get(
        kUrlGetTrainingPackageInfo('delhi', PetCategory.DOG),
        withToken: true);
    _packagesListResponse = PackagesListResponse.fromJson(response);
    add(PackageEvent.PACKAGE_LIST_FETCHED);
  }

  void getVetScreedDetailPackages(int cityId) async {
    add(PackageEvent.FETCHING_PACKAGE_LIST);
    var response = await ApiCaller.get(
        kUrlGetVetPackageInfo(cityId, PetCategory.DOG, 'veterinary_service'),
        withToken: true);
    _packagesListResponse = PackagesListResponse.fromJson(response);
    if (_packagesListResponse.data!.length >= 1)
      _prices.add(_packagesListResponse.data![0].price!);
    else
      _prices.add(null);
    if (_packagesListResponse.data!.length >= 2)
      _prices.add(_packagesListResponse.data![1].price!);
    else
      _prices.add(null);

    response = await ApiCaller.get(
        kUrlGetVetPackageInfo(cityId, PetCategory.DOG, 'parenting'),
        withToken: true);
    _packagesListResponse = PackagesListResponse.fromJson(response);
    if (_packagesListResponse.data!.length >= 1)
      _prices.add(_packagesListResponse.data![0].price!);
    else
      _prices.add(null);
    if (_packagesListResponse.data!.length >= 2)
      _prices.add(_packagesListResponse.data![1].price!);
    else
      _prices.add(null);
    add(PackageEvent.VET_PACKAGE_PRICE_FETCHED_FOR_DETAIL_PAGE);
  }
}
