import 'dart:convert';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'checkInternetService.dart';

class UserService {
  Future signIn(String? username, String? password) async {
    try {
      // String token = await StorageManager.readData(USER_TOKEN);
      // String auth = "UPAY $token";
      // var url = Uri.parse("$END_POINT/profiles?type=PROFILE");

      // var response =
      //     await http.get(url, headers: {HttpHeaders.authorizationHeader: auth});

      SharedPreferences? preferences = await SharedPreferences.getInstance();
      Map body = {'userName': username, 'password': password};
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.post(
          Uri.http(serverName, nextUrl + '/auths/user/sign-in'),
          body: body,
        );
        print('signin result:----->>>>>${res.statusCode}');
        if (res.statusCode == 200) {
          var data = await json.decode(res.body);
          preferences.setString('token', data['token']);
          return 'LOGIN_SUCCESS';
        } else if (res.statusCode == 400) {
          return 'USERNAME_OR_PASSWORD_FAILED';
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future changePassword({String? newPassword, String? oldPassword}) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      Map body = {'new_password': newPassword, 'old_password': oldPassword};
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.put(
          Uri.http(serverName, nextUrl + '/auths/user/change-password'),
          headers: {'Authorization': 'Bearer ' + token!},
          body: body,
        );
        if (res.statusCode == 200) {
          return 'Successfuly';
        } else if (res.statusCode == 404) {
          return 'PleaseCheckYourPasswordAgain';
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future rememberUser({String? userName, String? password}) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      bool? rememberUser = preferences.getBool('rememberUser');
      if (rememberUser == null || rememberUser == false) {
        preferences.setBool('rememberUser', false);
        preferences.remove('userName');
        preferences.remove('password');
      } else {
        preferences.setString('userName', userName!);
        preferences.setString('password', password!);
        preferences.setBool('rememberUser', true);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
