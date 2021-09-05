import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/funnels/model/packageDetailApiResponseModel.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class PackageState extends Equatable {
  final PackageType packageType;
  final ServiceType serviceType;
  final bool loadingPackagesData;
  final PackagesListResponse? packages;
  final int selectedPackageIndex;
  final bool valueAddedExpanded;
  final bool requirementsExpanded;

  PackageState(
      {this.packageType = PackageType.INHOME,
      this.packages,
      this.selectedPackageIndex = -1,
      this.loadingPackagesData = true,
      this.valueAddedExpanded = false,
      this.requirementsExpanded = false,
      this.serviceType = ServiceType.VET});

  PackageState copyWith(
      {PackageType? packageType,
      PackagesListResponse? packages,
      int? selectedPackageIndex,
      bool? loadingPackagesData,
      bool? expandValueAdded,
      bool? expandRequirements,
      ServiceType? serviceType}) {
    return PackageState(
        packageType: packageType ?? this.packageType,
        packages: packages ?? this.packages,
        selectedPackageIndex: selectedPackageIndex ?? this.selectedPackageIndex,
        loadingPackagesData: loadingPackagesData ?? this.loadingPackagesData,
        requirementsExpanded: expandRequirements ?? this.requirementsExpanded,
        valueAddedExpanded: expandValueAdded ?? this.valueAddedExpanded,
        serviceType: serviceType ?? this.serviceType);
  }

  PackageState reset() {
    return PackageState(
        packages: packages,
        loadingPackagesData: false,
        serviceType: ServiceType.VET);
  }

  @override
  List<Object?> get props => [
        packageType,
        packages,
        loadingPackagesData,
        selectedPackageIndex,
        serviceType,
        valueAddedExpanded,
        requirementsExpanded
      ];
}
