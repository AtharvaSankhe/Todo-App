import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/firebase/curd.dart';
import 'package:todo/screens/taskscreen.dart';
import 'package:todo/screens/verification/login.dart';


class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance ;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser =  Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user){
    user==null? Get.offAll(()=>const Login()):Get.offAll(()=>const TasksScreen());
  }

  Future<void> createUserWithEmailAndPassowrd(String email, String password, String name) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(()=>const TasksScreen()):Get.offAll(()=>const Login());
      await Crud().createCollection(email: email, name: name);



      // _firebaseFirestore.collection('users').doc(firebaseUser.value!.email).set(
      //     {'email': email, 'name': name, 'imagePath': '', 'password':password});

    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }
  Future<void> loginUserWithEmailAndPassowrd(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(()=>const TasksScreen()):Get.offAll(()=>const Login());

    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  Future<void> logout() async {
    try{
      await _auth.signOut();
      Get.offAll(()=>const Login());
    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  Future passwordReset(String email) async{
    try{
      await _auth.sendPasswordResetEmail(
        email:email,
      );
      Get.snackbar('Password Reset', 'Password reset link sent! Check your email',backgroundColor: Colors.black,colorText: Colors.white60);
    } on FirebaseAuthException catch (e){
      {
        Fluttertoast.showToast(msg: e.message.toString());
      }
    }
  }


  var verificationId = '';


  Future<void> phoneAuthentication(String phoneNo) async{
    await _auth.verifyPhoneNumber(
        phoneNumber:'+91$phoneNo',
        verificationCompleted: (credential) async{
          await _auth.signInWithCredential(credential);
        },
        codeSent: (verificationId,resendToken){
          verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
          verificationId = verificationId;
        },
        verificationFailed: (e){
          Fluttertoast.showToast(msg: '${e.message}');
        }
    );
  }


  Future<void> verifyOTP(String otp) async{
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp),);
    if(credentials.user != null ){
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool('Login', true) ;
      Get.offAll(()=>const TasksScreen());
    }else{
      Fluttertoast.showToast(msg: "Can't verify");
    }
  }

}