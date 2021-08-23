import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/funnels/model/packageDetailApiResponseModel.dart';
import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';

class FunnelState extends Equatable {
  final double progressIndicator;
  final FunnelScreens currentScreen;
  final bool showError;
  final String errorMessage;
  final String citySlug;
  final PetCategory petCategory;
  final bool closeThisFunnel;
  final Address? address;
  final List<CustomerPet>? petData;
  final List<PackageDetailModel>? packageDetail;
  final double discountPrice;
  final double totalPrice;

  FunnelState(
      {this.progressIndicator = 0,
      this.currentScreen = FunnelScreens.SCREEN_ADDRESS_SELECTION,
      this.showError = false,
      this.errorMessage = "",
      this.citySlug = "",
      this.petCategory = PetCategory.DOG,
      this.closeThisFunnel = false,
      this.address,
      this.petData,
      this.packageDetail,
      this.discountPrice = 0.0,
      this.totalPrice = 0.0});

  FunnelState copyWith(
      {double? progressIndicator,
      FunnelScreens? currentScreen,
      bool? showError,
      String? errorMessage,
      String? citySlug,
      PetCategory? petCategory,
      bool? closeThisFunnel,
      Address? address,
      List<CustomerPet>? petData,
      List<PackageDetailModel>? packageDetail,
      double? discountPrice}) {
    return FunnelState(
        progressIndicator: progressIndicator ?? this.progressIndicator,
        currentScreen: currentScreen ?? this.currentScreen,
        showError: showError ?? false,
        errorMessage: errorMessage ?? "",
        petCategory: petCategory ?? this.petCategory,
        citySlug: citySlug ?? this.citySlug,
        closeThisFunnel: closeThisFunnel ?? false,
        address: address ?? this.address,
        packageDetail: packageDetail ?? this.packageDetail,
        petData: petData ?? this.petData,
        discountPrice: discountPrice ?? this.discountPrice);
  }

  @override
  List<Object?> get props => [
        progressIndicator,
        currentScreen,
        showError,
        errorMessage,
        citySlug,
        petCategory,
        address,
        petData,
        packageDetail,
        discountPrice
      ];
}
