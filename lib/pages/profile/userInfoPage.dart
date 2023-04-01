import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/customer.dart';
import 'package:one_water_mobile/services/customerService.dart';
import 'package:one_water_mobile/pages/profile/userImagePage.dart';
import 'package:one_water_mobile/widgets/errorWidgets.dart';
import 'package:one_water_mobile/widgets/loadingWidgets.dart';
import 'package:one_water_mobile/widgets/nullWidgets.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          "ຂໍ້ມູນສ່ວນຕົວ",
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
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: CustomerService().getCustomer(),
          builder: (context, AsyncSnapshot? snapshot) {
            if (snapshot!.hasData) {
              if (snapshot.data.toString() != 'null') {
                Customer? customer = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            InkWell(
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
                                radius: 60,
                                child: customer.image != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(80.0),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: gitLoading!,
                                          image: customer.image!,
                                          fit: BoxFit.cover,
                                          height: 120,
                                          width: 120,
                                        ),
                                      )
                                    : Icon(
                                        Icons.account_circle,
                                        color: colorWhiteGrey,
                                        size: 120,
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                customer.firstName! + ' ' + customer.lastName!),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ຂໍ້ມູນຕິດຕໍ່:",
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "ເບີໂທ: " + customer.phoneNumber!,
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                  ),
                                ),
                                Text(
                                  "ອີເມວ: " + customer.email!,
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ທີ່ຢູ່ Google map",
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(customer.lat!, customer.lng!),
                                  zoom: 15.0,
                                ),
                                markers: <Marker>[
                                  Marker(
                                      markerId: MarkerId('one_water'),
                                      position:
                                          LatLng(customer.lat!, customer.lng!))
                                ].toSet(),
                                onMapCreated:
                                    (GoogleMapController controller) {},
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return NullWidgets();
            } else if (snapshot.hasError) {
              return ErrorWidgets();
            }
            return LoadingWidgets();
          },
        ),
      ),
    );
  }
}
