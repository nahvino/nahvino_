class ProfileConfig {
  static const String editprofileuser = "/api/v1/Account/EditProfileUser";
  static const String getprofileuser = "/api/v1/Account/GetProfileUser";
  static const String uploadProfileImage = "/api/v1/Account/UploadProfileUser";
  //UserAbandons
  //static const String GetUserAbandon = "/api/v1/Account/GetUserAbandon";
  static const String GetUserAbandon = "/api/UserAbandons/GetUserAbandon";
  static const String EditUserAbandon =
      "/api/UserAbandons/AddOrEditUserAbandon";
  //static const String EditUserAbandon = "/api/v1/Account/AddOrEditUserAbandon";

  //static const String GetLastVisit = "/api/v1/Account/GetLastVisit";
  static const String GetLastVisit = "/api/UserVisits/GetLastVisit";
}
