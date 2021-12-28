import 'dart:io';

///THIS SERVICE IS TO CHECk CONNECTION AND RETURN TRUE OR FALSE
class ConnectivityService {
  static bool _isConnected = false;

  ///THIS SERVICE IS TO CHECk CONNECTION AND RETURN TRUE OR FALSE depending on the connection
  static Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
      }
    } on SocketException catch (_) {
      _isConnected = false;
    }
    return _isConnected;
  }
}
