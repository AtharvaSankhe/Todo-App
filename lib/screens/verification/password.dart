import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/controller/signupController.dart';

// import 'package:get/get.dart';
import 'package:todo/firebase/emailauth.dart';
import 'package:todo/screens/taskscreen.dart';


class Password extends StatefulWidget {

  const Password({Key? key, }) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final SignUpController signUpController = Get.find() ;
  bool isObscure = true;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        // padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/login/loginBg.jpg'),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.55),

                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    color: Colors.black.withOpacity(0.25),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              child: Image(
                                image: AssetImage('assets/login/profile.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Atharva Sankhe',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(1),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  signUpController.email.text,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          child: TextFormField(
                            controller: signUpController.password,
                            cursorColor: Colors.grey,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: isObscure
                                      ? Icon(Icons.visibility_off_outlined,color: Colors.black.withOpacity(0.3),)
                                      : Icon(Icons.visibility_outlined,color: Colors.black.withOpacity(0.3),),
                                  iconSize: 20,
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure ;
                                    });
                                  },
                                ),
                                hintText: 'Password',
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
                          onTap: () async {

                            signUpController.loginUser(signUpController.email.text.trim(), signUpController.password.text.trim());
                            // debugPrint('${widget.email}');
                            // debugPrint(passwordController.text);
                            //
                            // try {
                            //   print('${widget.email}');
                            //   print(passwordController);
                            //   await FirebaseAuth.instance
                            //       .signInWithEmailAndPassword(email: widget.email, password: passwordController.text.trim());
                            //
                            //   var sharedPreferences = await SharedPreferences.getInstance();
                            //   sharedPreferences.setBool('Login', true);
                            //   Get.offAll(() => const TasksScreen());
                            // } on FirebaseAuthException catch (e){
                            //
                            //     debugPrint('${widget.email}');
                            //     debugPrint(passwordController.text);
                            //     Fluttertoast.showToast(msg: e.message.toString());
                            //
                            // }

                            // Auth().signInWithEmailAndPassword(
                            //     email: widget.email,
                            //     password: passwordController.text);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: GestureDetector(
                            onTap: () {
                              signUpController.resetPassword(signUpController.email.text.trim());
                            },
                            child: const Text(
                              "Forget your password ?",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
