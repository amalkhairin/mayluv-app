import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static addString({String key, String value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }
  static addInt({String key, int value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }
  static addBool({String key, bool value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }
  static getData({String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }
  static delete({String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
  static clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}