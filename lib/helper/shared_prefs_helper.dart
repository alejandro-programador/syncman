// shared_prefs_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setAppOpenFlag(bool isOpen) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isAppOpen', isOpen);
}

Future<bool> isAppOpen() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isAppOpen') ?? false;
}
