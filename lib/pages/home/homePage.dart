import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/pages/order/orderingPage.dart';
import 'package:one_water_mobile/pages/product/productPage.dart';
import 'package:one_water_mobile/pages/profile/profilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;
  final List<Widget> selectPage = [
    OrderingPage(),
    ProductPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Container(
            height: 50,
            decoration: BoxDecoration(
              color: errorColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                'ກົດອີກຄັ້ງເພື່ອອອກຈາກລະບົບ',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 16,
                  color: whiteColor,
                ),
              ),
            ),
          ),
          duration: Duration(milliseconds: 2000),
          backgroundColor: appBackgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: selectPage[index],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.list_alt),
            title: Text(
              'ລາຍການສັ່ງຊື້',
              style: TextStyle(
                fontFamily: fontFamily,
                color: fontColor,
              ),
            ),
            textAlign: TextAlign.center,
            inactiveColor: appColor,
            activeColor: appColor!,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'ໜ້າຫຼັກ',
              style: TextStyle(
                fontFamily: fontFamily,
                color: fontColor,
              ),
            ),
            textAlign: TextAlign.center,
            inactiveColor: appColor,
            activeColor: appColor!,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'ຂໍ້ມູນຜູ້ໃຊ້',
              style: TextStyle(
                fontFamily: fontFamily,
                color: fontColor,
              ),
            ),
            textAlign: TextAlign.center,
            inactiveColor: appColor,
            activeColor: appColor!,
          )
        ],
        animationDuration: Duration(milliseconds: 500),
        containerHeight: 55,
        iconSize: 30,
        selectedIndex: index,
        onItemSelected: (int value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
