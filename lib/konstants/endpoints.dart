import 'package:the_pet_nest/konstants/enums.dart';

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
const kUrlUpdatePet = '/v1/customer_pets/';
const kUrlGetStatesAndCities = '/v1/pets/state_cities';
const kUrlGetSavedAddresses = '/v1/users/addresses';
const kUrlAddSavedAddresses = '/v1/users/address';
const kUrlDeleteSavedAddresses = '/v1/users/address';
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

String kUrlGetBookedTimeSlots(date, cityId) =>
    '/v1/leads/booked_slots?date=$date&city_id=$cityId';
const kUrlCreateGroomingLead = '/v1/leads/create_grooming_lead';
const kUrlCreateTrainingLead = '/v1/leads/create_training_lead';
String kUrlGetCouponsList(serviceType) =>
    '/v1/coupons?service_type=$serviceType';
const kUrlApplyCoupons = '/v1/coupons/validate_coupon';
String kUrlUpdateBookingDetail(leadId) => '/v1/leads/$leadId';
String kUrlGetBookingDetail(leadId) => '/v1/leads/$leadId';
String kUrlCancelBookingDetail(leadId) => '/v1/leads/$leadId/cancel_lead';
String kUrlGetBookings(pageNumber) => '/v1/leads/orders?page=$pageNumber';
String kUrlGetFeedbackContent(leadId) => '/v1/feedbacks/order_feedback/$leadId';
String kUrlPostFeedbackContent(leadId) =>
    '/v1/feedbacks/order_feedback/$leadId';
const kUrlGetHomeData = '/v2/home/details';
