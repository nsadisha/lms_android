import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager{
  final _tokenKey = 'access_token';
  final _refreshTokenKey = 'refresh_token';
  final SharedPreferences _prefs;
  static LocalStorageManager? _localStorageManager;

  static Future<LocalStorageManager> getInstance() async {
    if(_localStorageManager == null){
      final sharedPreferences = await SharedPreferences.getInstance();
      _localStorageManager = LocalStorageManager._(sharedPreferences);
    }
    return _localStorageManager!;
  }

  LocalStorageManager._(SharedPreferences sharedPreferences)
  : _prefs = sharedPreferences;

  void setToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }
  void setRefreshToken(String refreshToken) async {
    await _prefs.setString(_refreshTokenKey, refreshToken);
  }
  Future<String> getToken() async {
    return _prefs.getString(_tokenKey)!;
  }
  Future<String> getRefreshToken() async {
    return _prefs.getString(_refreshTokenKey)!;
  }
  Future<bool> isTokenAvailable() async {
    return _prefs.getString(_tokenKey)!.isEmpty;
  }
  Future<void> removeAllTokens() async {
    _prefs.remove(_tokenKey);
    _prefs.remove(_refreshTokenKey);
  }
}