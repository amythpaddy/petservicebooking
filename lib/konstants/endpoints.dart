const kUrlLogin = '/customer_registrations/verify_customer';
const kUrlRegisterSendOTP = '/customer_registrations/send_direct_otp';
const kUrlRegisterVerifyOTP = '/customer_registrations/verify_direct_otp';
const kUrlCreateUserWithOTP = '/customer_registrations/create_user_with_otp';
const kUrlLoginVerifyOTP = '/login/verify_otp_and_login';
const kUrlLoginSendOTP = '/customer_registrations/send_otp';
const kUrlUpdateUserData = '/users/update_details';
const kUrlGetUserData = '/users/details';
const kUrlGetPetData = '/customer_pets/user_pets';
const kUrlGetPetBreed = '/pets/breeds';
const kUrlCreatePet = '/customer_pets';
const kUrlUpdatePet = '/customer_pets/';
const kUrlGetStatesAndCities = '/pets/state_cities';
const kUrlGetSavedAddresses = '/users/addresses';
const kUrlAddSavedAddresses = '/users/address';
const kUrlDeleteSavedAddresses = '/users/address';
String kUrlGetGroomingPackageInfo(cityName, petType) =>
    '/leads/grooming_packages?city=$cityName&pet_type=$petType';
String kUrlGetBookedTimeSlots(date, cityId) =>
    '/leads/booked_slots?date=$date&city_id=$cityId';
const kUrlCreateGroomingLead = '/leads/create_grooming_lead';
String kUrlGetCouponsList(serviceType) => '/coupons?service_type=$serviceType';
const kUrlApplyCoupons = '/coupons/validate_coupon';
