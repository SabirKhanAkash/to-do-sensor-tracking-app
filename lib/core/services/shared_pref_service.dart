import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  /// INITIATE SHARED_PREFERENCES
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  /// STRING
  Future<void> setString(String key, String value) async {
    final prefs = await getSharedPrefs();
    prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.getString(key);
  }

  /// INTEGER
  Future<void> setInt(String key, int value) async {
    final prefs = await getSharedPrefs();
    prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.getInt(key);
  }

  /// DOUBLE
  Future<void> setDouble(String key, double value) async {
    final prefs = await getSharedPrefs();
    prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.getDouble(key);
  }

  /// BOOLEAN
  Future<void> setBool(String key, bool? value) async {
    final prefs = await getSharedPrefs();
    prefs.setBool(key, value!);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.getBool(key);
  }

  /// CLEAR DATA
  Future<void> clearData(String key) async {
    final prefs = await getSharedPrefs();
    prefs.remove(key);
  }

  Future<void> clearAllData() async {
    final prefs = await getSharedPrefs();
    prefs.clear();
  }
}
