// 需要先运行 flutter pub add shared_preferences 添加依赖
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeManager {
  static const String _keyFirstTime = 'is_first_time';
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> isFirstTime() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getBool(_keyFirstTime) ?? true;
  }

  static Future<void> setNotFirstTime() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setBool(_keyFirstTime, false);
  }
}