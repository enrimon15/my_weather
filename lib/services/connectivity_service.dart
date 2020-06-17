import 'package:connectivity/connectivity.dart';

class ConnectionService {

  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    //check if there is connection
    if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      return false;
    }
    return true;
  }
}