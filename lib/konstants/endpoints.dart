import 'package:the_pet_nest/konstants/enums.dart';
import 'package:the_pet_nest/konstants/values.dart';

const kUrlLogin = '/v1/customer_registrations/verify_customer';
const kUrlRegisterSendOTP = '/v1/customer_registrations/send_direct_otp';
const kUrlRegisterVerifyOTP = '/v1/customer_registrations/verify_direct_otp';
const kUrlCreateUserWithOTP = '/v1/customer_registrations/create_user_with_otp';
const kUrlLoginVerifyOTP = '/v1/login/verify_otp_and_login';
const kUrlLoginSendOTP = '/v1/customer_registrations/send_otp';
const kUrlUpdateUserData = '/v1/users/update_details';
const kUrlGetUserData = '/v1/users/details';
const kUrlGetPetData = '/v1/customer_pets/user_pets';
const kUrlGetPetBreed = '/v1/pets/breeds';
const kUrlCreatePet = '/v1/customer_pets';
String kUrlUpdatePet(petId) => '/v1/customer_pets/$petId';
String kUrlGetSinglePetData(petId) => '/v1/customer_pets/$petId';
const kUrlGetStatesAndCities = '/v1/pets/state_cities';
const kUrlGetSavedAddresses = '/v1/users/addresses';
const kUrlAddSavedAddresses = '/v1/users/address';
String kUrlEditSavedAddresses(addressId) =>
    '/v1/users/update_address?address_id=$addressId';
String kUrlDeleteSavedAddresses(addressId) =>
    '/v1/users/update_address?address_id=$addressId';
String kUrlGetGroomingPackageInfo(cityName, petType) {
  String pet = petType == PetCategory.DOG ? "dog" : "cat";
  return '/v1/leads/grooming_packages?city=$cityName&pet_type=$pet';
}

String kUrlGetTrainingPackageInfo(cityName, petType) {
  String pet = petType == PetCategory.DOG ? "dog" : "cat";
  return '/v1/leads/dog_training_packages?city=$cityName';
}

String kUrlGetVetPackageInfo(cityId, petType, serviceType) {
  int pet = petType == PetCategory.DOG ? 1 : 2;
  return '/v1/leads/vet_packages?city_id=$cityId&service_type=$serviceType&category_id=$pet';
}

String kUrlGetBookedTimeSlots(date, cityId,leadType){
  String leadCategory='';
  switch(leadType){
    case kLeadTypeGrooming:
      leadCategory=kLeadValueForGrooming;
      break;
    case kLeadTypeTraining:
      leadCategory=kLeadValueForTraining;
      break;
    default:
      leadCategory=kLeadValueForVet;
  }
    return '/v1/$leadCategory/booked_slots?date=$date&city_id=$cityId';
}
const kUrlCreateGroomingLead = '/v1/grooming_leads';
const kUrlCreateTrainingLead = '/v1/dog_training_leads';
const kUrlCreateVetLead = '/v1/vet_leads';
String kUrlGetCouponsList(serviceType) =>
    '/v1/coupons?service_type=$serviceType';
const kUrlApplyCoupons = '/v1/coupons/validate_coupon';
String kUrlUpdateBookingDetail(leadId,leadType){
  String leadCategory='';
  switch(leadType){
    case kLeadTypeGrooming:
      leadCategory=kLeadValueForGrooming;
      break;
    case kLeadTypeTraining:
      leadCategory=kLeadValueForTraining;
      break;
    default:
      leadCategory=kLeadValueForVet;
  }
  return '/v1/$leadCategory/$leadId';}
String kUrlGetBookingDetail(leadId,leadType){
  String leadCategory='';
  switch(leadType){
    case kLeadTypeGrooming:
      leadCategory=kLeadValueForGrooming;
      break;
    case kLeadTypeTraining:
      leadCategory=kLeadValueForTraining;
      break;
    default:
      leadCategory=kLeadValueForVet;
  }
  return '/v1/$leadCategory/$leadId';}
String kUrlGetBookings(pageNumber) => '/v1/leads/orders?page=$pageNumber';
String kUrlCancelBooking(leadId,leadType){
  String leadCategory='';
  switch(leadType){
    case kLeadTypeGrooming:
      leadCategory=kLeadValueForGrooming;
      break;
    case kLeadTypeTraining:
      leadCategory=kLeadValueForTraining;
      break;
    default:
      leadCategory=kLeadValueForVet;
  }
  return '/v1/$leadCategory/$leadId/cancel_lead';
  }
String kUrlGetFeedbackContent(leadId) => '/v1/feedbacks/order_feedback/$leadId';
String kUrlPostFeedbackContent(leadId) =>
    '/v1/feedbacks/order_feedback/$leadId';
String kUrlGetFeedbackQuestions(leadId) => '/v1/feedbacks/qna/$leadId';
const kUrlGetHomeData = '/v2/home/details';
const kUrlUploadUserImage = '/v1/users/upload_photo';
String kUrlUploadPetImage(petId)=>'/v1/customer_pets/$petId/upload_photo';
