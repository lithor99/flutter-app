import 'dart:convert';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:one_water_mobile/models/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checkInternetService.dart';

class CartService {
  static String? id;
  static List<String>? productId;
  static List<String>? productName;
  static List<int>? price;
  static List<String>? productImage;
  static List<int>? orderQty;
  static int orderTotal = 0;
  static int amount = 0;
  static int? itemsLength = 0;

  Future addCart({
    required String? productId,
    required String? quantity,
    required String? price,
  }) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      Map body = {
        'product': productId,
        'quantity': quantity,
        'price': price,
      };
      print('add card:----->>>>>$body');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.post(
          Uri.http(serverName, nextUrl + '/carts'),
          body: body,
          headers: {'Authorization': 'Bearer ' + token!},
        );

        if (res.statusCode == 201) {
          return Cart.fromJson(jsonDecode(res.body));
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getCart() async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        CartService.orderTotal = 0;
        CartService.amount = 0;
        var res = await http.get(
          Uri.http(serverName, nextUrl + '/carts'),
          headers: {'Authorization': 'Bearer ' + token!},
        );
        if (res.statusCode == 200) {
          var cart = jsonDecode(res.body);
          List<dynamic>? items = cart['items'];
          CartService.orderTotal = 0;
          CartService.amount = 0;

          for (int i = 0; i < items!.length; i++) {
            CartService.orderTotal +=
                int.parse(items[i]['quantity'].toString());
            CartService.amount += int.parse(items[i]['quantity'].toString()) *
                int.parse(items[i]['price'].toString());
          }
          return jsonDecode(res.body);
        } else if (res.statusCode == 400) {
          Map body = {
            "_id": "",
            "user": "",
            "items": [],
          };
          return jsonDecode(jsonEncode(body));
        }
        return null;
      } else
        return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future removeCart({String? id}) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.delete(
          Uri.http(serverName, nextUrl + '/carts/$id'),
          headers: {'Authorization': 'Bearer ' + token!},
        );
        if (res.statusCode == 201) {
          return jsonDecode(res.body);
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future removeItem({String? id}) async {
    try {
      SharedPreferences? preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        Map body = {'productId': id};
        var res = await http.delete(
          Uri.http(serverName, nextUrl + '/carts/items'),
          headers: {'Authorization': 'Bearer ' + token!},
          body: body,
        );
        // if (res.statusCode == 201) {
        //   return jsonDecode(res.body);
        // }
        return jsonDecode(res.body);
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
