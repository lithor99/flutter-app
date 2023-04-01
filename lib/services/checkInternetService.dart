import 'package:connectivity/connectivity.dart';

class CheckInternet {
  static bool connectivityState = false;
  static Future<void> checkInternet() async {
    try {
      final conectivityResult = await (Connectivity().checkConnectivity());
      if (conectivityResult == ConnectivityResult.mobile ||
          conectivityResult == ConnectivityResult.wifi) {
        connectivityState = true;
      } else {
        connectivityState = false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
