import 'package:get/get.dart';

class validator{

  void zaban( input , error){
    final alphanumeric = RegExp("[A-Z a-z 0-9]");
    if(alphanumeric.hasMatch(input) == false){
      error = "نام کاربری نمی تواند فارسی باشد.";
    }else{
      error = null;
    }
    if((input).isEmpty){
      error = "نام کاربری نمی تواند خالی باشد.";
    }
  }

}

