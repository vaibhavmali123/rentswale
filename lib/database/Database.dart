import 'package:rentswale/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static SharedPreferences sharedPreferences;

  static initDatabase() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static addTocart(String json) async {
    await sharedPreferences.setString(constants.cartKey, json);
  }

  static String getCart() {
    return sharedPreferences.getString(constants.cartKey);
  }

  static setUserName(String userName) async {
    await sharedPreferences.setString(constants.userName, userName);
  }

  static String getUserName() {
    return sharedPreferences.getString(constants.userName);
  }

  static setUserId(String userId) async {
    await sharedPreferences.setString(constants.userId, userId);
  }

  static String getUserId() {
    return sharedPreferences.getString(constants.userId);
  }

  static setAddres(String address) async {
    await sharedPreferences.setString(constants.address, address);
  }

  static Future<String> getAddres() async {
    return await sharedPreferences.getString(constants.address);
  }

  static logout() async {
    sharedPreferences.clear();
  }

  static setEmail(String email) async {
    await sharedPreferences.setString(constants.email, email);
  }

  static String getEmail() {
    return sharedPreferences.getString(constants.email);
  }

  static String isKycCompleted() {
    return sharedPreferences.getString(constants.kycCompleted);
  }

  static setKycStatus() async {
    await sharedPreferences.setString(constants.kycCompleted, constants.kycCompleted);
  }
}
