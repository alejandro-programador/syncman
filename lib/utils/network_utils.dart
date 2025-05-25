import 'dart:async';
import 'dart:io';

class NetworkUtils {
  static final StreamController<bool> _connectivityController = StreamController<bool>.broadcast();
  static Stream<bool> get onConnectivityChanged => _connectivityController.stream;
  static Timer? _timer;

  static void startConnectivityCheck() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) async {
      final hasConnection = await hasInternetConnection();
      _connectivityController.add(hasConnection);
    });
  }

  static void stopConnectivityCheck() {
    _timer?.cancel();
    _timer = null;
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
