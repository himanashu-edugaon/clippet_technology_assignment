import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
   checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SizedBox(
          width: 290,
          height: 50,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Text(
                  "Clippet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Text(
                  "Technology",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkUser() {
    final AuthController authController = Get.find<AuthController>();
    Future.delayed(const Duration(seconds: 2), () async {
      await authController.checkLoginStatus();
    });
  }
}
