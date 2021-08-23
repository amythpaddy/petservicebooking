import 'package:the_pet_nest/addressBook/model/addressBookModel.dart';
import 'package:the_pet_nest/funnels/model/couponseApiResponseModel.dart';
import 'package:the_pet_nest/funnels/model/packageDetailApiResponseModel.dart';
import 'package:the_pet_nest/profiles/model/getPetListModel.dart';

class CreateOrderRequestModel {
  Lead lead;
  LeadDetails leadDetails;

  CreateOrderRequestModel({required this.lead, required this.leadDetails});
  static Map<String, dynamic> fromUserSelectedData(
      {required Address? address,
      required List<CustomerPet>? customerPet,
      required List<PackageDetailModel>? packageDetail,
      required String date,
      required String time,
      required CouponData? couponData}) {
    List<LeadPetPackagesAttributes> leadPetPackagesAttributes = [];
    for (int i = 0; i < customerPet!.length; i++) {
      LeadPetPackagesAttributes lppa = LeadPetPackagesAttributes(
          customerPetId: customerPet[i].id!,
          packageId: packageDetail![i].id!,
          packageType: 'GroomingPackage');
      leadPetPackagesAttributes.add(lppa);
    }
    Lead lead = Lead(
        location: address!.citySlug,
        appointmentDatetime: '$date $time',
        additionalNote: "",
        leadPetPackagesAttributes: leadPetPackagesAttributes);

    LeadDetails leadDetails = LeadDetails(
        lat: address.lat.toString(),
        lng: address.long.toString(),
        addressId: address.id);
    Map<String, dynamic> request = Map<String, dynamic>();
    request["lead"] = lead.toJson();
    request["lead_details"] = leadDetails.toJson();
    return request;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lead != null) {
      data['lead'] = this.lead.toJson();
    }
    if (this.leadDetails != null) {
      data['lead_details'] = this.leadDetails.toJson();
    }
    return data;
  }
}

class Lead {
  String location;
  String appointmentDatetime;
  String additionalNote;
  List<LeadPetPackagesAttributes> leadPetPackagesAttributes;

  Lead(
      {required this.location,
      required this.appointmentDatetime,
      required this.additionalNote,
      required this.leadPetPackagesAttributes});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['appointment_datetime'] = this.appointmentDatetime;
    data['additional_note'] = this.additionalNote;
    if (this.leadPetPackagesAttributes != null) {
      data['lead_pet_packages_attributes'] =
          this.leadPetPackagesAttributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadPetPackagesAttributes {
  int customerPetId;
  int packageId;
  String packageType;

  LeadPetPackagesAttributes(
      {required this.customerPetId,
      required this.packageId,
      required this.packageType});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_pet_id'] = this.customerPetId;
    data['package_id'] = this.packageId;
    data['package_type'] = this.packageType;
    return data;
  }
}

class LeadDetails {
  String lat;
  String lng;
  int addressId;

  LeadDetails({required this.lat, required this.lng, required this.addressId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address_id'] = this.addressId;
    return data;
  }
}
