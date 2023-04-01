// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/customer.dart';
import 'package:one_water_mobile/pages/cart/cartPage.dart';
import 'package:one_water_mobile/pages/expence/expenceFilterPage.dart';
import 'package:one_water_mobile/pages/order/orderHistoryPage.dart';
import 'package:one_water_mobile/pages/profile/editUserPage.dart';
import 'package:one_water_mobile/pages/profile/userInfoPage.dart';
import 'package:one_water_mobile/pages/warehouse/warehousePage.dart';
import 'package:one_water_mobile/services/cartService.dart';
import 'package:one_water_mobile/services/customerService.dart';
import 'package:one_water_mobile/widgets/alertDialogWidget.dart';
import 'package:one_water_mobile/pages/profile/userImagePage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var customerInfo;

  Future refresh() async {
    await CartService().getCart();
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    refresh();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: Text(
          'ຂໍ້ມູນຜູ້ໃຊ້',
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
        centerTitle: true,
        backgroundColor: appColor,
        actions: [
          Badge(
            badgeContent: Text(
              CartService.orderTotal.toString(),
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 10.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            toAnimate: false,
            badgeColor: Colors.red,
            position: BadgePosition.topEnd(top: 0, end: 0),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              iconSize: 28,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (value) => CartPage()),
                ).then((value) => setState(() {}));
              },
            ),
          ),
          SizedBox(width: 5)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                future: CustomerService().getCustomer(),
                builder: (context, AsyncSnapshot? snapshot) {
                  if (snapshot!.hasData) {
                    if (snapshot.data.toString() != 'null') {
                      Customer? customer = snapshot.data;
                      return Center(
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              child: InkWell(
                                onTap: customer!.image != null
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (vale) => ShowUserImage(
                                              image: customer.image,
                                            ),
                                          ),
                                        );
                                      }
                                    : () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: appColor,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'ບໍ່ມີຮູບພາບ',
                                                  style: TextStyle(
                                                    fontFamily: fontFamily,
                                                    fontSize: 16,
                                                    color: whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 1000),
                                            backgroundColor: appBackgroundColor,
                                          ),
                                        );
                                      },
                                child: CircleAvatar(
                                  backgroundColor: appColor1,
                                  radius: 80,
                                  child: customer.image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: gitLoading!,
                                            image: customer.image!,
                                            fit: BoxFit.cover,
                                            height: 160,
                                            width: 160,
                                            
                                          ),
                                        )
                                      : Icon(
                                          Icons.account_circle,
                                          color: colorWhiteGrey,
                                          size: 160,
                                        ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              child: Text(
                                customer.firstName! + ' ' + customer.lastName!,
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 18,
                                  color: fontColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            child: InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: appColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'ບໍ່ມີຮູບພາບ',
                                          style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 16,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 1000),
                                    backgroundColor: appBackgroundColor,
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: appColor1,
                                radius: 80,
                                child: Icon(
                                  Icons.account_circle,
                                  color: colorWhiteGrey,
                                  size: 160,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30)
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            child: Center(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: appColor1,
                                    radius: 80,
                                    child: Icon(
                                      Icons.account_circle,
                                      color: colorWhiteGrey,
                                      size: 160,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30)
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          child: CircleAvatar(
                            backgroundColor: appColor1,
                            radius: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(160.0),
                              child: Image(
                                image: AssetImage(gitLoading!),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.business_rounded,
                                size: 80,
                                color: appColor,
                              ),
                              Text(
                                "ສາງ",
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WareHousePage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 80,
                                color: appColor,
                              ),
                              Text(
                                "ແກ້ໄຂຂໍ້ມູນ",
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUserPage(),
                            ),
                          ).then((value) => setState(() {}));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person,
                                size: 80,
                                color: appColor,
                              ),
                              Text(
                                "ຂໍ້ມູນສ່ວນຕົວ",
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfilePage(),
                            ),
                          ).then((value) => setState(() {}));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderHistoryPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.history,
                                size: 80,
                                color: appColor,
                              ),
                              Text(
                                "ປະຫວັດສັ່ງຊື້",
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.payment,
                                size: 80,
                                color: appColor,
                              ),
                              Text(
                                "ລາຍຈ່າຍ",
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExpenceFilterPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 80,
                                color: errorColor,
                              ),
                              Text(
                                "ອອກຈາກລະບົບ",
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          ChoiceDialog(
                            icon: Icons.warning_rounded,
                            iconColor: Colors.orange,
                            title: 'ທ່ານກຳລັງອອກຈາກລະບົບ',
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                            onOk: () async {
                              Navigator.of(context).pop();
                              exit(0);
                            },
                          ).showChoice(context);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
