import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:one_water_mobile/models/orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'checkInternetService.dart';

class OrderService {
  static int amount = 0;

  Future addOrder({
    required List<List>? datas,
    required String? paymentType,
    required int? totalPayment,
  }) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      Map<String, dynamic> decodeToken = JwtDecoder.decode(token!);
      String? id = await decodeToken['_id'];
      List<Map> items = [];
      datas!.forEach((item) {
        items.add({"product": item[0], "quantity": item[1], "price": item[2]});
      });
      Map body = {
        'user': id,
        'items': items,
        'paymentType': paymentType,
        'totalPayment': totalPayment
      };
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.post(
          Uri.http(serverName, nextUrl + '/orders'),
          body: json.encode(body),
          headers: {
            'Authorization': 'Bearer ' + token,
            'Content-Type': 'application/json'
          },
        );
        if (res.statusCode == 201) {
          return 'Success';
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getOrderings() async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.get(
          Uri.http(serverName, nextUrl + '/orders/customer/ordering'),
          headers: {'Authorization': 'Bearer ' + token!},
        );
        print('get ordering:----->>>${res.body}');
        if (res.statusCode == 200) {
          List<dynamic>? data = jsonDecode(res.body);
          List<Orders>? orders = [];
          data!.forEach((order) {
            orders.add(Orders.fromJson(order));
          });
          return orders;
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getOrderHistorys() async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.get(
          Uri.http(serverName, nextUrl + '/orders/customer/history'),
          headers: {'Authorization': 'Bearer ' + token!},
        );
        if (res.statusCode == 200) {
          List<dynamic>? data = jsonDecode(res.body);
          List<Orders>? orders = [];
          data!.forEach((order) {
            orders.add(Orders.fromJson(order));
          });
          return orders;
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getOrderExpences({String? startDate, String? endDate}) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.get(
          Uri.http(serverName, nextUrl + '/orders/filters/$startDate/$endDate'),
          headers: {'Authorization': 'Bearer ' + token!},
        );
        if (res.statusCode == 200) {
          List<dynamic>? data = jsonDecode(res.body);
          List<Orders>? orders = [];
          data!.forEach((order) {
            orders.add(Orders.fromJson(order));
          });
          return orders;
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getOrderById({String? id}) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.get(
          Uri.http(serverName, nextUrl + '/orders/$id'),
          headers: {'Authorization': 'Bearer ' + token!},
        );
        if (res.statusCode == 200) {
          return Orders.fromJson(jsonDecode(res.body));
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
