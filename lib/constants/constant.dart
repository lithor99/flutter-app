import 'package:flutter/material.dart';

//url
//dev
// const String serverName = '3.1.20.154:1001';
//test
// const String serverName = '54.179.173.49:1001';
//production
// const String serverName = '52.221.200.207:1001';
const String serverName = '54.204.253.22:1001';
const String nextUrl = 'api/one-water';

//colors
const Color? fontColor = Color.fromARGB(255, 61, 61, 61);
const Color? labelTextColor = Colors.grey;
const Color? hintTextColor = Colors.grey;
const Color? appColor = Color.fromARGB(255, 45, 52, 141);
const Color? appColor1 = Color.fromARGB(255, 0, 171, 233);
const Color? colorWhiteGrey = Color(0xFFE4E4EE);
const Color? whiteColor = Color.fromARGB(255, 250, 250, 250);
const Color? errorColor = Colors.red;
const Color? successColor = Colors.green;
const Color? appBackgroundColor = Color(0xFFE3F2FD);
const Color? newColor = Color(0xFFF22F06);
const Color? pendingColor = Color(0xFFF98108);
const Color? packedColor = Color(0xFF0879F9);
const Color? shippedColor = Color(0xFF4608F9);
const Color? deliveredColor = Color(0xFF07BD44);
const Color? cancelColor = Color(0xFFF22F06);

//assets
const String? fontFamily = "NotoSans";
const String? appIcon = "assets/images/app_icpn.png";
const String? appLogo = "assets/images/one_water_logo.png";
const String? appQR = "assets/images/one_water_qr.png";
const String? gitLoading = 'assets/images/loading.gif';
const String? onePayQr = 'assets/images/one_pay_qr.jpg';

//strings
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp? regExp = RegExp(p);
