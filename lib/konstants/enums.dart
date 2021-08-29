enum UpdateState { IDLE, UPDATING, SUCCESS, FAILED }
enum Aggression { HIGH, MEDIUM, LOW }
enum Gender { MALE, FEMALE, NONE }
enum PetCategory { DOG, CAT }
enum PetPopupScreens {
  SELECT_PET_CATEGORY_SCREEN,
  PET_INFO_PAGE,
  ADDED_PET_PAGE
}
enum AddressType { HOME_ADDRESS, OFFICE_ADDRESS }
enum PackageType { ONLINE, INHOME }
enum FunnelType { PET_GROOMING, PET_TRAINING, VET_SERVICE }
enum FunnelScreens {
  SCREEN_ADDRESS_SELECTION,
  SCREEN_PET_SELECTION,
  SCREEN_PACKAGE_SELECTION,
  SCREEN_SELECT_BOOKING_DETAILS,
  SCREEN_SELECT_DATE_TIME,
  SCREEN_PAYMENT_METHOD,
  SCREEN_BOOKING_CONFIRMED,
  SCREEN_BOOKING_CANCELLED,
  SCREEN_REVIEW_BOOKING_DETAILS,
  SCREEN_COUPONS_SELECTION,
  SCREEN_DATE_TIME_SELECTION
}
enum PAYMENT_METHOD { ONLINE, AFTER_SERVICE }
enum BookingType { HISTORY, ONGOING }
