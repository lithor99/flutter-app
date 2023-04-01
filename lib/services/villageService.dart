import 'dart:convert';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'checkInternetService.dart';

class VillageService {
  Future getVillage({String? id}) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.get(
          Uri.http(serverName, nextUrl + '/villages/$id'),
          headers: {'Authorization': 'Bearer ' + token!},
        );
        if (res.statusCode == 200) {
          return jsonDecode(res.body);
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
