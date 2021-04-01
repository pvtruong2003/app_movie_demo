import 'package:shared_preferences/shared_preferences.dart';

class StoreData {

  static Future store(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }


  static Future storeUUID(String key, String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, uuid);
  }


  static Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

}
