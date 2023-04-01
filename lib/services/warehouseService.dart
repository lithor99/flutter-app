import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/warehouses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'checkInternetService.dart';

class WareHouseService {
  Future getWarehouses() async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.get(
          Uri.http(serverName, nextUrl + '/warehouses'),
          headers: {'Authorization': 'Bearer ' + token!},
        );

        if (res.statusCode == 200) {
          final List<dynamic>? data = jsonDecode(res.body);
          List<Warehouses>? warehouses = [];
          data!.forEach((warehouse) async {
            warehouses.add(Warehouses.fromJson(warehouse));
          });
          return warehouses;
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
