import 'package:flutter/material.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/warehouses.dart';
import 'package:one_water_mobile/services/districtService.dart';
import 'package:one_water_mobile/services/villageService.dart';
import 'package:one_water_mobile/services/warehouseService.dart';
import 'package:one_water_mobile/widgets/errorWidgets.dart';
import 'package:one_water_mobile/widgets/loadingWidgets.dart';
import 'package:one_water_mobile/widgets/nullWidgets.dart';

class WareHousePage extends StatefulWidget {
  const WareHousePage({Key? key}) : super(key: key);

  @override
  _WareHousePageState createState() => _WareHousePageState();
}

class _WareHousePageState extends State<WareHousePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          "ສາງທັງໝົດ",
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
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: WareHouseService().getWarehouses(),
          builder: (context, AsyncSnapshot? snapshot) {
            if (snapshot!.hasData) {
              if (snapshot.data.length > 0) {
                List<Warehouses>? warehouses = snapshot.data;
                return ListView.builder(
                  itemCount: warehouses!.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: VillageService()
                          .getVillage(id: warehouses[index].village!.id!),
                      builder: (context, AsyncSnapshot? snapshot) {
                        if (snapshot!.hasData) {
                          var village = snapshot.data;
                          return FutureBuilder(
                            future: DistrictService()
                                .getDistrict(id: village['district']['_id']),
                            builder: (context, AsyncSnapshot? snapshot) {
                              if (snapshot!.hasData) {
                                var district = snapshot.data;
                                return Card(
                                  elevation: 0,
                                  child: InkWell(
                                    splashColor: appColor,
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ຊື່ສາງ: " +
                                                warehouses[index].name!,
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: fontColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "ບ້ານ: " +
                                                warehouses[index]
                                                    .village!
                                                    .name!,
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "ເມືອງ: " +
                                                village['district']['name'],
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "ແຂວງ: " +
                                                district['province']['name'],
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "ເບີໂທ: " +
                                                warehouses[index].phoneNumber!,
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "ອີເມວ: " +
                                                warehouses[index].email!,
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: Container(
                                  child: Image.asset(gitLoading!),
                                ),
                              );
                            },
                          );
                        }
                        return Center(
                          child: Container(
                            child: Image.asset(gitLoading!),
                          ),
                        );
                      },
                    );
                  },
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
