class Configss {
  //static const String baseURL = "https://api.faradeiazoapi.xyz";
  static const String baseURL = "https://tset.faradeiazoapi.xyz";
  //static const String fileurl = "https://static.faradeiazoapi.xyz";
  static const String fileurl = "https://static.faradeiazoapi.xyz";

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
  static const String GetProfileOtherUser =
      "/api/v1/Account/GetProfileOtherUser";
  static const String userreport = "/api/v1/Account/UserReport";

  //api asli
  //UserAbandons
  // static const String GetUserAbandon = "/api/v1/Account/GetUserAbandon";
  static const String EditUserAbandon = "/api/v1/Account/AddOrEditUserAbandon";

  //UserVisits
 //  static const String GetLastOtherVisit = "/api/v1/Account/GetLastOtherVisit";
  // static const String GetLastVisit = "/api/v1/Account/GetLastVisit";

//UserVisits
  static const String GetLastOtherVisit = "/api/UserVisits/GetLastOtherVisit";
  static const String GetLastVisit = "/api/UserVisits/GetLastVisit";
  static const String GetUserAbandon = "/api/UserAbandons/GetUserAbandon";
  //Notification
 // static const String notification = "/api/NotificationTokens";
 // static const String deletetokenapi = "/api/NotificationTokens/DeleteToken";

}
