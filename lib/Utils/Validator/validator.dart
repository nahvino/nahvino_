class Validator {
  final alphanumeric = RegExp("[A-Z a-z 0-9]");
    void zaban({required String? error, required  dynamic input}) {
    if (alphanumeric.hasMatch(input) == false) {
      error = "نام کاربری نمی تواند فارسی باشد.";
    } else {
      error = null;
    }
    if ((input).isEmpty) {
      error = "نام کاربری نمی تواند خالی باشد.";
    }
  }
}
