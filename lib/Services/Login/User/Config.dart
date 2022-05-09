class Config {
  static const String appName = "Nahvino";
  static const String baseURL = "https://api.nahvino.ir";
  static const String fileurl = "https://static.nahvino.ir";

  static const String login = "/api/v1/Account/SignIn";
  static const String register = "/api/v1/Account/SignUp";
  static const String otpphone = "/api/v1/Account/PhoneNumber";
  static const String otpvrifay = "/api/v1/Account/CheckCode";
  static const String resendcode = "/api/v1/Account/ReSendCode";
  static const String checkquestionanswer =
      "/api/v1/Account/CheckQuestionAnswer";
  static const String repassword = "/api/v1/Account/ResetPassword";
  static const String editprofileuser = "/api/v1/Account/EditProfileUser";
  static const String getprofileuser = "/api/v1/Account/GetProfileUser";
  static const String GetUserAbandon = "/api/v1/Account/GetUserAbandon";
  static const String GetLastVisit = "/api/v1/Account/GetLastVisit";
  static const String UserSecuritySttingMenus =
      "/api/v1/Account/UserSecuritySttingMenus";
  static const String AddIntroduced = "/api/v1/Account/AddIntroduced";
  static const String NotIntroduced = "/api/v1/Account/NotIntroduced";
  static const String ChangePasswrod = "/api/v1/Account/ChangePasswrod";
  static const String uploadProfileImage = "/api/v1/Account/UploadProfileUser";
  static const String SetPhoneNumber = "/api/v1/Account/SetPhoneNumber";
  static const String ChangePhoneNumber = "/api/v1/Account/ChangePhoneNumber";
  static const String CheckCodeChangePhoneNumber =
      "/api/v1/Account/CheckCodeChangePhoneNumber";
  static const String CheckCodeSetPhoneNumber =
      "/api/v1/Account/CheckCodeSetPhoneNumber";
  static const String EditUserAbandon =
      "/api/v1/Account/AddOrEditUserAbandon";
  static const String GetProfileOtherUser =
      "/api/v1/Account/GetProfileOtherUser";

}