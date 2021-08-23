import 'package:equatable/equatable.dart';
import 'package:the_pet_nest/funnels/model/packageDetailApiResponseModel.dart';
import 'package:the_pet_nest/konstants/enums.dart';

class PackageState extends Equatable {
  final PackageType packageType;
  final bool loadingPackagesData;
  PackagesListResponse? packages;
  final int selectedPackageIndex;

  PackageState({
    this.packageType = PackageType.INHOME,
    this.packages,
    this.selectedPackageIndex = -1,
    this.loadingPackagesData = true,
  }) {
    packages = this.packages ?? PackagesListResponse();
  }

  PackageState copyWith({
    PackageType? packageType,
    PackagesListResponse? packages,
    int? selectedPackageIndex,
    bool? loadingPackagesData,
  }) {
    return PackageState(
      packageType: packageType ?? this.packageType,
      packages: packages ?? this.packages,
      selectedPackageIndex: selectedPackageIndex ?? this.selectedPackageIndex,
      loadingPackagesData: loadingPackagesData ?? this.loadingPackagesData,
    );
  }

  PackageState reset() {
    return PackageState(packages: packages, loadingPackagesData: false);
  }

  @override
  List<Object?> get props => [
        packageType,
        packages,
        loadingPackagesData,
        selectedPackageIndex,
      ];
}
