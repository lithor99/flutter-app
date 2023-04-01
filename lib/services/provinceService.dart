import 'dart:convert';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:one_water_mobile/models/province.dart';
import 'checkInternetService.dart';

class ProvinceService {
  Future getProvince({String? id}) async {
    try {
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.get(
          Uri.http(serverName, nextUrl + '/provinces/$id'),
        );
        if (res.statusCode == 200) {
          return Province.fromJson(jsonDecode(res.body));
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
