import 'package:househunter/Models/AppConstants.dart';
import 'package:househunter/Models/userObjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static String preferenceIsUserLoggedIn = "ISLOGGEDIN";
  static String preferenceUserID = "USERID";

  // saving data to shared preference
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(preferenceIsUserLoggedIn, isUserLoggedIn);
  }

  static Future<bool> saveUserIdSharedPreference(String id) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(preferenceUserID, id);
  }

  // get data from shared preference
  static Future<bool> getUserLoggedIn() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(preferenceIsUserLoggedIn);
  }

  static Future<String> getUserId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(preferenceUserID);
  }

}