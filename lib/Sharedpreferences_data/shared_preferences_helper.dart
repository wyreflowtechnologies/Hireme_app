
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _profileIdKey = 'profileId';
  static const String _fullNameKey = 'fullName';
  static const String _uidKey = 'uid';

  // Save profile ID to SharedPreferences
  static Future<void> setProfileId(int profileId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_profileIdKey, profileId);
  }

  // Retrieve profile ID from SharedPreferences
  static Future<int?> getProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_profileIdKey);
  }

  // Save full name to SharedPreferences
  static Future<void> setFullName(String fullName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fullNameKey, fullName);
  }

  // Retrieve full name from SharedPreferences
  static Future<String?> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fullNameKey);
  }

  // Save UID to SharedPreferences
  static Future<void> setUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uidKey, uid);
  }

  // Retrieve UID from SharedPreferences
  static Future<String?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_uidKey);
  }
}
