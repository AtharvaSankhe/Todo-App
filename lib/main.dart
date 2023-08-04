import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:rive/rive.dart';
// import 'package:todo/Model/task.dart';
import 'package:todo/screens/verification/login.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Get.offAll(()=>const Login());
    });
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


