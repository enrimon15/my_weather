import 'package:connectivity/connectivity.dart';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';

class ConnectionService {

  Future<bool> checkConnection() async {
    return kIsWeb ? await _checkWebConnection() : await _checkMobileConnection();
  }

  Future<bool> _checkWebConnection() async {
    bool webConn = await html.window.navigator.onLine;
    return webConn;
  }

  Future<bool> _checkMobileConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    //check if there is connection
    if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      return false;
    }
    return true;
  }
}