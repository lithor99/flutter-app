import 'dart:convert';
import 'package:one_water_mobile/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:one_water_mobile/models/products.dart';
import 'checkInternetService.dart';

class ProductService {
  Future getProducts() async {
    try {
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res = await http.get(Uri.http(serverName, nextUrl + '/products'));
        print('products:------>>>>>${res.body}');
        if (res.statusCode == 200) {
          final List<dynamic>? data = jsonDecode(res.body);
          List<Products>? products = [];
          data!.forEach((product) {
            products.add(Products.fromJson(product));
          });
          print('products:------>>>>>$products');
          return products;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future getProduct({String? id}) async {
    try {
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        var res =
            await http.get(Uri.http(serverName, nextUrl + '/products/$id'));

        if (res.statusCode == 200) {
          return Products.fromJson(jsonDecode(res.body));
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
