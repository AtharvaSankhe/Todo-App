import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo/repository/authenication_repository/authenication_repository.dart';


class SignUpController extends GetxController{

  static SignUpController  get instance => Get.find() ;

  final email  = TextEditingController();
  final password  = TextEditingController();
  final name  = TextEditingController();
  // final email  = TextEditingController();






  void registerUser(String email , String password, String name){
    AuthenticationRepository.instance.createUserWithEmailAndPassowrd(email, password,name);

  }
  void loginUser(String email , String password){
    AuthenticationRepository.instance.loginUserWithEmailAndPassowrd(email, password);
  }

  void logOut(){
    AuthenticationRepository.instance.logout();
  }

  void resetPassword(String email){
    AuthenticationRepository.instance.passwordReset(email);
  }

  void phoneAuth(String phoneNo){
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }

  void veriftyOTP(String otp){
    AuthenticationRepository.instance.verifyOTP(otp);
  }



}