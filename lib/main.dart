import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/pages/signin/signInPage.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(
        navigateRoute: SignInPage(),
        duration: 2000,
        imageSize: 300,
        imageSrc: appLogo,
        backgroundColor: appBackgroundColor,
      ),
    );
  }
}
