import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/taskscreen.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:rive/rive.dart';
// import 'package:todo/Model/task.dart';
import 'package:todo/screens/verification/login.dart';
import 'package:todo/shared_pref.dart';
// import 'package:todo/screens/verification/signup.dart';


Future<void> preCacheImage(BuildContext context) async {
  const String imagePath = "assets/login/loginBg.jpg";

  await precacheImage(const AssetImage(imagePath), context);
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Hive.initFlutter();
  // Hive.registerAdapter(TaskAdapter());
  // await Hive.openBox('mytask');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    preCacheImage(context);
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
        home: Splash(),
    );
  }
}


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // late SharedPreferences _sharedPreferences;
  // bool? isLoggedIn = false;
  // bool? isFirstTime = false;


  void isLogin() async {
    await SharedPreferencesHelper.init();
    var sharedPreferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPreferences.getBool("Login");

    Timer(const Duration(seconds: 5), () async {
      if(isLoggedIn != null){
        if(isLoggedIn){
          debugPrint('isLogged is true');
          AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: SharedPreferencesHelper.getUserEmail(),
            idToken: SharedPreferencesHelper.getUserPassword(),
          );
          UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          debugPrint(userCredential.user?.displayName);
          Get.offAll(()=>const TasksScreen());
        } else{
          debugPrint('isLogged is false');
          Get.offAll(()=>const Login());
        }
      }else{
        debugPrint('isLogged is null');
        Get.offAll(()=>const Login());
      }
      // print( _sharedPreferences.getBool("Login"));

    });


  }

  @override
  void initState() {

    isLogin();
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    preCacheImage(context);
    return const Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Center(
        child: Text('FUCK OFF'),
        // child: RiveAnimation.asset('assets/login/animation.riv'),
      ),
    );
  }
}


