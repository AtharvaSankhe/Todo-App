import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException, User;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/firebase/curd.dart';
import 'package:todo/screens/taskscreen.dart';
import 'package:todo/screens/verification/login.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance ;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  var verificationId = '';


  Future<void> phoneAuthentication(String phoneNo) async{
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber:'+91'+phoneNo,
        verificationCompleted: (credential) async{
          await _firebaseAuth.signInWithCredential(credential);
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
    var credentials = await _firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp),);
    if(credentials.user != null ){
      Get.offAll(()=>const TasksScreen());
    }else{
      Fluttertoast.showToast(msg: "Can't verify");
    }
  }


  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
}) async {
    // try{
      await _firebaseAuth.signInWithEmailAndPassword(
        email:email,
        password: password,
      );

      Get.offAll(()=>const TasksScreen());

  }

  Future createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
}) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(
        email:email,
        password: password,
      );
      await Crud().createCollection(email: email, name: name);
      Get.offAll(()=>const TasksScreen());

    } on FirebaseAuthException catch (e){
      {
        Fluttertoast.showToast(msg: e.message.toString());
      }
    }
  }


  Future passwordReset(String email) async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(
        email:email,
      );
      Get.snackbar('Password Reset', 'Password reset link sent! Check your email',backgroundColor: Colors.black,colorText: Colors.white60);
    } on FirebaseAuthException catch (e){
      {
        Fluttertoast.showToast(msg: e.message.toString());
      }
    }
  }



  Future<void> signOut() async{
    try{
      await _firebaseAuth.signOut();
      debugPrint('normal signout');
      Get.offAll(()=>const Login());


    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message.toString());
    }
    try{
      await GoogleSignIn().signOut();
      debugPrint('Google  signout');
      Get.offAll(()=>const Login());

    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message.toString());
    }


  }


}