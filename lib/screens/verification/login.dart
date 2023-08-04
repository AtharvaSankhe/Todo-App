import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/firebase/curd.dart';
// import 'package:hive/hive.dart';
import 'package:todo/screens/taskscreen.dart';
import 'package:todo/screens/verification/password.dart';
import 'package:todo/screens/verification/phone.dart';
import 'package:todo/screens/verification/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController emailController = TextEditingController();

  signinWithGoogle() async {
    // to sign in
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn() ;
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication ;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    debugPrint(userCredential.user?.displayName);
    if(userCredential.user != null){
      await Crud().createCollection(email: userCredential.user!.email!, name: userCredential.user!.displayName!,image: userCredential.user!.photoURL);
      Get.offAll(()=>const TasksScreen());
    }
    //to sign out

    // await GoogleSignIn().signOut();
    // FirebaseAuth.instance.signOut();

  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.pinkAccent,
          image: DecorationImage(
            image: AssetImage('assets/login/loginBg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 500,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                color: Colors.black.withOpacity(0.25),
                child: Column(
                  children: [
                    SizedBox(
                      height: 55,
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(()=>Password(email: emailController.text,));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Hero(
                          tag: 'text',
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      'OR',
                      style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(1),
                    ),
                    ),
                    const SizedBox(height: 15,),
                    InkWell(
                      onTap: (){
                        signinWithGoogle();
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.g_mobiledata_sharp,size: 40,),
                            SizedBox(width: 35,),
                            Text(
                              'Continue with Google',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Get.to(()=>Phone());
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.phone_android,size: 40,),
                            SizedBox(width: 35,),
                            Text(
                              'Continue with Mobile No.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        Text(
                          "Don't have an account ?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>const SignUp());
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 15,),
                    // const Align(
                    //   alignment: Alignment.bottomLeft,
                    //   child: Text(
                    //     "Forget your password ?",
                    //     style: TextStyle(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
