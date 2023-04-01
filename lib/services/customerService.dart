// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'checkInternetService.dart';

class CustomerService {
  Future getCustomer() async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      Map<String, dynamic> decodeToken = JwtDecoder.decode(token!);
      String? id = await decodeToken['_id'];
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.get(
          Uri.http(serverName, nextUrl + '/customers/profile/$id'),
          headers: {'Authorization': 'Bearer ' + token},
        );
        print('user info:----->>>>${res.body}');
        if (res.statusCode == 200) {
          if (res.body.toString() != 'null') {
             print('user info:----->>>>${Customer.fromJson(jsonDecode(res.body))}');
            return Customer.fromJson(jsonDecode(res.body));
          }
          return 'null';
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateCustomer({
    String? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
  }) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        Map body = {
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'email': email
        };
        var res = await http.put(
          Uri.http(serverName, nextUrl + '/customers/profile/$id'),
          headers: {'Authorization': 'Bearer ' + token!},
          body: body,
        );
        if (res.statusCode == 201) {
          return ('Successful');
        }
        return ('Update failed');
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadImage({
    String? id,
    File? image,
  }) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var request = http.MultipartRequest(
          'PUT',
          Uri.http(serverName, nextUrl + '/customers/profile/image/$id'),
        );
        request.headers['Authorization'] = 'Bearer ' + token!;
        request.files
            .add(await http.MultipartFile.fromPath('image', image!.path));

        var res = await request.send();
        if (res.statusCode == 201) {
          return ('Successful');
        }
        return ('Upload failed');
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
