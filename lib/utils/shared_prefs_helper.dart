import 'package:shared_preferences/shared_preferences.dart';

Future<void> removeItem(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

Future<bool> containsKey(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey(key);
}
