import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/pages/profile/editPasswordPage.dart';
import 'package:one_water_mobile/pages/profile/editUserImagePage.dart';
import 'package:one_water_mobile/pages/profile/editUserInfoPage.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackgroundColor,
        appBar: AppBar(
          backgroundColor: appColor,
          title: Text(
            "ແກ້ໄຂຂໍ້ມູນ",
            style: TextStyle(
              fontFamily: fontFamily,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                height: 60,
                child: Card(
                  child: InkWell(
                    splashColor: appColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUserInfoPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Icon(
                          Icons.person,
                          color: appColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ແກ້ໄຂຂໍ້ມູນສ່ວນຕົວ',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 18,
                            color: fontColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Card(
                  child: InkWell(
                    splashColor: appColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUserImagePage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Icon(
                          Icons.image,
                          color: appColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ປ່ຽນຮູບພາບ',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 18,
                            color: fontColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Card(
                  child: InkWell(
                    splashColor: appColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPasswordPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Icon(
                          Icons.vpn_key_rounded,
                          color: appColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ປ່ຽນລະຫັດຜ່ານ',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 18,
                            color: fontColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
